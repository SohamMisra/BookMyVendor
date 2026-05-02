import React, { useEffect, useState } from 'react';
import { ThumbsUp, ThumbsDown, Lightbulb, MessageCircle } from 'lucide-react';
import { getReviewSentimentAnalysis } from '../services/api';
import './ReviewSentimentDisplay.css';

const ReviewSentimentDisplay = ({ reviewId, vendorId }) => {
  const [analysis, setAnalysis] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    fetchAnalysis();
  }, [reviewId]);

  const fetchAnalysis = async () => {
    try {
      setLoading(true);
      const response = await getReviewSentimentAnalysis(reviewId);
      setAnalysis(response.data);
      setError(null);
    } catch (err) {
      console.error('Failed to fetch sentiment analysis:', err);
      setError('Unable to load sentiment analysis');
    } finally {
      setLoading(false);
    }
  };

  if (loading) {
    return <div className="animate-pulse h-64 bg-gray-200 rounded"></div>;
  }

  if (error || !analysis) {
    return <div className="text-red-600 p-4">{error || 'No analysis available'}</div>;
  }

  const getSentimentColor = (label) => {
    switch (label) {
      case 'POSITIVE':
        return 'text-green-600 bg-green-50 border-green-200';
      case 'NEGATIVE':
        return 'text-red-600 bg-red-50 border-red-200';
      case 'NEUTRAL':
        return 'text-gray-600 bg-gray-50 border-gray-200';
      default:
        return 'text-gray-600 bg-gray-50 border-gray-200';
    }
  };

  const parseJson = (jsonString) => {
    try {
      return JSON.parse(jsonString);
    } catch {
      return [];
    }
  };

  const highlights = parseJson(analysis.highlights);
  const concerns = parseJson(analysis.concerns);

  return (
    <div className="sentiment-display space-y-6 p-4">
      {/* Overall Sentiment */}
      <div className={`p-5 rounded-lg border-2 ${getSentimentColor(analysis.overallSentiment)}`}>
        <div className="flex items-center justify-between mb-3">
          <div className="flex items-center gap-2">
            <MessageCircle className="w-5 h-5" />
            <h4 className="font-semibold text-lg">Overall Sentiment</h4>
          </div>
          <span className="text-sm font-medium">
            {(analysis.sentimentConfidence * 100).toFixed(0)}% confident
          </span>
        </div>
        <p className="text-3xl font-bold mb-3">{analysis.overallSentiment}</p>
        <div className="w-full bg-gray-200 rounded-full h-2">
          <div
            className={`h-2 rounded-full transition-all ${
              analysis.polarityScore > 0 ? 'bg-green-500' : 'bg-red-500'
            }`}
            style={{
              width: `${Math.abs(analysis.polarityScore * 50) + 50}%`,
            }}
          />
        </div>
      </div>

      {/* Highlights */}
      <div>
        <div className="flex items-center gap-2 mb-3">
          <ThumbsUp className="w-5 h-5 text-green-600" />
          <h4 className="font-semibold text-lg">What Customers Liked ✨</h4>
        </div>
        <div className="space-y-2">
          {highlights.length > 0 ? (
            highlights.map((highlight, idx) => (
              <div key={idx} className="p-3 bg-green-50 border border-green-200 rounded-lg">
                <div className="flex items-start justify-between gap-2">
                  <div className="flex-1">
                    <p className="text-sm font-medium text-green-700">
                      {highlight.aspect}
                    </p>
                    <p className="text-sm text-gray-700 mt-1">{highlight.text}</p>
                  </div>
                  <span className="text-xs font-semibold text-green-600 whitespace-nowrap">
                    {(highlight.confidence * 100).toFixed(0)}%
                  </span>
                </div>
              </div>
            ))
          ) : (
            <p className="text-gray-500 italic">No highlights detected</p>
          )}
        </div>
      </div>

      {/* Concerns */}
      <div>
        <div className="flex items-center gap-2 mb-3">
          <ThumbsDown className="w-5 h-5 text-red-600" />
          <h4 className="font-semibold text-lg">Areas to Improve 📌</h4>
        </div>
        <div className="space-y-2">
          {concerns.length > 0 ? (
            concerns.map((concern, idx) => (
              <div key={idx} className="p-3 bg-red-50 border border-red-200 rounded-lg">
                <div className="flex items-start justify-between gap-2">
                  <div className="flex-1">
                    <p className="text-sm font-medium text-red-700">
                      {concern.aspect}
                    </p>
                    <p className="text-sm text-gray-700 mt-1">{concern.text}</p>
                  </div>
                  <span className="text-xs font-semibold text-red-600 whitespace-nowrap">
                    {(concern.confidence * 100).toFixed(0)}%
                  </span>
                </div>
              </div>
            ))
          ) : (
            <p className="text-gray-500 italic">No concerns detected</p>
          )}
        </div>
      </div>

      {/* Key Insights */}
      <div className="p-4 bg-blue-50 border border-blue-200 rounded-lg">
        <div className="flex items-center gap-2 mb-2">
          <Lightbulb className="w-5 h-5 text-blue-600" />
          <p className="font-semibold text-blue-900">Key Insights</p>
        </div>
        <p className="text-sm text-gray-700">
          This review shows {analysis.overallSentiment.toLowerCase()} sentiment with
          {highlights.length} strengths and {concerns.length} areas for improvement.
          Confidence: {(analysis.sentimentConfidence * 100).toFixed(0)}%
        </p>
      </div>

      {/* Stats */}
      <div className="grid grid-cols-3 gap-2 text-center">
        <div className="p-2 bg-gray-100 rounded">
          <p className="text-xs text-gray-600">Highlights</p>
          <p className="text-lg font-bold">{analysis.highlightCount}</p>
        </div>
        <div className="p-2 bg-gray-100 rounded">
          <p className="text-xs text-gray-600">Concerns</p>
          <p className="text-lg font-bold">{analysis.concernCount}</p>
        </div>
        <div className="p-2 bg-gray-100 rounded">
          <p className="text-xs text-gray-600">Alignment</p>
          <p className="text-lg font-bold">{(analysis.ratingAlignment * 100).toFixed(0)}%</p>
        </div>
      </div>
    </div>
  );
};

export default ReviewSentimentDisplay;

