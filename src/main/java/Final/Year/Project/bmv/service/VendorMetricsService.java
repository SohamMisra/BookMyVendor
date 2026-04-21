package Final.Year.Project.bmv.service;

import Final.Year.Project.bmv.entity.VendorMetrics;
import Final.Year.Project.bmv.entity.VendorProfile;
import Final.Year.Project.bmv.repository.VendorMetricsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Service for managing vendor metrics.
 * Tracks reliability indicators for recommendation engine.
 */
@Service
public class VendorMetricsService {

    @Autowired
    private VendorMetricsRepository vendorMetricsRepository;

    /**
     * Initialize metrics for a new vendor
     */
    public VendorMetrics createMetricsForVendor(VendorProfile vendor) {
        VendorMetrics metrics = VendorMetrics.builder()
                .vendor(vendor)
                .totalRequests(0)
                .acceptedRequests(0)
                .rejectedRequests(0)
                .completedJobs(0)
                .acceptanceRate(0.0)
                .rejectionRate(0.0)
                .avgResponseTimeHours(0.0)
                .yearsOfExperience(vendor.getYearsOfExperience() != null ? vendor.getYearsOfExperience() : 0)
                .build();
        return vendorMetricsRepository.save(metrics);
    }

    /**
     * Get metrics for a vendor, create if not exists
     */
    public VendorMetrics getOrCreateMetrics(VendorProfile vendor) {
        return vendorMetricsRepository
                .findByVendor_VendorId(vendor.getVendorId())
                .orElseGet(() -> createMetricsForVendor(vendor));
    }

    /**
     * Record that vendor received a request
     */
    public void recordRequestReceived(Long vendorId) {
        vendorMetricsRepository.findByVendor_VendorId(vendorId).ifPresent(metrics -> {
            metrics.recordRequestReceived();
            vendorMetricsRepository.save(metrics);
        });
    }

    /**
     * Record vendor acceptance
     */
    public void recordAcceptance(Long vendorId) {
        vendorMetricsRepository.findByVendor_VendorId(vendorId).ifPresent(metrics -> {
            metrics.recordAcceptance();
            vendorMetricsRepository.save(metrics);
        });
    }

    /**
     * Record vendor rejection
     */
    public void recordRejection(Long vendorId) {
        vendorMetricsRepository.findByVendor_VendorId(vendorId).ifPresent(metrics -> {
            metrics.recordRejection();
            vendorMetricsRepository.save(metrics);
        });
    }

    /**
     * Record job completion
     */
    public void recordJobCompletion(Long vendorId) {
        vendorMetricsRepository.findByVendor_VendorId(vendorId).ifPresent(metrics -> {
            metrics.recordJobCompletion();
            vendorMetricsRepository.save(metrics);
        });
    }

    /**
     * Update response time for vendor
     */
    public void updateResponseTime(Long vendorId, double responseTimeHours) {
        vendorMetricsRepository.findByVendor_VendorId(vendorId).ifPresent(metrics -> {
            metrics.updateResponseTime(responseTimeHours);
            vendorMetricsRepository.save(metrics);
        });
    }

    /**
     * Get metrics for a vendor
     */
    public VendorMetrics getMetrics(Long vendorId) {
        return vendorMetricsRepository.findByVendor_VendorId(vendorId).orElse(null);
    }
}
