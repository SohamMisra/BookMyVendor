import React from "react";
import { Card, Row, Col, Button, Badge } from "react-bootstrap";
import { FaStar, FaExchangeAlt, FaMapMarkerAlt, FaClock, FaCheckCircle, FaRupeeSign } from "react-icons/fa";
import { motion } from "framer-motion";
import "./UnifiedVendorCard.css";

/**
 * UnifiedVendorCard - Displays both DB and Google vendors in a clean, unified design
 * Features:
 * - AI Recommendation Score (for DB vendors, placeholder for Google)
 * - Compare button (for both)
 * - Clean image display
 * - Graceful handling of missing data
 * - Responsive layout
 */
const UnifiedVendorCard = ({
  vendor,
  serviceId,
  isSelectedForService = false,
  isInCompare = false,
  onSelect,
  onCompare,
  showServiceButtons = true,
}) => {
  const formatCurrency = (n) => {
    if (!n || n === 0) return "N/A";
    return `₹${Number(n).toLocaleString("en-IN")}`;
  };

  const formatScore = (n) => {
    if (!n || n === 0) return "N/A";
    return `${(n * 100).toFixed(0)}%`;
  };

  const getRecommendationColor = () => {
    const score = vendor.recommendationScore;
    if (!score || score === 0) return "#6c757d"; // gray (no score)
    if (score >= 0.8) return "#28a745"; // green
    if (score >= 0.6) return "#ffc107"; // yellow
    return "#dc3545"; // red
  };

  const hasRecommendationData = vendor.recommendationScore && vendor.recommendationScore > 0;
  const isGoogleVendor = vendor.isGooglePlace || vendor.googlePlace || vendor.externalPlaceId !== null && !vendor.vendorServiceId;

  // Handle image loading errors
  const [imageError, setImageError] = React.useState(false);
  const imageUrl = vendor.businessLogoUrl;
  const canDisplayImage = imageUrl && imageUrl !== "/default-avatar.png";

  return (
    <motion.div
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.5 }}
      whileHover={{ y: -5 }}
    >
      <Card className="unified-vendor-card h-100 position-relative">
        {/* Badge Section - Top of Card */}
        <div className="badge-section" style={{ position: 'absolute', top: '10px', right: '10px', zIndex: 10, display: 'flex', gap: '8px' }}>
          {/* AI Score Badge - For DB Vendors */}
          {!isGoogleVendor && hasRecommendationData && (
            <div
              className="score-badge"
              style={{
                borderColor: getRecommendationColor(),
                backgroundColor: `${getRecommendationColor()}15`,
                borderRadius: '50%',
                width: '50px',
                height: '50px',
                display: 'flex',
                flexDirection: 'column',
                alignItems: 'center',
                justifyContent: 'center',
                border: `2px solid ${getRecommendationColor()}`,
              }}
              title="AI Recommendation Score"
            >
              <div className="score-value" style={{ color: getRecommendationColor(), fontSize: '0.85rem', fontWeight: 'bold' }}>
                {`${(vendor.recommendationScore * 100).toFixed(0)}`}
              </div>
              <div className="score-label" style={{ color: getRecommendationColor(), fontSize: '0.65rem' }}>Score</div>
            </div>
          )}

          {/* Google Badge */}
          {isGoogleVendor && (
            <Badge bg="info" style={{ height: 'fit-content' }}>Google</Badge>
          )}
        </div>

        <Card.Body className="d-flex flex-column">
          {/* Header: Name + Rating */}
          <div className="card-header-section mb-3">
            <div className="d-flex align-items-start justify-content-between mb-2">
              <div>
                <h5 className="mb-1" style={{ lineHeight: "1.3" }}>
                  {vendor.vendorName.length > 40
                    ? vendor.vendorName.substring(0, 40) + "..."
                    : vendor.vendorName}
                </h5>
                <small className="text-muted d-flex align-items-center">
                  <FaMapMarkerAlt className="me-1" style={{ fontSize: "0.75rem" }} />
                  {vendor.vendorCity}
                </small>
              </div>
            </div>

            {/* Reasoning Badge */}
            {hasRecommendationData && vendor.reasoning && (
              <Badge style={{ backgroundColor: getRecommendationColor() }} className="mb-2">
                {vendor.reasoning}
              </Badge>
            )}

            {/* Rating */}
            <div className="d-flex align-items-center">
              <FaStar className="text-warning me-1" style={{ fontSize: "0.875rem" }} />
              <small className="fw-semibold">
                {vendor.vendorRating ? `${vendor.vendorRating.toFixed(1)}/5` : "N/A"}
              </small>
            </div>
          </div>

          {/* Image Section */}
          {canDisplayImage && !imageError ? (
            <div className="image-section mb-3">
              <img
                src={imageUrl}
                alt={vendor.vendorName}
                className="vendor-image"
                onError={() => setImageError(true)}
                style={{
                  width: "100%",
                  height: "150px",
                  objectFit: "cover",
                  borderRadius: "8px",
                  backgroundColor: "#f0f0f0",
                }}
              />
            </div>
          ) : (
            <div
              className="image-placeholder mb-3"
              style={{
                width: "100%",
                height: "150px",
                backgroundColor: "#f0f0f0",
                borderRadius: "8px",
                display: "flex",
                alignItems: "center",
                justifyContent: "center",
                color: "#999",
              }}
            >
              <small>No Image</small>
            </div>
          )}

          {/* Metrics Section */}
          <div className="metrics-section mb-3">
            {/* DB Vendor Metrics */}
            {!isGoogleVendor && (
              <>
                {/* Price Range */}
                <div className="metric-row">
                  <small className="metric-label">
                    <FaRupeeSign className="me-1" /> Price Range
                  </small>
                  <small className="metric-value fw-semibold">
                    {vendor.priceRangeStart && vendor.priceRangeEnd
                      ? `${formatCurrency(vendor.priceRangeStart)} - ${formatCurrency(vendor.priceRangeEnd)}`
                      : "N/A"}
                  </small>
                </div>

                {/* Guest Capacity */}
                {(vendor.minGuests || vendor.maxGuests) && (
                  <div className="metric-row">
                    <small className="metric-label">Guest Capacity</small>
                    <small className="metric-value fw-semibold">
                      {vendor.minGuests || "Any"} - {vendor.maxGuests || "Any"}
                    </small>
                  </div>
                )}

                {/* Acceptance Rate */}
                {vendor.acceptanceRate && vendor.acceptanceRate > 0 && (
                  <div className="metric-row">
                    <small className="metric-label">Acceptance Rate</small>
                    <small className="metric-value fw-semibold">
                      {formatScore(vendor.acceptanceRate)}
                    </small>
                  </div>
                )}

                {/* Response Time */}
                {vendor.avgResponseTimeHours && vendor.avgResponseTimeHours > 0 && (
                  <div className="metric-row">
                    <small className="metric-label">
                      <FaClock className="me-1" /> Response Time
                    </small>
                    <small className="metric-value fw-semibold">
                      {vendor.avgResponseTimeHours.toFixed(1)} hrs
                    </small>
                  </div>
                )}

                {/* Completed Jobs */}
                {vendor.completedJobs && vendor.completedJobs > 0 && (
                  <div className="metric-row">
                    <small className="metric-label">Completed Jobs</small>
                    <small className="metric-value fw-semibold">{vendor.completedJobs}</small>
                  </div>
                )}
              </>
            )}

            {/* Google Vendor Metrics */}
            {isGoogleVendor && (
              <>
                {/* Address */}
                {vendor.description && (
                  <div className="metric-row">
                    <small className="metric-label">Address</small>
                    <small className="metric-value text-muted" style={{ fontSize: "0.75rem" }}>
                      {vendor.description.length > 80
                        ? vendor.description.substring(0, 80) + "..."
                        : vendor.description}
                    </small>
                  </div>
                )}

                {/* Reviews Count */}
                {vendor.completedJobs && (
                  <div className="metric-row">
                    <small className="metric-label">Reviews</small>
                    <small className="metric-value fw-semibold">{vendor.completedJobs}</small>
                  </div>
                )}
              </>
            )}
          </div>

          {/* Action Buttons */}
          <div className="mt-auto">
            <Row className="g-2">
              {/* Compare Button - Always Show for all vendors */}
              <Col xs={showServiceButtons ? 6 : 12}>
                <Button
                  variant={isInCompare ? "warning" : "outline-secondary"}
                  size="sm"
                  className="w-100"
                  onClick={() => onCompare(vendor)}
                  title={isInCompare ? "Remove from comparison" : "Add to comparison"}
                >
                  <FaExchangeAlt className="me-1" style={{ fontSize: "0.875rem" }} />
                  {isInCompare ? "In Compare" : "Compare"}
                </Button>
              </Col>

              {/* Service-Specific Select Button - Show for both DB and Google vendors */}
              {showServiceButtons && serviceId && (
                <Col xs={6}>
                  <Button
                    variant={isSelectedForService ? "success" : "primary"}
                    size="sm"
                    className="w-100"
                    onClick={() => onSelect(vendor)}
                  >
                    {isSelectedForService ? (
                      <>
                        <FaCheckCircle className="me-1" style={{ fontSize: "0.875rem" }} />
                        Selected
                      </>
                    ) : (
                      "Select"
                    )}
                  </Button>
                </Col>
              )}

              {/* Open in Google Maps - For Google vendors only (if no Select button) */}
              {isGoogleVendor && (showServiceButtons || serviceId) && (
                <Col xs={showServiceButtons ? 6 : 12}>
                  <a
                    href={`https://www.google.com/maps/place/?q=place_id:${vendor.externalPlaceId || "error"}`}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="btn btn-info btn-sm w-100"
                    style={{ fontSize: "0.875rem" }}
                  >
                    View on Maps
                  </a>
                </Col>
              )}
            </Row>
          </div>
        </Card.Body>
      </Card>
    </motion.div>
  );
};

export default UnifiedVendorCard;

