package Final.Year.Project.bmv.repository;

import Final.Year.Project.bmv.entity.VendorReliabilityScore;
import Final.Year.Project.bmv.entity.VendorProfile;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface VendorReliabilityScoreRepository extends JpaRepository<VendorReliabilityScore, Long> {
    Optional<VendorReliabilityScore> findByVendor(VendorProfile vendor);
    Optional<VendorReliabilityScore> findLatestByVendor(VendorProfile vendor);
}

