package Final.Year.Project.bmv.dto;

import java.math.BigDecimal;
import java.util.List;

/**
 * VendorComparisonDto for comparing multiple vendors side-by-side.
 */
public class VendorComparisonDto {
    private final Long vendorId;
    private final String vendorName;
    private final BigDecimal rating;
    private final String city;
    private final BigDecimal priceRangeStart;
    private final BigDecimal priceRangeEnd;
    private final Integer minGuests;
    private final Integer maxGuests;
    private final Double acceptanceRate;
    private final Integer completedJobs;
    private final Double avgResponseTimeHours;
    private final Integer yearsOfExperience;
    private final String businessDescription;
    private final String businessLogoUrl;
    private final List<String> services;

    public VendorComparisonDto(
            Long vendorId,
            String vendorName,
            BigDecimal rating,
            String city,
            BigDecimal priceRangeStart,
            BigDecimal priceRangeEnd,
            Integer minGuests,
            Integer maxGuests,
            Double acceptanceRate,
            Integer completedJobs,
            Double avgResponseTimeHours,
            Integer yearsOfExperience,
            String businessDescription,
            String businessLogoUrl,
            List<String> services
    ) {
        this.vendorId = vendorId;
        this.vendorName = vendorName;
        this.rating = rating;
        this.city = city;
        this.priceRangeStart = priceRangeStart;
        this.priceRangeEnd = priceRangeEnd;
        this.minGuests = minGuests;
        this.maxGuests = maxGuests;
        this.acceptanceRate = acceptanceRate;
        this.completedJobs = completedJobs;
        this.avgResponseTimeHours = avgResponseTimeHours;
        this.yearsOfExperience = yearsOfExperience;
        this.businessDescription = businessDescription;
        this.businessLogoUrl = businessLogoUrl;
        this.services = services;
    }

    // Getters
    public Long getVendorId() { return vendorId; }
    public String getVendorName() { return vendorName; }
    public BigDecimal getRating() { return rating; }
    public String getCity() { return city; }
    public BigDecimal getPriceRangeStart() { return priceRangeStart; }
    public BigDecimal getPriceRangeEnd() { return priceRangeEnd; }
    public Integer getMinGuests() { return minGuests; }
    public Integer getMaxGuests() { return maxGuests; }
    public Double getAcceptanceRate() { return acceptanceRate; }
    public Integer getCompletedJobs() { return completedJobs; }
    public Double getAvgResponseTimeHours() { return avgResponseTimeHours; }
    public Integer getYearsOfExperience() { return yearsOfExperience; }
    public String getBusinessDescription() { return businessDescription; }
    public String getBusinessLogoUrl() { return businessLogoUrl; }
    public List<String> getServices() { return services; }
}
