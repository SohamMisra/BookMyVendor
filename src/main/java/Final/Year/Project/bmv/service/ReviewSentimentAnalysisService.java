package Final.Year.Project.bmv.service;

import Final.Year.Project.bmv.entity.*;
import Final.Year.Project.bmv.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.*;
import Final.Year.Project.bmv.entity.ReviewSentimentAnalysis.SentimentLabel;
import Final.Year.Project.bmv.repository.ReviewSentimentAnalysisRepository;
@Service
public class ReviewSentimentAnalysisService {

    @Autowired
    private ReviewSentimentAnalysisRepository sentimentRepository;

    @Autowired
    private ReviewRepository reviewRepository;

    @Autowired
    private VendorProfileRepository vendorProfileRepository;

    private final ObjectMapper objectMapper = new ObjectMapper();

    private static final List<String> ASPECTS = Arrays.asList(
            "food quality", "taste", "freshness",
            "decoration", "setup", "design",
            "punctuality", "timeliness", "on-time",
            "staff", "behavior", "professionalism",
            "price", "cost", "value",
            "venue", "space", "ambiance",
            "photography", "photos", "videography",
            "music", "dj", "sound",
            "coordination", "management", "planning"
    );

    public ReviewSentimentAnalysis analyzeReview(Long reviewId) {
        Reviews review = reviewRepository.findById(reviewId)
                .orElseThrow(() -> new RuntimeException("Review not found"));

        return analyzeReviewText(review);
    }

    private ReviewSentimentAnalysis analyzeReviewText(Reviews review) {
        String comment = review.getComment() != null ? review.getComment() : "";
        Integer rating = review.getRating();

        ReviewSentimentAnalysis.SentimentLabel sentiment = determineSentiment(comment, rating);
        BigDecimal confidence = calculateSentimentConfidence(comment, rating);
        BigDecimal polarity = calculatePolarity(comment);
        List<String> extractedAspects = extractAspects(comment);
        List<Map<String, Object>> highlights = extractHighlights(comment, extractedAspects);
        List<Map<String, Object>> concerns = extractConcerns(comment, extractedAspects);
        BigDecimal ratingAlignment = calculateRatingAlignment(polarity, rating);

        ReviewSentimentAnalysis analysis = ReviewSentimentAnalysis.builder()
                .review(review)
                .overallSentiment(sentiment.toString())
                .sentimentConfidence(confidence)
                .polarityScore(polarity)
                .extractedAspects(listToJson(extractedAspects))
                .highlights(listToJson(highlights))
                .concerns(listToJson(concerns))
                .highlightCount(highlights.size())
                .concernCount(concerns.size())
                .ratingAlignment(ratingAlignment)
                .analyzedAt(LocalDateTime.now())
                .build();

        return sentimentRepository.save(analysis);
    }

    private ReviewSentimentAnalysis.SentimentLabel determineSentiment(String text, Integer rating) {
        if (rating >= 4) {
            return ReviewSentimentAnalysis.SentimentLabel.POSITIVE;
        } else if (rating <= 2) {
            return ReviewSentimentAnalysis.SentimentLabel.NEGATIVE;
        }
        return ReviewSentimentAnalysis.SentimentLabel.NEUTRAL;
    }

    private BigDecimal calculateSentimentConfidence(String text, Integer rating) {
        if (text == null || text.isEmpty()) {
            return new BigDecimal("0.5");
        }

        double confidence = 0.6 + (text.length() / 1000.0) * 0.3;
        confidence = Math.min(confidence, 0.95);

        return new BigDecimal(confidence).setScale(2, java.math.RoundingMode.HALF_UP);
    }

    private BigDecimal calculatePolarity(String text) {
        if (text == null || text.isEmpty()) return BigDecimal.ZERO;

        List<String> positiveWords = Arrays.asList(
                "excellent", "amazing", "wonderful", "great", "fantastic", "perfect", "awesome",
                "lovely", "beautiful", "brilliant", "outstanding", "superb", "excellent", "best"
        );

        List<String> negativeWords = Arrays.asList(
                "bad", "poor", "terrible", "awful", "horrible", "worst", "disappointing",
                "worse", "waste", "regret", "never", "late", "delay", "problem", "issue"
        );

        String lowerText = text.toLowerCase();
        int positiveCount = 0;
        int negativeCount = 0;

        for (String word : positiveWords) {
            if (lowerText.contains(word)) positiveCount++;
        }

        for (String word : negativeWords) {
            if (lowerText.contains(word)) negativeCount++;
        }

        double polarity = (positiveCount - negativeCount) / (double) (positiveCount + negativeCount + 1);
        polarity = Math.max(-1, Math.min(1, polarity));

        return new BigDecimal(polarity).setScale(2, java.math.RoundingMode.HALF_UP);
    }

    private List<String> extractAspects(String text) {
        String lowerText = text.toLowerCase();
        List<String> foundAspects = new ArrayList<>();

        for (String aspect : ASPECTS) {
            if (lowerText.contains(aspect) && !foundAspects.contains(aspect)) {
                foundAspects.add(aspect);
            }
        }

        return foundAspects.isEmpty() ? Arrays.asList("service quality") : foundAspects.subList(0, Math.min(5, foundAspects.size()));
    }

    private List<Map<String, Object>> extractHighlights(String text, List<String> aspects) {
        List<Map<String, Object>> highlights = new ArrayList<>();
        String[] sentences = text.split("[.!?]");

        for (String sentence : sentences) {
            if (isPositiveSentence(sentence)) {
                for (String aspect : aspects) {
                    if (sentence.toLowerCase().contains(aspect)) {
                        Map<String, Object> highlight = new HashMap<>();
                        highlight.put("text", sentence.trim());
                        highlight.put("aspect", aspect);
                        highlight.put("confidence", 0.85);
                        highlights.add(highlight);
                        break;
                    }
                }
            }
        }

        return highlights.subList(0, Math.min(3, highlights.size()));
    }

    private List<Map<String, Object>> extractConcerns(String text, List<String> aspects) {
        List<Map<String, Object>> concerns = new ArrayList<>();
        String[] sentences = text.split("[.!?]");

        for (String sentence : sentences) {
            if (isNegativeSentence(sentence)) {
                for (String aspect : aspects) {
                    if (sentence.toLowerCase().contains(aspect)) {
                        Map<String, Object> concern = new HashMap<>();
                        concern.put("text", sentence.trim());
                        concern.put("aspect", aspect);
                        concern.put("confidence", 0.82);
                        concerns.add(concern);
                        break;
                    }
                }
            }
        }

        return concerns.subList(0, Math.min(3, concerns.size()));
    }

    private boolean isPositiveSentence(String sentence) {
        List<String> positiveWords = Arrays.asList(
                "excellent", "amazing", "wonderful", "great", "fantastic", "perfect", "awesome",
                "lovely", "beautiful", "best", "loved", "enjoyed", "wonderful", "impressive"
        );

        String lower = sentence.toLowerCase();
        return positiveWords.stream().anyMatch(lower::contains);
    }

    private boolean isNegativeSentence(String sentence) {
        List<String> negativeWords = Arrays.asList(
                "bad", "poor", "terrible", "awful", "horrible", "worst", "disappointing",
                "late", "delay", "problem", "issue", "regret", "never", "waste", "worse"
        );

        String lower = sentence.toLowerCase();
        return negativeWords.stream().anyMatch(lower::contains);
    }

    private BigDecimal calculateRatingAlignment(BigDecimal polarity, Integer rating) {
        double expectedRating = (polarity.doubleValue() + 1) / 2 * 5;
        double difference = Math.abs(expectedRating - rating);

        return new BigDecimal(Math.max(0, 1 - (difference / 5.0))).setScale(2, java.math.RoundingMode.HALF_UP);
    }

    private String listToJson(List<?> list) {
        try {
            return objectMapper.writeValueAsString(list);
        } catch (Exception e) {
            return "[]";
        }
    }

    public ReviewSentimentAnalysis getReviewAnalysis(Long reviewId) {
        return sentimentRepository.findById(reviewId)
                .orElseGet(() -> analyzeReview(reviewId));
    }

    public List<ReviewSentimentAnalysis> getVendorReviewsSummary(Long vendorId) {
        VendorProfile vendor = vendorProfileRepository.findById(vendorId)
                .orElseThrow(() -> new RuntimeException("Vendor not found"));
        List<Reviews> reviews = reviewRepository.findByVendor_UserId(vendor.getUser().getUserId());
        List<ReviewSentimentAnalysis> analyses = new ArrayList<>();

        for (Reviews review : reviews) {
            sentimentRepository.findByReview(review)
                    .ifPresentOrElse(
                            analyses::add,
                            () -> analyses.add(analyzeReviewText(review))
                    );
        }

        return analyses;
    }
}

