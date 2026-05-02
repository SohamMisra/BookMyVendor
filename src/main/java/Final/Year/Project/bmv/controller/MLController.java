package Final.Year.Project.bmv.controller;

import Final.Year.Project.bmv.entity.VendorReliabilityScore;
import Final.Year.Project.bmv.entity.ReviewSentimentAnalysis;
import Final.Year.Project.bmv.service.VendorReliabilityService;
import Final.Year.Project.bmv.service.ReviewSentimentAnalysisService;
import Final.Year.Project.bmv.service.DemandForecastingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/ml")
public class MLController {

    @Autowired
    private VendorReliabilityService reliabilityService;

    @Autowired
    private ReviewSentimentAnalysisService sentimentAnalysisService;

    @Autowired
    private DemandForecastingService demandForecastingService;

    @GetMapping("/vendors/{vendorId}/reliability")
    public ResponseEntity<?> getVendorReliability(@PathVariable Long vendorId) {
        try {
            VendorReliabilityScore score = reliabilityService.getVendorReliabilityScore(vendorId);
            return ResponseEntity.ok(score);
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Error calculating reliability: " + e.getMessage());
        }
    }

    @PostMapping("/vendors/{vendorId}/reliability/calculate")
    public ResponseEntity<?> calculateVendorReliability(@PathVariable Long vendorId) {
        try {
            VendorReliabilityScore score = reliabilityService.calculateReliabilityScore(vendorId);
            return ResponseEntity.ok(score);
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Error calculating reliability: " + e.getMessage());
        }
    }

    @GetMapping("/reviews/{reviewId}/sentiment")
    public ResponseEntity<?> analyzeReviewSentiment(@PathVariable Long reviewId) {
        try {
            ReviewSentimentAnalysis analysis = sentimentAnalysisService.analyzeReview(reviewId);
            return ResponseEntity.ok(analysis);
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Error analyzing sentiment: " + e.getMessage());
        }
    }

    @PostMapping("/reviews/{reviewId}/sentiment/analyze")
    public ResponseEntity<?> analyzeReview(@PathVariable Long reviewId) {
        try {
            ReviewSentimentAnalysis analysis = sentimentAnalysisService.analyzeReview(reviewId);
            return ResponseEntity.ok(analysis);
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Error analyzing sentiment: " + e.getMessage());
        }
    }

    @GetMapping("/vendors/{vendorId}/reviews/summary")
    public ResponseEntity<?> getVendorReviewsSummary(@PathVariable Long vendorId) {
        try {
            List<ReviewSentimentAnalysis> summary = sentimentAnalysisService.getVendorReviewsSummary(vendorId);
            return ResponseEntity.ok(summary);
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Error generating summary: " + e.getMessage());
        }
    }

    @GetMapping("/vendors/{vendorId}/demand-forecast")
    public ResponseEntity<?> forecastDemand(
            @PathVariable Long vendorId,
            @RequestParam(defaultValue = "30") int days) {
        try {
            DemandForecastingService.DemandForecast forecast = demandForecastingService.forecastDemand(vendorId, days);
            return ResponseEntity.ok(forecast);
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Error forecasting demand: " + e.getMessage());
        }
    }
}


