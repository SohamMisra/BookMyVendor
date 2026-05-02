import React, { useEffect, useState } from 'react';
import { TrendingUp, Calendar, Zap } from 'lucide-react';
import { getDemandForecast } from '../services/api';
import './DemandForecastChart.css';

const DemandForecastChart = ({ vendorId, days = 30 }) => {
  const [forecast, setForecast] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    fetchForecast();
  }, [vendorId, days]);

  const fetchForecast = async () => {
    try {
      setLoading(true);
      const response = await getDemandForecast(vendorId, days);
      setForecast(response.data);
      setError(null);
    } catch (err) {
      console.error('Failed to fetch forecast:', err);
      setError('Unable to load demand forecast');
    } finally {
      setLoading(false);
    }
  };

  if (loading) {
    return <div className="animate-pulse h-64 bg-gray-200 rounded"></div>;
  }

  if (error || !forecast) {
    return <div className="text-red-600 p-4">{error || 'No forecast data'}</div>;
  }

  const maxPrediction = Math.max(
    ...forecast.forecasts.map(f => f.predictedBookings || 0),
    1
  );

  const getIntensity = (value) => {
    const ratio = value / maxPrediction;
    if (ratio > 0.8) return 'intensity-high';
    if (ratio > 0.5) return 'intensity-medium';
    return 'intensity-low';
  };

  const isWeekend = (date) => {
    const day = new Date(date).getDay();
    return day === 5 || day === 6; // Friday, Saturday
  };

  return (
    <div className="demand-forecast p-6 bg-white rounded-lg border border-gray-200 shadow">
      <div className="flex items-center gap-2 mb-6">
        <TrendingUp className="w-6 h-6 text-indigo-600" />
        <h3 className="text-2xl font-bold">Booking Demand Forecast</h3>
      </div>

      <div className="forecast-grid mb-6">
        {forecast.forecasts.map((day, idx) => (
          <div
            key={idx}
            className={`forecast-bar ${getIntensity(day.predictedBookings)} ${
              isWeekend(day.date) ? 'is-weekend' : ''
            }`}
            title={`${new Date(day.date).toLocaleDateString()}: ${day.predictedBookings.toFixed(1)} bookings (${(day.confidence * 100).toFixed(0)}% confidence)`}
          >
            <div className="bar-value">
              {day.predictedBookings.toFixed(1)}
            </div>
            <div className="bar-label">
              {new Date(day.date).getDate()}
            </div>
          </div>
        ))}
      </div>

      <div className="forecast-stats grid grid-cols-4 gap-4 text-center">
        <div className="stat-box">
          <p className="text-sm text-gray-600">Average</p>
          <p className="text-2xl font-bold">
            {(
              forecast.forecasts.reduce((sum, f) => sum + f.predictedBookings, 0) /
              forecast.forecasts.length
            ).toFixed(1)}
          </p>
        </div>
        <div className="stat-box">
          <p className="text-sm text-gray-600">Peak</p>
          <p className="text-2xl font-bold">
            {Math.max(...forecast.forecasts.map(f => f.predictedBookings)).toFixed(1)}
          </p>
        </div>
        <div className="stat-box">
          <p className="text-sm text-gray-600">Low</p>
          <p className="text-2xl font-bold">
            {Math.min(...forecast.forecasts.map(f => f.predictedBookings)).toFixed(1)}
          </p>
        </div>
        <div className="stat-box">
          <p className="text-sm text-gray-600">Total</p>
          <p className="text-2xl font-bold">
            {forecast.forecasts
              .reduce((sum, f) => sum + f.predictedBookings, 0)
              .toFixed(0)}
          </p>
        </div>
      </div>

      <div className="mt-6 p-4 bg-blue-50 border border-blue-200 rounded">
        <div className="flex items-center gap-2 mb-2">
          <Zap className="w-4 h-4 text-blue-600" />
          <p className="font-semibold text-blue-900">Forecast Insights</p>
        </div>
        <ul className="text-sm text-gray-700 space-y-1">
          <li>• Peak booking days identified (darker bars)</li>
          <li>• Weekend bookings show different patterns</li>
          <li>• Average confidence: {(
            forecast.forecasts.reduce((sum, f) => sum + f.confidence, 0) /
            forecast.forecasts.length * 100
          ).toFixed(0)}%</li>
          <li>• Use this to optimize pricing and availability</li>
        </ul>
      </div>

      <div className="mt-4 flex gap-4 text-xs">
        <div className="flex items-center gap-2">
          <div className="w-4 h-4 intensity-high"></div>
          <span>High Demand</span>
        </div>
        <div className="flex items-center gap-2">
          <div className="w-4 h-4 intensity-medium"></div>
          <span>Medium Demand</span>
        </div>
        <div className="flex items-center gap-2">
          <div className="w-4 h-4 intensity-low"></div>
          <span>Low Demand</span>
        </div>
        <div className="flex items-center gap-2 ml-auto">
          <Calendar className="w-4 h-4" />
          <span>Weekend Pattern</span>
        </div>
      </div>

      <p className="text-xs text-gray-500 mt-4">
        Generated: {new Date(forecast.generatedAt).toLocaleString()}
      </p>
    </div>
  );
};

export default DemandForecastChart;

