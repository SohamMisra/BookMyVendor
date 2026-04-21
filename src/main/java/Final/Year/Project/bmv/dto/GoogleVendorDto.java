package Final.Year.Project.bmv.dto;

import java.math.BigDecimal;

/**
 * DTO for Google Places vendors (external vendors from web search).
 * Used for comparison display and reference purposes.
 */
public class GoogleVendorDto {
    private String vendorId;           // google_{place_id}
    private boolean isGooglePlace;
    private String vendorName;
    private String businessName;
    private BigDecimal rating;
    private String city;
    private String location;
    private String formatted_address;
    private BigDecimal priceRangeStart;
    private BigDecimal priceRangeEnd;
    private String businessDescription;
    private String businessLogoUrl;
    private Integer completedJobs;     // Google: user_ratings_total
    private BigDecimal acceptanceRate; // Google: rating/5
    private Integer yearsOfExperience;
    private Integer avgResponseTimeHours;
    private String googlePlaceId;

    public GoogleVendorDto() {}

    public GoogleVendorDto(String vendorId, String vendorName, BigDecimal rating, String city, 
                          String formatted_address, String businessLogoUrl, Integer completedJobs, 
                          String googlePlaceId) {
        this.vendorId = vendorId;
        this.isGooglePlace = true;
        this.vendorName = vendorName;
        this.businessName = vendorName;
        this.rating = rating;
        this.city = city;
        this.formatted_address = formatted_address;
        this.businessDescription = "Rating: " + rating + " • " + completedJobs + " reviews";
        this.businessLogoUrl = businessLogoUrl;
        this.completedJobs = completedJobs;
        this.acceptanceRate = rating != null ? rating.divide(new BigDecimal(5)) : BigDecimal.ZERO;
        this.yearsOfExperience = 0;
        this.avgResponseTimeHours = 24;
        this.googlePlaceId = googlePlaceId;
    }

    // Getters and Setters
    public String getVendorId() { return vendorId; }
    public void setVendorId(String vendorId) { this.vendorId = vendorId; }

    public boolean isGooglePlace() { return isGooglePlace; }
    public void setGooglePlace(boolean googlePlace) { isGooglePlace = googlePlace; }

    public String getVendorName() { return vendorName; }
    public void setVendorName(String vendorName) { this.vendorName = vendorName; }

    public String getBusinessName() { return businessName; }
    public void setBusinessName(String businessName) { this.businessName = businessName; }

    public BigDecimal getRating() { return rating; }
    public void setRating(BigDecimal rating) { this.rating = rating; }

    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public String getFormatted_address() { return formatted_address; }
    public void setFormatted_address(String formatted_address) { this.formatted_address = formatted_address; }

    public BigDecimal getPriceRangeStart() { return priceRangeStart; }
    public void setPriceRangeStart(BigDecimal priceRangeStart) { this.priceRangeStart = priceRangeStart; }

    public BigDecimal getPriceRangeEnd() { return priceRangeEnd; }
    public void setPriceRangeEnd(BigDecimal priceRangeEnd) { this.priceRangeEnd = priceRangeEnd; }

    public String getBusinessDescription() { return businessDescription; }
    public void setBusinessDescription(String businessDescription) { this.businessDescription = businessDescription; }

    public String getBusinessLogoUrl() { return businessLogoUrl; }
    public void setBusinessLogoUrl(String businessLogoUrl) { this.businessLogoUrl = businessLogoUrl; }

    public Integer getCompletedJobs() { return completedJobs; }
    public void setCompletedJobs(Integer completedJobs) { this.completedJobs = completedJobs; }

    public BigDecimal getAcceptanceRate() { return acceptanceRate; }
    public void setAcceptanceRate(BigDecimal acceptanceRate) { this.acceptanceRate = acceptanceRate; }

    public Integer getYearsOfExperience() { return yearsOfExperience; }
    public void setYearsOfExperience(Integer yearsOfExperience) { this.yearsOfExperience = yearsOfExperience; }

    public Integer getAvgResponseTimeHours() { return avgResponseTimeHours; }
    public void setAvgResponseTimeHours(Integer avgResponseTimeHours) { this.avgResponseTimeHours = avgResponseTimeHours; }

    public String getGooglePlaceId() { return googlePlaceId; }
    public void setGooglePlaceId(String googlePlaceId) { this.googlePlaceId = googlePlaceId; }
}
