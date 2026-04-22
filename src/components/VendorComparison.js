import React, { useState, useEffect } from "react";
import { Container, Row, Col, Table, Button, Card, Badge, Spinner, Alert } from "react-bootstrap";
import { FaStar, FaTrophy, FaArrowRight, FaTimes } from "react-icons/fa";
import "./VendorComparison.css";

/**
 * VendorComparison component for side-by-side comparison of multiple vendors.
 * Displays detailed metrics and key differences.
 */
const VendorComparison = ({ vendorIds = [], onClose, onSelectVendor, vendors = [] }) => {
  const [comparisonData, setComparisonData] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  useEffect(() => {
    // If vendors are directly provided, use them
    if (vendors && vendors.length > 0) {
      setComparisonData(vendors);
    }
    // Otherwise, if vendorIds are provided, fetch comparison data
    else if (vendorIds && vendorIds.length > 0) {
      fetchComparisonData();
    }
  }, [vendors, vendorIds]);

  const fetchComparisonData = async () => {
    setLoading(true);
    setError(null);
    try {
      // When using the comparison endpoint from backend
      // const response = await fetch(`/api/events/compare-vendors?vendorIds=${vendorIds.join(',')}`);
      // const data = await response.json();
      // setComparisonData(data);

      // For now, use provided vendors data
      if (vendors && vendors.length > 0) {
        setComparisonData(vendors);
      }
    } catch (err) {
      setError("Failed to fetch comparison data");
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  const formatCurrency = (n) => {
    if (!n || n === 0 || n === null) return "N/A";
    return `₹${Number(n).toLocaleString("en-IN")}`;
  };
  const formatPercentage = (n) => {
    if (!n || n === 0 || n === null) return "N/A";
    return `${(n * 100).toFixed(1)}%`;
  };

  const getBestValue = (fieldName, isHigherBetter = true) => {
    if (!comparisonData || comparisonData.length === 0) return null;

    const values = comparisonData.map((v, idx) => ({
      idx,
      value: v[fieldName] || 0,
    }));

    if (isHigherBetter) {
      return Math.max(...values.map((v) => v.value)) !== 0
        ? values.find((v) => v.value === Math.max(...values.map((v) => v.value)))?.idx
        : null;
    } else {
      return Math.min(...values.map((v) => v.value)) !== Infinity
        ? values.find((v) => v.value === Math.min(...values.map((v) => v.value)))?.idx
        : null;
    }
  };

  const isBest = (idx, fieldName, isHigherBetter = true) => {
    return getBestValue(fieldName, isHigherBetter) === idx;
  };

 // Check if a metric has any valid data
  const hasValidMetricData = (fieldName, checkFunction = null) => {
    return comparisonData.some((vendor) => {
      const value = vendor[fieldName];
      if (checkFunction) return checkFunction(vendor, value);
      return value && value !== 0 && value !== null;
    });
  };

  // Find best vendor based on key metrics
  const getBestVendorIndex = () => {
    if (!comparisonData || comparisonData.length === 0) return 0;

    let bestIdx = 0;
    let bestScore = -1;

    comparisonData.forEach((vendor, idx) => {
      let score = 0;

      // Rating (priority 1)
      if (vendor.vendorRating) score += (vendor.vendorRating / 5) * 30;

      // AI Score (priority 2)
      if (vendor.recommendationScore) score += vendor.recommendationScore * 25;

      // Price - lower is better
      if (vendor.priceRangeStart && vendor.priceRangeEnd) {
        const avgPrice = (vendor.priceRangeStart + vendor.priceRangeEnd) / 2;
        const allPrices = comparisonData
          .filter(v => v.priceRangeStart && v.priceRangeEnd)
          .map(v => (v.priceRangeStart + v.priceRangeEnd) / 2);
        const maxPrice = Math.max(...allPrices);
        const minPrice = Math.min(...allPrices);
        const priceScore = 20 * (1 - (avgPrice - minPrice) / (maxPrice - minPrice || 1));
        score += priceScore;
      }

      // Acceptance rate
      if (vendor.acceptanceRate && vendor.acceptanceRate > 0) {
        score += vendor.acceptanceRate * 15;
      }

      // Response time - lower is better
      if (vendor.avgResponseTimeHours && vendor.avgResponseTimeHours > 0) {
        const allResponseTimes = comparisonData
          .filter(v => v.avgResponseTimeHours && v.avgResponseTimeHours > 0)
          .map(v => v.avgResponseTimeHours);
        const maxResponseTime = Math.max(...allResponseTimes);
        const responseScore = 10 * (1 - vendor.avgResponseTimeHours / maxResponseTime);
        score += responseScore;
      }

      if (score > bestScore) {
        bestScore = score;
        bestIdx = idx;
      }
    });

    return bestIdx;
  };

  const bestVendorIdx = getBestVendorIndex();
  const bestVendor = { idx: bestVendorIdx, score: 85 }; // Score out of 100

  if (loading) {
    return (
      <Container className="comparison-loading my-5">
        <Spinner animation="border" role="status">
          <span className="visually-hidden">Loading...</span>
        </Spinner>
        <p className="mt-3">Fetching vendor comparison...</p>
      </Container>
    );
  }

  if (error) {
    return <Alert variant="danger" className="my-5">{error}</Alert>;
  }

  if (!comparisonData || comparisonData.length === 0) {
    return (
      <Alert variant="info" className="my-5">
        <strong>No vendors to compare</strong>
        <p className="mb-0">Click the "Compare" button on vendor cards to add them here.</p>
      </Alert>
    );
  }

  return (
    <div className="vendor-comparison-container">
      <Container>
        <div className="comparison-header mb-5">
          <div className="header-content">
            <h2>
              <FaTrophy className="me-2" />
              Vendor Comparison
            </h2>
            <p className="text-muted">Detailed side-by-side comparison of selected vendors</p>
          </div>
          {onClose && (
            <Button
              variant="light"
              onClick={onClose}
              className="close-btn"
              aria-label="Close comparison"
            >
              <FaTimes />
            </Button>
          )}
        </div>

        {/* Quick Overview Cards */}
        <Row className="comparison-cards mb-5">
          {comparisonData.map((vendor, idx) => (
            <Col md={6} lg={12 / comparisonData.length} key={idx} className="mb-3">
              <Card className={`vendor-overview-card h-100 ${bestVendor.idx === idx ? "best-vendor-card" : ""}`}>
                <Card.Body>
                  {/* Best Vendor Badge */}
                  {bestVendor.idx === idx && (
                    <div style={{ marginBottom: "15px", padding: "10px", backgroundColor: "rgba(40, 167, 69, 0.1)", borderRadius: "6px", border: "1px solid #28a745" }}>
                      <Badge bg="success" style={{ fontSize: "0.85em", padding: "6px 10px" }}>
                        ⭐ BEST CHOICE
                      </Badge>
                      <div style={{ fontSize: "0.8em", color: "#28a745", marginTop: "6px", fontWeight: "500" }}>
                        Overall Score: {bestVendor.score.toFixed(1)}/100
                      </div>
                    </div>
                  )}

                  <div className="d-flex align-items-start justify-content-between mb-3">
                    <div>
                      <h5 className="mb-1">
                        {vendor.vendorName}
                        {(vendor.isGooglePlace || vendor.googlePlace) && (
                          <Badge bg="info" className="ms-2" style={{ fontSize: "0.7em" }}>
                            Google
                          </Badge>
                        )}
                      </h5>
                      <small className="text-muted">{vendor.vendorCity || vendor.city}</small>
                    </div>
                    {vendor.businessLogoUrl && vendor.businessLogoUrl !== "/default-avatar.png" && (
                      <img src={vendor.businessLogoUrl} alt={vendor.vendorName} className="vendor-img-small" style={{ width: '50px', height: '50px', borderRadius: '4px', objectFit: 'cover' }} />
                    )}
                  </div>

                  <div className="overview-stats">
                    <div className="stat-item">
                      <span className="stat-label">Rating</span>
                      <span className="stat-value">
                        <FaStar className="text-warning me-1" />
                        {(vendor.vendorRating || vendor.rating)?.toFixed(1)}/5
                      </span>
                    </div>
                    {!(vendor.isGooglePlace || vendor.googlePlace) && (
                      <>
                        <div className="stat-item">
                          <span className="stat-label">AI Score</span>
                          <span className="stat-value">{vendor.recommendationScore ? `${(vendor.recommendationScore * 100).toFixed(0)}%` : 'N/A'}</span>
                        </div>
                        <div className="stat-item">
                          <span className="stat-label">Jobs</span>
                          <span className="stat-value">{vendor.completedJobs || 0}</span>
                        </div>
                      </>
                    )}
                    {(vendor.isGooglePlace || vendor.googlePlace) && (
                      <>
                        <div className="stat-item">
                          <span className="stat-label">Reviews</span>
                          <span className="stat-value">{vendor.completedJobs || 0}</span>
                        </div>
                      </>
                    )}
                  </div>

                  {!(vendor.isGooglePlace || vendor.googlePlace) && onSelectVendor && (
                    <Button
                      variant={bestVendor.idx === idx ? "success" : "primary"}
                      size="sm"
                      onClick={() => onSelectVendor(vendor)}
                      className="w-100 mt-3"
                      style={bestVendor.idx === idx ? { fontWeight: "bold" } : {}}
                    >
                      {bestVendor.idx === idx ? "✓ Recommended - Select" : "Select"} <FaArrowRight className="ms-2" />
                    </Button>
                  )}
                  {(vendor.isGooglePlace || vendor.googlePlace) && (
                    <a
                      href={`https://www.google.com/maps/place/?q=place_id:${vendor.externalPlaceId || "error"}`}
                      target="_blank"
                      rel="noopener noreferrer"
                      className="btn btn-info btn-sm mt-3 w-100"
                    >
                      Open in Google Maps
                    </a>
                  )}
                </Card.Body>
              </Card>
            </Col>
          ))}
        </Row>

        {/* Recommendation Summary Section */}
        <Card className="recommendation-summary-card mb-4" style={{ backgroundColor: "#f0f8ff", borderLeft: "5px solid #28a745" }}>
          <Card.Body>
            <div className="d-flex align-items-center justify-content-between">
              <div>
                <h5 className="mb-2" style={{ color: "#28a745" }}>
                  🎯 Our Recommendation
                </h5>
                <p className="mb-0" style={{ fontSize: "0.95em", lineHeight: "1.6" }}>
                  <strong>{comparisonData[bestVendor.idx]?.vendorName}</strong> is your best choice because they offer:
                </p>
                <ul style={{ fontSize: "0.9em", marginTop: "10px", marginBottom: "0" }}>
                  {bestVendor.idx !== null && (
                    <>
                      {comparisonData[bestVendor.idx]?.vendorRating >= 4.5 && (
                        <li>✓ Excellent ratings ({comparisonData[bestVendor.idx]?.vendorRating}/5)</li>
                      )}
                      {comparisonData[bestVendor.idx]?.recommendationScore >= 0.8 && (
                        <li>✓ AI-verified as highly suitable (Score: {(comparisonData[bestVendor.idx]?.recommendationScore * 100).toFixed(0)}%)</li>
                      )}
                      {isBest(bestVendor.idx, "priceRangeStart", false) && (
                        <li>✓ Best budget option (₹{comparisonData[bestVendor.idx]?.priceRangeStart?.toLocaleString("en-IN")} - ₹{comparisonData[bestVendor.idx]?.priceRangeEnd?.toLocaleString("en-IN")})</li>
                      )}
                      {isBest(bestVendor.idx, "acceptanceRate") && comparisonData[bestVendor.idx]?.acceptanceRate > 0 && (
                        <li>✓ Highest reliability ({(comparisonData[bestVendor.idx]?.acceptanceRate * 100).toFixed(0)}% acceptance rate)</li>
                      )}
                      {isBest(bestVendor.idx, "avgResponseTimeHours", false) && comparisonData[bestVendor.idx]?.avgResponseTimeHours > 0 && (
                        <li>✓ Fastest response time ({comparisonData[bestVendor.idx]?.avgResponseTimeHours.toFixed(1)} hours)</li>
                      )}
                      {isBest(bestVendor.idx, "completedJobs") && comparisonData[bestVendor.idx]?.completedJobs > 0 && (
                        <li>✓ Most experienced ({comparisonData[bestVendor.idx]?.completedJobs} completed jobs)</li>
                      )}
                    </>
                  )}
                </ul>
              </div>
              {!(comparisonData[bestVendor.idx]?.isGooglePlace || comparisonData[bestVendor.idx]?.googlePlace) && onSelectVendor && (
                <Button
                  variant="success"
                  size="lg"
                  onClick={() => onSelectVendor(comparisonData[bestVendor.idx])}
                  style={{ height: "fit-content", marginLeft: "20px", whiteSpace: "nowrap" }}
                >
                  ✓ Select Now
                </Button>
              )}
            </div>
          </Card.Body>
        </Card>

        {/* Detailed Comparison Table */}
        <Card className="comparison-table-card">
          <Card.Body className="p-0">
            <div className="table-responsive">
              <Table className="comparison-table mb-0">
                <tbody>
                  {/* Pricing - Only show if not all Google Places and has data */}
                  {!comparisonData.every(v => v.isGooglePlace || v.googlePlace) && hasValidMetricData("priceRangeStart") && (
                    <tr className="comparison-row">
                      <td className="metric-col">
                        <strong>Price Range</strong>
                        <br />
                        <small className="text-muted">Budget Range</small>
                      </td>
                      {comparisonData.map((vendor, idx) => (
                        <td key={idx} className={isBest(idx, "priceRangeStart", false) ? "best-value" : ""}>
                          {(vendor.isGooglePlace || vendor.googlePlace) ? (
                            <small className="text-muted">Contact for pricing</small>
                          ) : vendor.priceRangeStart && vendor.priceRangeEnd ? (
                            <>
                              <div className="value-display">
                                {formatCurrency(vendor.priceRangeStart)} -<br />
                                {formatCurrency(vendor.priceRangeEnd)}
                              </div>
                              {isBest(idx, "priceRangeStart", false) && (
                                <Badge bg="success" className="mt-2">
                                  💰 Best Budget
                                </Badge>
                              )}
                            </>
                          ) : (
                            <small className="text-muted">-</small>
                          )}
                        </td>
                      ))}
                    </tr>
                  )}

                  {/* Acceptance Rate - Only show if has data */}
                  {!comparisonData.every(v => v.isGooglePlace || v.googlePlace) && hasValidMetricData("acceptanceRate", (v, val) => v.acceptanceRate && v.acceptanceRate > 0) && (
                    <tr className="comparison-row">
                      <td className="metric-col">
                        <strong>Acceptance Rate</strong>
                        <br />
                        <small className="text-muted">Reliability</small>
                      </td>
                      {comparisonData.map((vendor, idx) => (
                        <td key={idx} className={isBest(idx, "acceptanceRate") ? "best-value" : ""}>
                          {(vendor.isGooglePlace || vendor.googlePlace) ? (
                            <small className="text-muted">-</small>
                          ) : vendor.acceptanceRate && vendor.acceptanceRate > 0 ? (
                            <>
                              <div className="progress-bar-wrapper">
                                <div
                                  className="progress-bar"
                                  style={{
                                    width: `${(vendor.acceptanceRate || 0) * 100}%`,
                                    backgroundColor: isBest(idx, "acceptanceRate") ? "#28a745" : "#0d6efd",
                                  }}
                                />
                              </div>
                              <span>{formatPercentage(vendor.acceptanceRate || 0)}</span>
                              {isBest(idx, "acceptanceRate") && (
                                <Badge bg="success" className="mt-2">
                                  ✓ Most Reliable
                                </Badge>
                              )}
                            </>
                          ) : (
                            <small className="text-muted">-</small>
                          )}
                        </td>
                      ))}
                    </tr>
                  )}

                  {/* Completed Jobs / Reviews - Always show if available */}
                  {hasValidMetricData("completedJobs", (v) => v.completedJobs && v.completedJobs > 0) && (
                    <tr className="comparison-row">
                      <td className="metric-col">
                        <strong>{comparisonData[0]?.isGooglePlace || comparisonData[0]?.googlePlace ? "Reviews" : "Jobs Completed"}</strong>
                        <br />
                        <small className="text-muted">{comparisonData[0]?.isGooglePlace || comparisonData[0]?.googlePlace ? "User Reviews" : "Experience"}</small>
                      </td>
                      {comparisonData.map((vendor, idx) => (
                        <td key={idx} className={isBest(idx, "completedJobs") ? "best-value" : ""}>
                          {vendor.completedJobs && vendor.completedJobs > 0 ? (
                            <>
                              <div className="value-display">{vendor.completedJobs} {(vendor.isGooglePlace || vendor.googlePlace) ? "reviews" : "jobs"}</div>
                              {isBest(idx, "completedJobs") && (
                                <Badge bg="success" className="mt-2">
                                  {(vendor.isGooglePlace || vendor.googlePlace) ? "👥 Most Reviewed" : "🏆 Most Experienced"}
                                </Badge>
                              )}
                            </>
                          ) : (
                            <small className="text-muted">-</small>
                          )}
                        </td>
                      ))}
                    </tr>
                  )}

                  {/* Average Response Time - Only show if has data */}
                  {!comparisonData.every(v => v.isGooglePlace || v.googlePlace) && hasValidMetricData("avgResponseTimeHours", (v, val) => v.avgResponseTimeHours && v.avgResponseTimeHours > 0) && (
                    <tr className="comparison-row">
                      <td className="metric-col">
                        <strong>Response Time</strong>
                        <br />
                        <small className="text-muted">Speed</small>
                      </td>
                      {comparisonData.map((vendor, idx) => (
                        <td key={idx} className={isBest(idx, "avgResponseTimeHours", false) ? "best-value" : ""}>
                          {(vendor.isGooglePlace || vendor.googlePlace) ? (
                            <small className="text-muted">-</small>
                          ) : vendor.avgResponseTimeHours && vendor.avgResponseTimeHours > 0 ? (
                            <>
                              <div className="value-display">
                                {vendor.avgResponseTimeHours.toFixed(1)} hrs
                              </div>
                              {isBest(idx, "avgResponseTimeHours", false) && (
                                <Badge bg="success" className="mt-2">
                                  ⚡ Fastest
                                </Badge>
                              )}
                            </>
                          ) : (
                            <small className="text-muted">-</small>
                          )}
                        </td>
                      ))}
                    </tr>
                  )}

                  {/* Years of Experience - Only show if has data */}
                  {!comparisonData.every(v => v.isGooglePlace || v.googlePlace) && hasValidMetricData("yearsOfExperience", (v, val) => v.yearsOfExperience && v.yearsOfExperience > 0) && (
                    <tr className="comparison-row">
                      <td className="metric-col">
                        <strong>Experience</strong>
                        <br />
                        <small className="text-muted">Years</small>
                      </td>
                      {comparisonData.map((vendor, idx) => (
                        <td key={idx} className={isBest(idx, "yearsOfExperience") ? "best-value" : ""}>
                          {(vendor.isGooglePlace || vendor.googlePlace) ? (
                            <small className="text-muted">-</small>
                          ) : vendor.yearsOfExperience && vendor.yearsOfExperience > 0 ? (
                            <>
                              <div className="value-display">{vendor.yearsOfExperience} years</div>
                              {isBest(idx, "yearsOfExperience") && (
                                <Badge bg="success" className="mt-2">
                                  📚 Most Experienced
                                </Badge>
                              )}
                            </>
                          ) : (
                            <small className="text-muted">-</small>
                          )}
                        </td>
                      ))}
                    </tr>
                  )}

                  {/* Rating - Always show */}
                  <tr className="comparison-row">
                    <td className="metric-col">
                      <strong>Rating</strong>
                      <br />
                      <small className="text-muted">Customer Satisfaction</small>
                    </td>
                    {comparisonData.map((vendor, idx) => (
                      <td key={idx} className={isBest(idx, "vendorRating") ? "best-value" : ""}>
                        <div className="value-display">
                          <FaStar className="text-warning me-1" />
                          {(vendor.vendorRating || vendor.rating)?.toFixed(1)}/5
                        </div>
                        {isBest(idx, "vendorRating") && (
                          <Badge bg="success" className="mt-2">
                            ⭐ Highest Rated
                          </Badge>
                        )}
                      </td>
                    ))}
                  </tr>

                  {/* AI Score - Only for DB vendors */}
                  {comparisonData.some(v => !v.isGooglePlace && !v.googlePlace && v.recommendationScore) && (
                    <tr className="comparison-row">
                      <td className="metric-col">
                        <strong>AI Score</strong>
                        <br />
                        <small className="text-muted">Recommendation</small>
                      </td>
                      {comparisonData.map((vendor, idx) => (
                        <td key={idx} className={isBest(idx, "recommendationScore") ? "best-value" : ""}>
                          {(vendor.isGooglePlace || vendor.googlePlace) ? (
                            <small className="text-muted">-</small>
                          ) : vendor.recommendationScore ? (
                            <>
                              <div className="value-display">
                                {(vendor.recommendationScore * 100).toFixed(0)}%
                              </div>
                              {isBest(idx, "recommendationScore") && (
                                <Badge bg="success" className="mt-2">
                                  🤖 AI Recommended
                                </Badge>
                              )}
                            </>
                          ) : (
                            <small className="text-muted">-</small>
                          )}
                        </td>
                      ))}
                    </tr>
                  )}

                  {/* Services - Only show if has data */}
                  {comparisonData.some(v => v.services && v.services.length > 0) && (
                    <tr className="comparison-row">
                      <td className="metric-col">
                        <strong>Services</strong>
                        <br />
                        <small className="text-muted">Offerings</small>
                      </td>
                      {comparisonData.map((vendor, idx) => (
                        <td key={idx}>
                          <div className="services-list">
                            {vendor.services && vendor.services.length > 0 ? (
                              vendor.services.map((svc, sidx) => (
                                <Badge key={sidx} bg="light" text="dark" className="me-2 mb-2">
                                  {svc}
                                </Badge>
                              ))
                            ) : (
                              <span className="text-muted">{(vendor.isGooglePlace || vendor.googlePlace) ? "Check on Google Maps" : "-"}</span>
                            )}
                          </div>
                        </td>
                      ))}
                    </tr>
                  )}

                  {/* Description / Address - Only show if has data */}
                  {comparisonData.some(v => v.description || v.formatted_address || v.businessDescription) && (
                    <tr className="comparison-row">
                      <td className="metric-col">
                        <strong>{comparisonData[0]?.isGooglePlace || comparisonData[0]?.googlePlace ? "Address" : "About"}</strong>
                        <br />
                        <small className="text-muted">{comparisonData[0]?.isGooglePlace || comparisonData[0]?.googlePlace ? "Location" : "Description"}</small>
                      </td>
                      {comparisonData.map((vendor, idx) => (
                        <td key={idx}>
                          <small className="text-muted">
                            {(vendor.isGooglePlace || vendor.googlePlace)
                              ? (vendor.description || vendor.formatted_address || "No address available")
                              : (vendor.description || vendor.businessDescription || "-")}
                          </small>
                        </td>
                      ))}
                    </tr>
                  )}
                </tbody>
              </Table>
            </div>
          </Card.Body>
        </Card>
                    

        {/* Selection Footer */}
        <div className="comparison-footer mt-5 text-center">
          <p className="text-muted mb-3">
            {comparisonData.every(v => v.isGooglePlace || v.googlePlace)
              ? "Google vendors are available on Google Maps. Click 'Open in Google Maps' to contact them."
              : "Select a vendor above to proceed with booking"}
          </p>
          {onClose && (
            <Button variant="outline-secondary" onClick={onClose}>
              Back to Search
            </Button>
          )}
        </div>
      </Container>
    </div>
  );
};

export default VendorComparison;
