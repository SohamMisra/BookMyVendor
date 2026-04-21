package Final.Year.Project.bmv.repository;

import Final.Year.Project.bmv.entity.VendorMetrics;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface VendorMetricsRepository extends JpaRepository<VendorMetrics, Long> {
    Optional<VendorMetrics> findByVendor_VendorId(Long vendorId);
}
