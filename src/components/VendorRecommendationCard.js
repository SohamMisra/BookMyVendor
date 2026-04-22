import React from "react";
import { Card, Badge, Row, Col, Button } from "react-bootstrap";
import { FaStar, FaTrophy, FaCheckCircle, FaClock } from "react-icons/fa";
import "./VendorRecommendationCard.css";

/**
 * VendorRecommendationCard displays a single recommended vendor with scoring details.
 * Shows recommendation score, reasoning, and vendor metrics.
 */
const VendorRecommendationCard = ({ vendor, onSelect, isSelected }) => {
  const formatCurrency = (n) => `₹${Number(n || 0).toLocaleString("en-IN")}`;
  const formatScore = (n) => (n ? `${(n * 100).toFixed(0)}%` : "N/A");

  const scoreColor = () => {
    const score = vendor.recommendationScore;
    if (score >= 0.8) return "#28a745"; // Green
    if (score >= 0.6) return "#ffc107"; // Yellow
    return "#dc3545"; // Red
  };

  return (
    <Card className={`vendor-rec-card ${isSelected ? "selected" : ""}`}>
      <Card.Header
        style={{
          background: `linear-gradient(135deg, ${scoreColor()}20, transparent)`,
          borderLeft: `4px solid ${scoreColor()}`,
        }}
      >
        <Row className="align-items-center">
          <Col xs="auto">
            {vendor.businessLogoUrl && (
              <img
                src={vendor.businessLogoUrl}
                alt={vendor.vendorName}
                className="vendor-logo-sm"
              />
            )}
          </Col>
          <Col>
            <div className="vendor-header">
              <h5 className="mb-0">{vendor.vendorName}</h5>
              <small className="text-muted">{vendor.vendorCity}</small>
            </div>
          </Col>
          <Col xs="auto" className="text-right">
            <div className="recommendation-badge">
              <div className="score-circle" style={{ borderColor: scoreColor() }}>
                <span className="score-value">{(vendor.recommendationScore * 100).toFixed(0)}</span>
                <span className="score-label">Score</span>
              </div>
            </div>
          </Col>
        </Row>
      </Card.Header>

      <Card.Body>
        {/* Reasoning */}
        <div className="reasoning-section mb-3">
          <Badge style={{ backgroundColor: scoreColor() }}>
            <FaTrophy className="me-1" />
            {vendor.reasoning}
          </Badge>
        </div>

        {/* Pricing */}
        <Row className="section-row mb-3">
          <Col xs="6">
            <label className="metric-label">Price Range</label>
            <p className="metric-value">
              {formatCurrency(vendor.priceRangeStart)} - {formatCurrency(vendor.priceRangeEnd)}
            </p>
          </Col>
          <Col xs="6">
            <label className="metric-label">Rating</label>
            <p className="metric-value">
              <FaStar className="text-warning me-2" />
              {vendor.vendorRating}/5
            </p>
          </Col>
        </Row>

        {/* Metrics */}
        <Row className="metrics-row">
          <Col xs="6" sm="3" className="metric-box">
            <label className="metric-label">Acceptance</label>
            <p className="metric-value">{formatScore(vendor.acceptanceRate)}</p>
          </Col>
          <Col xs="6" sm="3" className="metric-box">
            <label className="metric-label">Jobs Done</label>
            <p className="metric-value">{vendor.completedJobs}</p>
          </Col>
          <Col xs="6" sm="3" className="metric-box">
            <label className="metric-label">Response Time</label>
            <p className="metric-value space">
              <FaClock className="me-1" />
              {vendor.avgResponseTimeHours ? `${vendor.avgResponseTimeHours.toFixed(1)}h` : "N/A"}
            </p>
          </Col>
          <Col xs="6" sm="3" className="metric-box">
            <label className="metric-label">Experience</label>
            <p className="metric-value">{vendor.yearsOfExperience || "New"}</p>
          </Col>
        </Row>

        {/* Guest Capacity - if available */}
        {vendor.minGuests || vendor.maxGuests ? (
          <Row className="mt-3">
            <Col>
              <label className="metric-label">Guest Capacity</label>
              <p className="metric-value">
                {vendor.minGuests || "Any"} - {vendor.maxGuests || "Any"} guests
              </p>
            </Col>
          </Row>
        ) : null}
      </Card.Body>

      <Card.Footer>
        <Button
          variant={isSelected ? "success" : "primary"}
          size="sm"
          onClick={() => onSelect(vendor)}
          className="w-100"
        >
          {isSelected ? (
            <>
              <FaCheckCircle className="me-2" />
              Selected
            </>
          ) : (
            "Select This Vendor"
          )}
        </Button>
      </Card.Footer>
    </Card>
  );
};

export default VendorRecommendationCard;
