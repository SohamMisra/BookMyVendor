package Final.Year.Project.bmv.repository;

import Final.Year.Project.bmv.entity.ReviewSentimentAnalysis;
import Final.Year.Project.bmv.entity.Reviews;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;
@Repository
public interface ReviewSentimentAnalysisRepository extends JpaRepository<ReviewSentimentAnalysis, Long> {
    Optional<ReviewSentimentAnalysis> findByReview(Reviews review);
}
