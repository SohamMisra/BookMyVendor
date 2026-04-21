package Final.Year.Project.bmv.repository;

import Final.Year.Project.bmv.entity.ExternalVendor;
import Final.Year.Project.bmv.entity.Users;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ExternalVendorRepository extends JpaRepository<ExternalVendor, Long> {

    /**
     * Find external vendor by user and Google place ID
     */
    Optional<ExternalVendor> findByUserAndGooglePlaceId(Users user, String googlePlaceId);

    /**
     * Get all bookmarked external vendors for a user
     */
    List<ExternalVendor> findByUserAndIsBookmarkedTrue(Users user);

    /**
     * Get all external vendors for a user (with viewing history)
     */
    List<ExternalVendor> findByUserOrderByLastViewedDesc(Users user);

    /**
     * Get most compared external vendors
     */
    @Query("SELECT ev FROM ExternalVendor ev WHERE ev.user = :user ORDER BY ev.comparisonCount DESC")
    List<ExternalVendor> findMostComparedVendors(@Param("user") Users user);

    /**
     * Delete all external vendors for a user
     */
    void deleteByUser(Users user);
}
