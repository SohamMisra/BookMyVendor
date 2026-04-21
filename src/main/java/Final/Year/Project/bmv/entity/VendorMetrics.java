package Final.Year.Project.bmv.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

/**
 * VendorMetrics tracks reliability and responsiveness indicators for vendors.
 * Used for intelligent recommendation scoring.
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "vendor_metrics")
public class VendorMetrics {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long metricId;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "vendor_id", nullable = false, unique = true)
    private VendorProfile vendor;

    // Reliability metrics
    private Integer totalRequests = 0;
    private Integer acceptedRequests = 0;
    private Integer rejectedRequests = 0;
    private Integer completedJobs = 0;

    // Calculated rates (0.0 to 1.0)
    @Column
    private Double acceptanceRate = 0.0;

    @Column
    private Double rejectionRate = 0.0;

    // Responsiveness
    private Double avgResponseTimeHours = 0.0;

    // Experience
    private Integer yearsOfExperience = 0;

    @Column(updatable = false)
    private LocalDateTime createdAt = LocalDateTime.now();

    private LocalDateTime updatedAt = LocalDateTime.now();

    /**
     * Updates metrics when a request is received.
     */
    public void recordRequestReceived() {
        this.totalRequests++;
        this.updatedAt = LocalDateTime.now();
    }

    /**
     * Updates metrics when vendor accepts a request.
     */
    public void recordAcceptance() {
        this.acceptedRequests++;
        if (this.totalRequests > 0) {
            this.acceptanceRate = (double) this.acceptedRequests / this.totalRequests;
        }
        this.updatedAt = LocalDateTime.now();
    }

    /**
     * Updates metrics when vendor rejects a request.
     */
    public void recordRejection() {
        this.rejectedRequests++;
        if (this.totalRequests > 0) {
            this.rejectionRate = (double) this.rejectedRequests / this.totalRequests;
        }
        this.updatedAt = LocalDateTime.now();
    }

    /**
     * Updates metrics when a job is completed.
     */
    public void recordJobCompletion() {
        this.completedJobs++;
        this.updatedAt = LocalDateTime.now();
    }

    /**
     * Updates response time based on new response.
     */
    public void updateResponseTime(double responseTimeHours) {
        if (this.avgResponseTimeHours == 0.0) {
            this.avgResponseTimeHours = responseTimeHours;
        } else {
            // Running average
            this.avgResponseTimeHours = (this.avgResponseTimeHours + responseTimeHours) / 2.0;
        }
        this.updatedAt = LocalDateTime.now();
    }
}
