package Final.Year.Project.bmv.service;

import Final.Year.Project.bmv.entity.Reviews;
import Final.Year.Project.bmv.repository.ReviewRepository;
import Final.Year.Project.bmv.repository.ReviewSentimentAnalysisRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReviewMLIntegrationService {

    @Autowired
    private ReviewSentimentAnalysisService sentimentAnalysisService;

    @Autowired
    private VendorReliabilityService reliabilityService;

    @Autowired
    private ReviewRepository reviewRepository;

    @Autowired
    private ReviewSentimentAnalysisRepository sentimentRepository;

    /**
     * Called when a new review is created
     */
    public void processNewReview(Long reviewId) {
        try {
            Reviews review = reviewRepository.findById(reviewId)
                    .orElseThrow(() -> new RuntimeException("Review not found"));

            // Analyze sentiment
            sentimentAnalysisService.analyzeReview(reviewId);

            // Recalculate vendor reliability score
            if (review.getVendor() != null && review.getVendor().getUserId() != null) {
                reliabilityService.calculateReliabilityScore(review.getVendor().getUserId());
            }
        } catch (Exception e) {
            System.err.println("Error processing review ML analysis: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Batch process reviews that haven't been analyzed yet
     */
    public void processPendingReviews() {
        try {
            reviewRepository.findAll().forEach(review -> {
                if (!sentimentRepository.findByReview(review).isPresent()) {
                    processNewReview(review.getReviewId());
                }
            });
        } catch (Exception e) {
            System.err.println("Error in batch processing: " + e.getMessage());
        }
    }

    /**
     * Recalculate all vendor reliability scores
     */
    public void recalculateAllVendorScores() {
        try {
            reviewRepository.findAll().stream()
                    .filter(review -> review.getVendor() != null)
                    .map(review -> review.getVendor().getUserId())
                    .distinct()
                    .forEach(vendorId -> {
                        try {
                            reliabilityService.calculateReliabilityScore(vendorId);
                        } catch (Exception e) {
                            System.err.println("Error calculating reliability for vendor " + vendorId + ": " + e.getMessage());
                        }
                    });
        } catch (Exception e) {
            System.err.println("Error recalculating vendor scores: " + e.getMessage());
        }
    }
}

