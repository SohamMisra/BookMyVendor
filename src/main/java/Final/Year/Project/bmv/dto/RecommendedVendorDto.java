package Final.Year.Project.bmv.dto;

import java.math.BigDecimal;
import Final.Year.Project.bmv.entity.VendorService;

/**
 * RecommendedVendorDto includes scoring and reasoning for vendor recommendations.
 */
public class RecommendedVendorDto extends VendorServiceDto {
    public final Double recommendationScore;
    public final String reasoning;
    public final Double acceptanceRate;
    public final Double rejectionRate;
    public final Integer completedJobs;
    public final Double avgResponseTimeHours;

    public RecommendedVendorDto(
            Long vendorServiceId,
            Long serviceId,
            String title,
            String description,
            BigDecimal priceRangeStart,
            BigDecimal priceRangeEnd,
            Integer minGuests,
            Integer maxGuests,
            boolean isAvailable,
            String vendorName,
            BigDecimal vendorRating,
            String vendorCity,
            Long vendorId,
            String businessLogoUrl,
            String externalPlaceId,
            Double recommendationScore,
            String reasoning,
            Double acceptanceRate,
            Double rejectionRate,
            Integer completedJobs,
            Double avgResponseTimeHours
    ) {
        super(vendorServiceId, serviceId, title, description, priceRangeStart, priceRangeEnd, minGuests, maxGuests, isAvailable, vendorName, vendorRating, vendorCity, vendorId, businessLogoUrl, externalPlaceId);
        this.recommendationScore = recommendationScore;
        this.reasoning = reasoning;
        this.acceptanceRate = acceptanceRate;
        this.rejectionRate = rejectionRate;
        this.completedJobs = completedJobs;
        this.avgResponseTimeHours = avgResponseTimeHours;
    }

    public Double getRecommendationScore() { return recommendationScore; }
    public String getReasoning() { return reasoning; }
    public Double getAcceptanceRate() { return acceptanceRate; }
    public Double getRejectionRate() { return rejectionRate; }
    public Integer getCompletedJobs() { return completedJobs; }
    public Double getAvgResponseTimeHours() { return avgResponseTimeHours; }
}
