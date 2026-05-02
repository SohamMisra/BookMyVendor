import React, { useEffect, useState } from 'react';
import { BarChart3, TrendingUp, MessageSquare, Star } from 'lucide-react';
import { getVendorReviewsSummary } from '../services/api';
import VendorReliabilityCard from './VendorReliabilityCard';
import ReviewSentimentDisplay from './ReviewSentimentDisplay';
import DemandForecastChart from './DemandForecastChart';
import './AIMLDashboard.css';

const AIMLDashboard = ({ vendorId }) => {
  const [reviews, setReviews] = useState([]);
  const [selectedReview, setSelectedReview] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    fetchReviewsSummary();
  }, [vendorId]);

  const fetchReviewsSummary = async () => {
    try {
      setLoading(true);
      const response = await getVendorReviewsSummary(vendorId);
      setReviews(response.data);
      if (response.data.length > 0) {
        setSelectedReview(response.data[0]);
      }
      setError(null);
    } catch (err) {
      console.error('Failed to fetch reviews summary:', err);
      setError('Unable to load reviews summary');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="aiml-dashboard p-6 bg-gray-50 rounded-lg">
      <div className="mb-8">
        <h2 className="text-3xl font-bold mb-2 flex items-center gap-2">
          <BarChart3 className="w-8 h-8 text-indigo-600" />
          AI/ML Analytics Dashboard
        </h2>
        <p className="text-gray-600">Advanced insights about your vendor performance</p>
      </div>

      {/* Main Grid */}
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6 mb-8">
        {/* Reliability Score */}
        <div className="lg:col-span-1">
          <VendorReliabilityCard vendorId={vendorId} />
        </div>

        {/* Stats Overview */}
        <div className="lg:col-span-2 grid grid-cols-2 gap-4">
          <div className="bg-white p-5 rounded-lg border border-gray-200 shadow">
            <div className="flex items-center justify-between mb-2">
              <h3 className="font-semibold text-gray-700">Total Reviews</h3>
              <MessageSquare className="w-5 h-5 text-blue-600" />
            </div>
            <p className="text-3xl font-bold text-gray-900">{reviews.length}</p>
            <p className="text-xs text-gray-500 mt-2">Analyzed by AI</p>
          </div>

          <div className="bg-white p-5 rounded-lg border border-gray-200 shadow">
            <div className="flex items-center justify-between mb-2">
              <h3 className="font-semibold text-gray-700">Avg Rating</h3>
              <Star className="w-5 h-5 text-yellow-500" />
            </div>
            <p className="text-3xl font-bold text-gray-900">
              {reviews.length > 0
                ? (
                    reviews.reduce((acc, r) => acc + (r.overallSentiment === 'POSITIVE' ? 5 : r.overallSentiment === 'NEUTRAL' ? 3 : 1), 0) /
                    reviews.length
                  ).toFixed(1)
                : 'N/A'}
            </p>
            <p className="text-xs text-gray-500 mt-2">Based on sentiment</p>
          </div>

          <div className="bg-white p-5 rounded-lg border border-gray-200 shadow">
            <div className="flex items-center justify-between mb-2">
              <h3 className="font-semibold text-gray-700">Positive</h3>
              <TrendingUp className="w-5 h-5 text-green-600" />
            </div>
            <p className="text-3xl font-bold text-green-600">
              {(
                (reviews.filter((r) => r.overallSentiment === 'POSITIVE').length / Math.max(reviews.length, 1)) *
                100
              ).toFixed(0)}
              %
            </p>
            <p className="text-xs text-gray-500 mt-2">Of all reviews</p>
          </div>

          <div className="bg-white p-5 rounded-lg border border-gray-200 shadow">
            <div className="flex items-center justify-between mb-2">
              <h3 className="font-semibold text-gray-700">Concerns</h3>
              <MessageSquare className="w-5 h-5 text-red-600" />
            </div>
            <p className="text-3xl font-bold text-red-600">
              {reviews.reduce((acc, r) => acc + (r.concernCount || 0), 0)}
            </p>
            <p className="text-xs text-gray-500 mt-2">Total concerns flagged</p>
          </div>
        </div>
      </div>

      {/* Reviews Detail Section */}
      {reviews.length > 0 && (
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
          {/* Review List */}
          <div className="lg:col-span-1 bg-white rounded-lg border border-gray-200 shadow p-4">
            <h3 className="font-bold text-lg mb-4">Recent Reviews</h3>
            <div className="space-y-2 max-h-96 overflow-y-auto">
              {reviews.map((review, idx) => (
                <div
                  key={idx}
                  onClick={() => setSelectedReview(review)}
                  className={`p-3 rounded-lg cursor-pointer transition ${
                    selectedReview === review
                      ? 'bg-indigo-50 border-2 border-indigo-300'
                      : 'bg-gray-50 border border-gray-200 hover:bg-gray-100'
                  }`}
                >
                  <div className="flex items-center justify-between mb-1">
                    <p className="font-semibold text-sm">{idx + 1}</p>
                    <span
                      className={`text-xs font-bold px-2 py-1 rounded ${
                        review.overallSentiment === 'POSITIVE'
                          ? 'bg-green-100 text-green-800'
                          : review.overallSentiment === 'NEUTRAL'
                          ? 'bg-gray-100 text-gray-800'
                          : 'bg-red-100 text-red-800'
                      }`}
                    >
                      {review.overallSentiment}
                    </span>
                  </div>
                  <p className="text-xs text-gray-600">
                    Confidence: {(review.sentimentConfidence * 100).toFixed(0)}%
                  </p>
                </div>
              ))}
            </div>
          </div>

          {/* Detailed Review Analysis */}
          {selectedReview && (
            <div className="lg:col-span-2 bg-white rounded-lg border border-gray-200 shadow p-4">
              <h3 className="font-bold text-lg mb-4">Detailed Analysis</h3>
              <ReviewSentimentDisplay reviewId={selectedReview.analysisId} vendorId={vendorId} />
            </div>
          )}
        </div>
      )}

      {/* Demand Forecast Section */}
      <div className="mt-8">
        <DemandForecastChart vendorId={vendorId} days={30} />
      </div>

      {loading && <div className="text-center py-8">Loading data...</div>}
      {error && <div className="bg-red-100 text-red-800 p-4 rounded">{error}</div>}
    </div>
  );
};

export default AIMLDashboard;

