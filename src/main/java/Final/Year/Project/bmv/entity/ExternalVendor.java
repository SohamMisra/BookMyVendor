package Final.Year.Project.bmv.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

/**
 * Entity to track external vendors (Google Places, etc.) that users interact with.
 * Allows users to bookmark and track external vendors they found through search.
 */
@Entity
@Table(name = "external_vendors", indexes = {
        @Index(name = "idx_user_id", columnList = "user_id"),
        @Index(name = "idx_google_place_id", columnList = "google_place_id")
})
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ExternalVendor {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private Users user;

    private String vendorName;
    private String googlePlaceId;
    private String formatted_address;
    private Double rating;
    private Integer userRatingsTotal;
    private String businessPhotoUrl;
    private String city;
    private String state;
    private String country;

    // Interaction tracking
    private Integer viewCount;           // How many times user viewed this vendor
    private Integer comparisonCount;     // How many times included in comparison
    private Boolean isBookmarked;        // User favorited this vendor
    private String notes;                // User's personal notes about vendor

    @Temporal(TemporalType.TIMESTAMP)
    private LocalDateTime createdAt;
    @Temporal(TemporalType.TIMESTAMP)
    private LocalDateTime updatedAt;
    @Temporal(TemporalType.TIMESTAMP)
    private LocalDateTime lastViewed;
}
