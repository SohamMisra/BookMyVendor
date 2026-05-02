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
@Table(name = "review_sentiment")
public class ReviewSentimentAnalysis {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long analysisId;

    @OneToOne
    @JoinColumn(name = "review_id")
    private Reviews review;

    @Column
    private String overallSentiment;

    @Column(precision = 5, scale = 2)
    private BigDecimal sentimentConfidence;

    @Column(precision = 5, scale = 2)
    private BigDecimal polarityScore;

    @Column(columnDefinition = "TEXT")
    private String extractedAspects;

    @Column(columnDefinition = "TEXT")
    private String highlights;

    @Column(columnDefinition = "TEXT")
    private String concerns;

    private Integer highlightCount;
    private Integer concernCount;

    @Column(precision = 5, scale = 2)
    private BigDecimal ratingAlignment;

    private LocalDateTime analyzedAt;

    public enum SentimentLabel {
        POSITIVE,
        NEGATIVE,
        NEUTRAL
    }
}
