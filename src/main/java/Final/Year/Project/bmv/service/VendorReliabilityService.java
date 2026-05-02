package Final.Year.Project.bmv.service;

import Final.Year.Project.bmv.entity.*;
import Final.Year.Project.bmv.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class VendorReliabilityService {

    @Autowired
    private VendorReliabilityScoreRepository reliabilityScoreRepository;

    @Autowired
    private BookingRepository bookingRepository;

    @Autowired
    private ReviewRepository reviewRepository;

    @Autowired
    private VendorProfileRepository vendorProfileRepository;

    public VendorReliabilityScore calculateReliabilityScore(Long vendorId) {
        VendorProfile vendor = vendorProfileRepository.findById(vendorId)
                .orElseThrow(() -> new RuntimeException("Vendor not found"));

        Map<String, BigDecimal> metrics = extractMetrics(vendor);
        BigDecimal score = computeScore(metrics);
        VendorReliabilityScore.RiskLevel riskLevel = determineRiskLevel(score);

        // Calculate total bookings for this vendor
        List<Bookings> allVendorBookings = bookingRepository.findByVendor_VendorId(vendorId);
        Long totalBookings = allVendorBookings != null ? (long) allVendorBookings.size() : 0L;

        VendorReliabilityScore reliabilityScore = VendorReliabilityScore.builder()
                .vendor(vendor)
                .reliabilityScore(score)
                .riskLevel(riskLevel)
                .avgResponseTime(metrics.get("avgResponseTime"))
                .cancellationRate(metrics.get("cancellationRate"))
                .ratingStdDev(metrics.get("ratingStdDev"))
                .totalBookings(totalBookings)
                .satisfactionTrend(metrics.get("satisfactionTrend"))
                .calculatedAt(LocalDateTime.now())
                .lastUpdated(LocalDateTime.now())
                .build();

        return reliabilityScoreRepository.save(reliabilityScore);
    }

    private Map<String, BigDecimal> extractMetrics(VendorProfile vendor) {
        Map<String, BigDecimal> metrics = new HashMap<>();

        List<Bookings> recentBookings = bookingRepository.findRecentByVendor(
                vendor.getVendorId(),
                LocalDateTime.now().minusDays(90)
        );
        // Response Time Metric
        BigDecimal avgResponseTime = calculateAverageResponseTime(recentBookings);
        metrics.put("avgResponseTime", avgResponseTime);

        // Cancellation Rate
        long cancelledCount = recentBookings.stream()
                .filter(b -> b.getBookingStatus() == Bookings.BookingStatus.CANCELLED)
                .count();
        BigDecimal cancellationRate = recentBookings.isEmpty() ? BigDecimal.ZERO :
                new BigDecimal(cancelledCount).divide(new BigDecimal(recentBookings.size()), 2, java.math.RoundingMode.HALF_UP);
        metrics.put("cancellationRate", cancellationRate);

        // Rating Consistency (Standard Deviation)
        BigDecimal ratingStdDev = calculateRatingStdDev(vendor);
        metrics.put("ratingStdDev", ratingStdDev);

        // Satisfaction Trend
        BigDecimal satisfactionTrend = calculateSatisfactionTrend(recentBookings);
        metrics.put("satisfactionTrend", satisfactionTrend);

        return metrics;
    }

    private BigDecimal calculateAverageResponseTime(List<Bookings> bookings) {
        if (bookings.isEmpty()) return BigDecimal.ZERO;

        long totalHours = 0;
        int count = 0;

        for (Bookings booking : bookings) {
            if (booking.getBookingDate() != null && booking.getCreatedAt() != null) {
                long hours = ChronoUnit.HOURS.between(booking.getCreatedAt(), booking.getBookingDate());
                totalHours += hours;
                count++;
            }
        }

        return count == 0 ? BigDecimal.ZERO : new BigDecimal(totalHours).divide(new BigDecimal(count), 2, java.math.RoundingMode.HALF_UP);
    }

    private BigDecimal calculateRatingStdDev(VendorProfile vendor) {
        List<Reviews> reviews = reviewRepository.findByVendor_UserId(vendor.getUser().getUserId());

        if (reviews.isEmpty()) return BigDecimal.ZERO;

        List<Integer> ratings = reviews.stream()
                .map(Reviews::getRating)
                .collect(Collectors.toList());

        double mean = ratings.stream()
                .mapToInt(Integer::intValue)
                .average()
                .orElse(0);

        double variance = ratings.stream()
                .mapToDouble(r -> Math.pow(r - mean, 2))
                .average()
                .orElse(0);

        return new BigDecimal(Math.sqrt(variance)).setScale(2, java.math.RoundingMode.HALF_UP);
    }

    private BigDecimal calculateSatisfactionTrend(List<Bookings> bookings) {
        LocalDateTime thirtyDaysAgo = LocalDateTime.now().minusDays(30);
        LocalDateTime sixtyDaysAgo = LocalDateTime.now().minusDays(60);

        double recentAvg = bookings.stream()
                .filter(b -> b.getUpdatedAt() != null && b.getUpdatedAt().isAfter(thirtyDaysAgo))
                .mapToInt(b -> b.getVendorServiceRequest() != null ? 5 : 0)
                .average()
                .orElse(0);

        double previousAvg = bookings.stream()
                .filter(b -> b.getUpdatedAt() != null &&
                        b.getUpdatedAt().isBefore(thirtyDaysAgo) &&
                        b.getUpdatedAt().isAfter(sixtyDaysAgo))
                .mapToInt(b -> b.getVendorServiceRequest() != null ? 5 : 0)
                .average()
                .orElse(0);

        return new BigDecimal(recentAvg - previousAvg).setScale(2, java.math.RoundingMode.HALF_UP);
    }

    private BigDecimal computeScore(Map<String, BigDecimal> metrics) {
        BigDecimal score = new BigDecimal(100);

        // Response time penalty (max -15 points)
        BigDecimal responseTime = metrics.getOrDefault("avgResponseTime", BigDecimal.ZERO);
        if (responseTime.compareTo(new BigDecimal(24)) > 0) {
            score = score.subtract(new BigDecimal(15));
        } else if (responseTime.compareTo(new BigDecimal(12)) > 0) {
            score = score.subtract(new BigDecimal(10));
        } else if (responseTime.compareTo(new BigDecimal(6)) > 0) {
            score = score.subtract(new BigDecimal(5));
        }

        // Cancellation rate penalty (max -25 points)
        BigDecimal cancellationRate = metrics.getOrDefault("cancellationRate", BigDecimal.ZERO);
        score = score.subtract(cancellationRate.multiply(new BigDecimal(25)));

        // Rating consistency penalty (max -20 points)
        BigDecimal ratingStdDev = metrics.getOrDefault("ratingStdDev", BigDecimal.ZERO);
        if (ratingStdDev.compareTo(new BigDecimal("1.5")) > 0) {
            score = score.subtract(new BigDecimal(20));
        } else if (ratingStdDev.compareTo(new BigDecimal("1.0")) > 0) {
            score = score.subtract(new BigDecimal(10));
        } else if (ratingStdDev.compareTo(new BigDecimal("0.5")) > 0) {
            score = score.subtract(new BigDecimal(5));
        }

        // Satisfaction trend penalty (max -15 points)
        BigDecimal trend = metrics.getOrDefault("satisfactionTrend", BigDecimal.ZERO);
        if (trend.compareTo(new BigDecimal("-0.3")) < 0) {
            score = score.subtract(new BigDecimal(15));
        } else if (trend.compareTo(BigDecimal.ZERO) < 0) {
            score = score.subtract(new BigDecimal(8));
        }

        return score.max(BigDecimal.ZERO).min(new BigDecimal(100));
    }

    private VendorReliabilityScore.RiskLevel determineRiskLevel(BigDecimal score) {
        if (score.compareTo(new BigDecimal(80)) >= 0) return VendorReliabilityScore.RiskLevel.LOW_RISK;
        if (score.compareTo(new BigDecimal(60)) >= 0) return VendorReliabilityScore.RiskLevel.MEDIUM_RISK;
        if (score.compareTo(new BigDecimal(40)) >= 0) return VendorReliabilityScore.RiskLevel.HIGH_RISK;
        return VendorReliabilityScore.RiskLevel.CRITICAL_RISK;
    }

    public VendorReliabilityScore getVendorReliabilityScore(Long vendorId) {
        VendorProfile vendor = vendorProfileRepository.findById(vendorId)
                .orElseThrow(() -> new RuntimeException("Vendor not found"));
        return reliabilityScoreRepository.findByVendor(vendor)
                .orElseGet(() -> calculateReliabilityScore(vendorId));
    }
}

