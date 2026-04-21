package Final.Year.Project.bmv.service;

import Final.Year.Project.bmv.dto.RecommendedVendorDto;
import Final.Year.Project.bmv.entity.*;
import Final.Year.Project.bmv.repository.VendorMetricsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;

/**
 * Intelligent vendor recommendation engine using multi-criteria scoring.
 * Scoring priorities: Budget > Rating > Reliability > Responsiveness > Guest Suitability
 */
@Service
public class RecommendationService {

    @Autowired
    private VendorMetricsRepository vendorMetricsRepository;

    /**
     * Scoring weights (must sum to 1.0)
     */
    private static final double BUDGET_WEIGHT = 0.35;
    private static final double RATING_WEIGHT = 0.25;
    private static final double RELIABILITY_WEIGHT = 0.20;
    private static final double RESPONSIVENESS_WEIGHT = 0.10;
    private static final double GUEST_SUITABILITY_WEIGHT = 0.10;

    /**
     * Main recommendation method.
     * 
     * @param vendorServices List of candidate vendors
     * @param budgetMin Minimum budget
     * @param budgetMax Maximum budget
     * @param guestCount Guest count
     * @return Sorted list of recommended vendors with scores
     */
    public List<RecommendedVendorDto> recommendVendors(
            List<VendorService> vendorServices,
            BigDecimal budgetMin,
            BigDecimal budgetMax,
            Integer guestCount
    ) {
        List<VendorScore> scoredVendors = new ArrayList<>();

        for (VendorService vs : vendorServices) {
            VendorProfile vendor = vs.getVendor();
            if (vendor == null) continue;

            // Fetch metrics for this vendor
            VendorMetrics metrics = vendorMetricsRepository
                    .findByVendor_VendorId(vendor.getVendorId())
                    .orElse(null);

            // Calculate individual scores
            double budgetScore = calculateBudgetScore(vs.getPriceRangeStart(), vs.getPriceRangeEnd(), budgetMin, budgetMax);
            double ratingScore = calculateRatingScore(vendor.getRating());
            double reliabilityScore = calculateReliabilityScore(metrics);
            double responsivenessScore = calculateResponsivenessScore(metrics);
            double guestScore = calculateGuestSuitabilityScore(vs.getMinGuests(), vs.getMaxGuests(), guestCount);

            // Weighted composite score
            double totalScore = (budgetScore * BUDGET_WEIGHT) +
                    (ratingScore * RATING_WEIGHT) +
                    (reliabilityScore * RELIABILITY_WEIGHT) +
                    (responsivenessScore * RESPONSIVENESS_WEIGHT) +
                    (guestScore * GUEST_SUITABILITY_WEIGHT);

            String reasoning = generateReasoning(budgetScore, ratingScore, reliabilityScore, responsivenessScore, guestScore);

            VendorScore vs_score = new VendorScore(
                    vs, vendor, metrics, totalScore, reasoning,
                    budgetScore, ratingScore, reliabilityScore, responsivenessScore, guestScore
            );
            scoredVendors.add(vs_score);
        }

        // Sort by score descending
        scoredVendors.sort((a, b) -> Double.compare(b.score, a.score));

        // Convert to DTO and return (at least 3 if available)
        return scoredVendors.stream()
                .limit(Math.max(3, scoredVendors.size()))
                .map(this::toRecommendedVendorDto)
                .collect(Collectors.toList());
    }

    /**
     * Budget Compatibility Score (0-1)
     * Perfect match within budget: 1.0
     * Slightly over: 0.8
     * Way over: 0.3
     * Way under: 0.6
     */
    private double calculateBudgetScore(BigDecimal priceMin, BigDecimal priceMax, BigDecimal budgetMin, BigDecimal budgetMax) {
        if (priceMin == null || priceMax == null || budgetMax == null) {
            return 0.5; // Neutral score if data missing
        }

        BigDecimal midPrice = priceMin.add(priceMax).divide(BigDecimal.valueOf(2), BigDecimal.ROUND_HALF_UP);
        BigDecimal midBudget = budgetMin != null ? budgetMin.add(budgetMax).divide(BigDecimal.valueOf(2), BigDecimal.ROUND_HALF_UP) : budgetMax;

        // If vendor price is within budget range, score high
        if (priceMin.compareTo(budgetMax) <= 0 && priceMax.compareTo(budgetMin != null ? budgetMin : BigDecimal.ZERO) >= 0) {
            return 1.0;
        }

        // If vendor is slightly over budget (logic: less than 20% over max)
        if (priceMin.compareTo(budgetMax) > 0) {
            double overage = priceMin.subtract(budgetMax).doubleValue() / budgetMax.doubleValue();
            if (overage < 0.2) {
                return 0.75;
            }
            if (overage < 0.5) {
                return 0.5;
            }
            return 0.2; // Way over budget
        }

        // If vendor is under budget
        if (priceMax.compareTo(budgetMin != null ? budgetMin : BigDecimal.ZERO) < 0) {
            return 0.6; // Good but may lack features
        }

        return 0.5;
    }

    /**
     * Rating Score (0-1)
     * Maps rating (0-5 stars) to 0-1 score
     */
    private double calculateRatingScore(BigDecimal rating) {
        if (rating == null) {
            return 0.5; // Neutral for unrated vendors
        }
        double r = rating.doubleValue();
        // Normalize 0-5 to 0-1
        return Math.min(1.0, r / 5.0);
    }

    /**
     * Reliability Score (0-1)
     * Based on: acceptanceRate + completedJobs + rejectionRate
     */
    private double calculateReliabilityScore(VendorMetrics metrics) {
        if (metrics == null || metrics.getTotalRequests() == 0) {
            return 0.5; // New vendor gets neutral score
        }

        double acceptanceRate = metrics.getAcceptanceRate() != null ? metrics.getAcceptanceRate() : 0.0;
        double rejectionRate = metrics.getRejectionRate() != null ? metrics.getRejectionRate() : 0.0;
        int completedJobs = metrics.getCompletedJobs() != null ? metrics.getCompletedJobs() : 0;

        // Score components
        double acceptanceScore = acceptanceRate * 0.6;
        double rejectionScore = (1.0 - rejectionRate) * 0.2;
        double experienceScore = Math.min(1.0, completedJobs / 100.0) * 0.2;

        return acceptanceScore + rejectionScore + experienceScore;
    }

    /**
     * Responsiveness Score (0-1)
     * Lower response time = higher score
     */
    private double calculateResponsivenessScore(VendorMetrics metrics) {
        if (metrics == null || metrics.getAvgResponseTimeHours() == null || metrics.getAvgResponseTimeHours() <= 0) {
            return 0.5; // Neutral for unknown
        }

        double responseTimeHours = metrics.getAvgResponseTimeHours();
        // Inverse scoring: less time = higher score
        // 1 hour = 1.0, 24 hours = 0.5, 72+ hours = 0.1
        if (responseTimeHours <= 1) return 1.0;
        if (responseTimeHours <= 6) return 0.85;
        if (responseTimeHours <= 24) return 0.7;
        if (responseTimeHours <= 48) return 0.5;
        if (responseTimeHours <= 72) return 0.3;
        return 0.1;
    }

    /**
     * Guest Suitability Score (0-1)
     * Vendor capacity matches guest count
     */
    private double calculateGuestSuitabilityScore(Integer minGuests, Integer maxGuests, Integer guestCount) {
        if (guestCount == null) {
            return 0.8; // If guest count unknown, give decent score
        }

        // Check if vendor can accommodate
        if ((minGuests == null || guestCount >= minGuests) &&
                (maxGuests == null || guestCount <= maxGuests)) {
            return 1.0; // Perfect fit
        }

        // Slightly outside range
        if (maxGuests != null && guestCount <= maxGuests * 1.1 && guestCount >= maxGuests * 0.9) {
            return 0.7; // Close fit
        }

        // Way outside range
        return 0.3;
    }

    /**
     * Generate concise reasoning for recommendation
     */
    private String generateReasoning(double budgetScore, double ratingScore, double reliabilityScore,
                                     double responsivenessScore, double guestScore) {
        // Find the highest scoring criteria
        TreeMap<Double, String> scores = new TreeMap<>(Collections.reverseOrder());
        scores.put(budgetScore, "Budget-friendly");
        scores.put(ratingScore, "Highly rated");
        scores.put(reliabilityScore, "Reliable");
        scores.put(responsivenessScore, "Fast response");
        scores.put(guestScore, "Right capacity");

        return scores.firstEntry().getValue();
    }

    /**
     * Convert VendorScore to RecommendedVendorDto
     */
    private RecommendedVendorDto toRecommendedVendorDto(VendorScore vs) {
        VendorService vendorService = vs.vendorService;
        VendorProfile vendor = vs.vendor;
        VendorMetrics metrics = vs.metrics;

        return new RecommendedVendorDto(
                vendorService.getVendorServiceId(),
                vendorService.getService().getServiceId(),
                vendorService.getTitle(),
                vendorService.getDescription(),
                vendorService.getPriceRangeStart(),
                vendorService.getPriceRangeEnd(),
                vendorService.getMinGuests(),
                vendorService.getMaxGuests(),
                vendorService.isAvailable(),
                vendor.getBusinessName(),
                vendor.getRating(),
                vendor.getCity(),
                vendor.getVendorId(),
                vendor.getBusinessLogoUrl(),
                null, // externalPlaceId not applicable here
                vs.score,
                vs.reasoning,
                metrics != null ? metrics.getAcceptanceRate() : 0.0,
                metrics != null ? metrics.getRejectionRate() : 0.0,
                metrics != null ? metrics.getCompletedJobs() : 0,
                metrics != null ? metrics.getAvgResponseTimeHours() : 0.0
        );
    }

    /**
     * Internal class to hold scoring details
     */
    private static class VendorScore {
        VendorService vendorService;
        VendorProfile vendor;
        VendorMetrics metrics;
        double score;
        String reasoning;
        double budgetScore;
        double ratingScore;
        double reliabilityScore;
        double responsivenessScore;
        double guestScore;

        VendorScore(VendorService vendorService, VendorProfile vendor, VendorMetrics metrics,
                   double score, String reasoning, double budgetScore, double ratingScore,
                   double reliabilityScore, double responsivenessScore, double guestScore) {
            this.vendorService = vendorService;
            this.vendor = vendor;
            this.metrics = metrics;
            this.score = score;
            this.reasoning = reasoning;
            this.budgetScore = budgetScore;
            this.ratingScore = ratingScore;
            this.reliabilityScore = reliabilityScore;
            this.responsivenessScore = responsivenessScore;
            this.guestScore = guestScore;
        }
    }
}
