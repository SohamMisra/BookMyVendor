import React, { useEffect, useState } from 'react';
import { AlertCircle, TrendingUp, CheckCircle, BarChart3 } from 'lucide-react';
import { getVendorReliability } from '../services/api';
import './VendorReliabilityCard.css';

const VendorReliabilityCard = ({ vendorId }) => {
  const [reliability, setReliability] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    fetchReliability();
  }, [vendorId]);

  const fetchReliability = async () => {
    try {
      setLoading(true);
      const response = await getVendorReliability(vendorId);
      setReliability(response.data);
      setError(null);
    } catch (err) {
      console.error('Failed to fetch reliability score:', err);
      setError('Unable to load reliability score');
    } finally {
      setLoading(false);
    }
  };

  if (loading) {
    return (
      <div className="reliability-card animate-pulse">
        <div className="h-48 bg-gray-200 rounded"></div>
      </div>
    );
  }

  if (error || !reliability) {
    return <div className="text-red-600 p-4">{error || 'No data available'}</div>;
  }

  const getRiskColor = (level) => {
    switch (level) {
      case 'LOW_RISK':
        return { bg: 'bg-green-50', text: 'text-green-700', border: 'border-green-300' };
      case 'MEDIUM_RISK':
        return { bg: 'bg-yellow-50', text: 'text-yellow-700', border: 'border-yellow-300' };
      case 'HIGH_RISK':
        return { bg: 'bg-orange-50', text: 'text-orange-700', border: 'border-orange-300' };
      case 'CRITICAL_RISK':
        return { bg: 'bg-red-50', text: 'text-red-700', border: 'border-red-300' };
      default:
        return { bg: 'bg-gray-50', text: 'text-gray-700', border: 'border-gray-300' };
    }
  };

  const getScoreLabel = (score) => {
    if (score >= 80) return 'Excellent';
    if (score >= 60) return 'Good';
    if (score >= 40) return 'Fair';
    return 'Poor';
  };

  const colors = getRiskColor(reliability.riskLevel);

  return (
    <div className={`reliability-card ${colors.bg} border-2 ${colors.border} rounded-lg p-6 shadow-md`}>
      <div className="flex items-center justify-between mb-4">
        <div className="flex items-center gap-2">
          <BarChart3 className="w-6 h-6" />
          <h3 className="text-lg font-bold">Reliability Index</h3>
        </div>
        {reliability.riskLevel === 'LOW_RISK' ? (
          <CheckCircle className={`w-6 h-6 text-green-600`} />
        ) : (
          <AlertCircle className={`w-6 h-6 ${colors.text}`} />
        )}
      </div>

      <div className="mb-6">
        <div className="flex items-end gap-2 mb-2">
          <span className={`text-4xl font-bold ${colors.text}`}>
            {reliability.reliabilityScore.toFixed(1)}
          </span>
          <span className="text-sm font-medium text-gray-600 mb-1">/100</span>
        </div>
        <div className="w-full bg-gray-300 rounded-full h-3">
          <div
            className={`h-3 rounded-full transition-all duration-300 ${
              reliability.riskLevel === 'LOW_RISK' ? 'bg-green-500' :
              reliability.riskLevel === 'MEDIUM_RISK' ? 'bg-yellow-500' :
              reliability.riskLevel === 'HIGH_RISK' ? 'bg-orange-500' :
              'bg-red-500'
            }`}
            style={{ width: `${reliability.reliabilityScore}%` }}
          />
        </div>
        <p className={`text-sm mt-2 font-semibold ${colors.text}`}>
          {getScoreLabel(reliability.reliabilityScore)}
        </p>
      </div>

      <div className="grid grid-cols-2 gap-4 text-sm">
        <div className="bg-white bg-opacity-50 p-3 rounded">
          <p className="text-gray-600">Response Time</p>
          <p className="font-bold text-lg">
            {reliability.metrics?.avgResponseTime?.toFixed(1) || '0'}h
          </p>
        </div>
        <div className="bg-white bg-opacity-50 p-3 rounded">
          <p className="text-gray-600">Cancellations</p>
          <p className="font-bold text-lg">
            {(reliability.metrics?.cancellationRate * 100)?.toFixed(1) || '0'}%
          </p>
        </div>
        <div className="bg-white bg-opacity-50 p-3 rounded">
          <p className="text-gray-600">Total Bookings</p>
          <p className="font-bold text-lg">{reliability.metrics?.totalBookings || '0'}</p>
        </div>
        <div className="bg-white bg-opacity-50 p-3 rounded flex items-center justify-between">
          <p className="text-gray-600">Trend</p>
          <TrendingUp
            className={`w-5 h-5 ${
              (reliability.metrics?.satisfactionTrend || 0) > 0
                ? 'text-green-600'
                : 'text-red-600'
            }`}
          />
        </div>
      </div>

      <div className={`mt-4 p-3 rounded text-sm ${colors.bg} border ${colors.border}`}>
        <p className="font-semibold">Risk Level: <span className="font-bold">{reliability.riskLevel}</span></p>
        <p className="text-xs text-gray-700 mt-1">
          Last calculated: {new Date(reliability.calculatedAt).toLocaleDateString()}
        </p>
      </div>
    </div>
  );
};

export default VendorReliabilityCard;

