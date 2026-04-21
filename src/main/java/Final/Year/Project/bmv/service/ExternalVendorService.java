package Final.Year.Project.bmv.service;

import Final.Year.Project.bmv.entity.ExternalVendor;
import Final.Year.Project.bmv.entity.Users;
import Final.Year.Project.bmv.repository.ExternalVendorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class ExternalVendorService {

    @Autowired
    private ExternalVendorRepository externalVendorRepository;

    /**
     * Track a viewed external vendor (increment view count, update last viewed)
     */
    public ExternalVendor trackVendorView(Users user, String googlePlaceId, String vendorName, 
                                          String address, Double rating, Integer reviews, 
                                          String photoUrl, String city) {
        Optional<ExternalVendor> existing = externalVendorRepository.findByUserAndGooglePlaceId(user, googlePlaceId);
        
        ExternalVendor vendor;
        if (existing.isPresent()) {
            vendor = existing.get();
            vendor.setViewCount((vendor.getViewCount() != null ? vendor.getViewCount() : 0) + 1);
        } else {
            vendor = ExternalVendor.builder()
                    .user(user)
                    .googlePlaceId(googlePlaceId)
                    .vendorName(vendorName)
                    .formatted_address(address)
                    .rating(rating)
                    .userRatingsTotal(reviews)
                    .businessPhotoUrl(photoUrl)
                    .city(city)
                    .viewCount(1)
                    .comparisonCount(0)
                    .isBookmarked(false)
                    .createdAt(LocalDateTime.now())
                    .updatedAt(LocalDateTime.now())
                    .build();
        }
        
        vendor.setLastViewed(LocalDateTime.now());
        vendor.setUpdatedAt(LocalDateTime.now());
        return externalVendorRepository.save(vendor);
    }

    /**
     * Track a comparison event for an external vendor
     */
    public ExternalVendor trackComparison(Users user, String googlePlaceId) {
        Optional<ExternalVendor> existing = externalVendorRepository.findByUserAndGooglePlaceId(user, googlePlaceId);
        
        if (existing.isPresent()) {
            ExternalVendor vendor = existing.get();
            vendor.setComparisonCount((vendor.getComparisonCount() != null ? vendor.getComparisonCount() : 0) + 1);
            vendor.setUpdatedAt(LocalDateTime.now());
            return externalVendorRepository.save(vendor);
        }
        
        return null;
    }

    /**
     * Bookmark/unbookmark an external vendor
     */
    public ExternalVendor toggleBookmark(Users user, String googlePlaceId) {
        Optional<ExternalVendor> existing = externalVendorRepository.findByUserAndGooglePlaceId(user, googlePlaceId);
        
        if (existing.isPresent()) {
            ExternalVendor vendor = existing.get();
            vendor.setIsBookmarked(!vendor.getIsBookmarked());
            vendor.setUpdatedAt(LocalDateTime.now());
            return externalVendorRepository.save(vendor);
        }
        
        return null;
    }

    /**
     * Add notes to an external vendor
     */
    public ExternalVendor addNotes(Users user, String googlePlaceId, String notes) {
        Optional<ExternalVendor> existing = externalVendorRepository.findByUserAndGooglePlaceId(user, googlePlaceId);
        
        if (existing.isPresent()) {
            ExternalVendor vendor = existing.get();
            vendor.setNotes(notes);
            vendor.setUpdatedAt(LocalDateTime.now());
            return externalVendorRepository.save(vendor);
        }
        
        return null;
    }

    /**
     * Get all bookmarked external vendors for a user
     */
    public List<ExternalVendor> getUserBookmarks(Users user) {
        return externalVendorRepository.findByUserAndIsBookmarkedTrue(user);
    }

    /**
     * Get user's viewing history
     */
    public List<ExternalVendor> getUserHistory(Users user) {
        return externalVendorRepository.findByUserOrderByLastViewedDesc(user);
    }

    /**
     * Get most compared vendors by user
     */
    public List<ExternalVendor> getMostComparedVendors(Users user) {
        return externalVendorRepository.findMostComparedVendors(user);
    }

    /**
     * Get external vendor by ID
     */
    public ExternalVendor getExternalVendorById(Long id) {
        return externalVendorRepository.findById(id).orElse(null);
    }

    /**
     * Delete external vendor record
     */
    public void deleteExternalVendor(Long id) {
        externalVendorRepository.deleteById(id);
    }

    /**
     * Clear all external vendor history for a user
     */
    public void clearUserHistory(Users user) {
        externalVendorRepository.deleteByUser(user);
    }
}
