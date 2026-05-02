package Final.Year.Project.bmv.entity;

import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "vendor_reliability_scores")
public class VendorReliabilityScore {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long scoreId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "vendor_id", nullable = false)
    private VendorProfile vendor;

    @Column(nullable = false, precision = 5, scale = 2)
    private BigDecimal reliabilityScore; // 0-100

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private RiskLevel riskLevel;

    @Column(precision = 5, scale = 2)
    private BigDecimal avgResponseTime; // in hours

    @Column(precision = 5, scale = 2)
    private BigDecimal cancellationRate; // 0-1

    @Column(precision = 5, scale = 2)
    private BigDecimal ratingStdDev; // rating consistency

    @Column
    private Long totalBookings; // lifetime

    @Column(precision = 5, scale = 2)
    private BigDecimal satisfactionTrend; // -1 to 1

    @Column(nullable = false, updatable = false)
    private LocalDateTime calculatedAt = LocalDateTime.now();

    private LocalDateTime lastUpdated = LocalDateTime.now();

    public enum RiskLevel {
        LOW_RISK,
        MEDIUM_RISK,
        HIGH_RISK,
        CRITICAL_RISK
    }
}

