import React, { useEffect, useState } from "react";
import {
  Container,
  Row,
  Col,
  Card,
  Button,
  Form,
  Modal,
} from "react-bootstrap";
import { motion } from "framer-motion";
import axios from "axios";
import {
  FaSearch,
  FaStar,
  FaExchangeAlt,
  FaMapMarkerAlt,
  FaCalendarAlt,
  FaUsers,
  FaRupeeSign,
  FaCheckCircle,
  FaArrowRight,
} from "react-icons/fa";
import BookingModal from "../components/BookingModal";
import VendorRecommendationCard from "../components/VendorRecommendationCard";
import VendorComparison from "../components/VendorComparison";
import UnifiedVendorCard from "../components/UnifiedVendorCard";
import {
  fetchAllServicesAvailable,
  fetchAllEventTypes,
  fetchRecommendedVendors,
  fetchVendorComparison,
} from "../services/api";

// Google Places API utility
const GOOGLE_API_KEY = process.env.GOOGLEPLACES_API_KEY; // Replace with your actual key
const googlePlacesSearch = async (query, location) => {
  const url = `https://maps.googleapis.com/maps/api/place/textsearch/json?query=${encodeURIComponent(query + ' in ' + location)}&key=${GOOGLE_API_KEY}`;
  try {
    const response = await axios.get(url);
    return response.data.results || [];
  } catch (err) {
    console.error("Google Places API error", err);
    return [];
  }
};

// Convert Google Place data to vendor format compatible with comparison
const convertGooglePlaceToVendor = (place, index) => ({
  vendorId: `google_${place.place_id}`,
  isGooglePlace: true,
  vendorName: place.name,
  businessName: place.name,
  vendorRating: place.rating || 0,
  rating: place.rating || 0,
  city: place.formatted_address?.split(',')[1]?.trim() || 'N/A',
  location: place.formatted_address || 'N/A',
  formatted_address: place.formatted_address,
  priceRangeStart: 0,
  priceRangeEnd: 0,
  businessDescription: `Rating: ${place.rating || 'N/A'} • ${place.user_ratings_total || 0} reviews`,
  businessLogoUrl: place.photos?.[0] ? `https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${place.photos[0].photo_reference}&key=${GOOGLE_API_KEY}` : '/default-avatar.png',
  completedJobs: place.user_ratings_total || 0,
  acceptanceRate: (place.rating || 5) / 5,
  yearsOfExperience: 0,
  avgResponseTimeHours: 24,
  services: [],
  googlePlaceId: place.place_id,
  googlePlace: true
});

const eventServiceMap = {
  Wedding: [
    "venue",
    "catering",
    "decoration",
    "photography",
    "music & dj",
    "floral",
    "transportation",
    "makeup & styling",
  ],
  Birthday: ["venue", "catering", "decoration", "photography", "music & dj"],
  Conference: ["venue", "catering", "transportation", "security"],
  Engagement: [
    "venue",
    "catering",
    "decoration",
    "photography",
    "music & dj",
    "floral",
    "makeup & styling",
  ],
  Graduation: ["venue", "catering", "photography", "music & dj"],
  "Baby Shower": ["venue", "catering", "decoration", "photography"],
  "Religious Event": [
    "venue",
    "catering",
    "decoration",
    "photography",
    "music & dj",
  ],
  "House Ceremony": [
    "venue",
    "catering",
    "decoration",
    "photography",
    "music & dj",
  ],
  Upanayana: [
    "venue",
    "catering",
    "decoration",
    "photography",
    "music & dj",
    "transportation",
  ],
};

const SearchAndBook = () => {
  // form state
  const [eventType, setEventType] = useState({});
  const [states, setStates] = useState([]);
  const [cities, setCities] = useState([]);
  const [selectedState, setSelectedState] = useState("");
  const [selectedCity, setSelectedCity] = useState("");
  const [location, setLocation] = useState("");
  const [date, setDate] = useState("");
  const [totalBudget, setTotalBudget] = useState("0");
  const [guestCount, setGuestCount] = useState("");

  // fetched lists
  const [services, setServices] = useState([]); // will hold array of Services objects from backend
  const [eventTypesList, setEventTypesList] = useState([]);

  // selection/budgets keyed by serviceId (string)
  const [selectedServices, setSelectedServices] = useState({});
  const [budgets, setBudgets] = useState({});

  // UI
  const [compareList, setCompareList] = useState([]);
  const [isSearching, setIsSearching] = useState(false);
  const [showResults, setShowResults] = useState(false);
  const [showBookingModal, setShowBookingModal] = useState(false);
  const [showComparisonView, setShowComparisonView] = useState(false);
  // removed single bookingVendor approach; we'll store selected vendors per service
  const [bookingVendor, setBookingVendor] = useState(null);
  const [recommendedByService, setRecommendedByService] = useState({}); // { [serviceId]: [vendor,...] }

  // Google Places results
  const [googleVendors, setGoogleVendors] = useState([]);
  const [showGoogleResults, setShowGoogleResults] = useState(false);

  // NEW: selected vendor per serviceId -> vendor object
  const [selectedVendorsByService, setSelectedVendorsByService] = useState({});

  // helpers
  const formatCurrency = (n) => `₹${Number(n || 0).toLocaleString("en-IN")}`;
  const rangeBackground = (value, min, max, activeColor = "#0d6efd") => {
    const v = Number(value || 0);
    const pct = Math.max(
      0,
      Math.min(100, Math.round(((v - min) / (max - min)) * 100))
    );
    return {
      background: `linear-gradient(to right, ${activeColor} ${pct}%, #e9ecef ${pct}%)`,
    };
  };

  // load services & event types once
  useEffect(() => {
    (async () => {
      try {
        const svcResp = await fetchAllServicesAvailable();
        const svcList = svcResp?.data ?? svcResp ?? [];
        setServices(svcList);

        const typesResp = await fetchAllEventTypes();
        const typesList = typesResp?.data ?? typesResp ?? [];
        setEventTypesList(typesList);

        // initialize selectedServices & budgets keyed by serviceId (string)
        const selectedInit = {};
        const budgetsInit = {};
        svcList.forEach((s) => {
          const keyName = (s.name || "").toString().toLowerCase();
          // default enable core services
          selectedInit[String(s.serviceId)] = [
            "venue",
            "catering",
            "photography",
          ].includes(keyName);
          // sensible budgets defaults for core services
          if (keyName === "catering") budgetsInit[String(s.serviceId)] = 200000;
          if (keyName === "venue") budgetsInit[String(s.serviceId)] = 15000;
          if (keyName === "photography")
            budgetsInit[String(s.serviceId)] = 15000;
        });
        setSelectedServices(selectedInit);
        setBudgets(budgetsInit);
      } catch (err) {
        console.error("Failed to load services/event types", err);
      }
    })();

    const fetchStates = async () => {
      try {
        const res = await fetch(
          "https://countriesnow.space/api/v0.1/countries/states",
          {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ country: "India" }),
          }
        );
        const data = await res.json();
        setStates(data.data.states.map((s) => s.name));
      } catch (err) {
        console.error("Failed to fetch states", err);
      }
    };

    fetchStates();
  }, []);

  const fetchCities = async (state) => {
    try {
      const res = await fetch(
        "https://countriesnow.space/api/v0.1/countries/state/cities",
        {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            country: "India",
            state,
          }),
        }
      );
      const data = await res.json();
      setCities(data.data);
    } catch (err) {
      console.error("Failed to fetch cities", err);
    }
  };

  useEffect(() => {
    if (selectedCity && selectedState) {
      setLocation(`${selectedCity}, ${selectedState}, India`);
    }
  }, [selectedCity, selectedState]);


  // map available services by event type — using services state (not the fetch function)
  const availableServices = services.filter((s) => {
    const keyName = (s.name || "").toString().toLowerCase();
    return (eventServiceMap[eventType.name] || []).includes(keyName);
  });

  // when eventType changes: enable core services only for available ones
  useEffect(() => {
    setSelectedServices((prev) => {
      const next = { ...prev };
      availableServices.forEach((s) => {
        const keyName = (s.name || "").toString().toLowerCase();
        next[String(s.serviceId)] = [
          "venue",
          "catering",
          "photography",
        ].includes(keyName);
      });
      return next;
    });
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [eventType, services]);

  const toggleService = (serviceId) => {
    setSelectedServices((prev) => {
      const next = { ...prev, [String(serviceId)]: !prev[String(serviceId)] };
      // if service is turned off, also remove any selected vendor for that service
      if (!next[String(serviceId)]) {
        setSelectedVendorsByService((pv) => {
          const copy = { ...pv };
          delete copy[String(serviceId)];
          return copy;
        });
      }
      return next;
    });
  };

  const handleBudgetChange = (serviceId, value) => {
    setBudgets((prev) => ({ ...prev, [String(serviceId)]: value }));
  };


  const toggleCompare = (vendor) => {
    setCompareList((prev) => {
      const existingIndex = prev.findIndex((v) => v.vendorId === vendor.vendorId);
      if (existingIndex > -1) {
        // Remove if already exists
        return prev.filter((_, idx) => idx !== existingIndex);
      }
      // Add if not comparing more than 3 vendors
      if (prev.length < 3) {
        return [...prev, vendor];
      }
      return prev;
    });
  };

  // recommendedVendors (same approach as earlier)
  const recommendedVendors = async (serviceId) => {
    const fetchFor = async (id) => {
      if (recommendedByService[id]) return recommendedByService[id];
      const params = {
        serviceId: String(id),
        city: location.split(",")[0] || "",
        eventDate: date,
        guestCount: String(guestCount),
      };
      try {
        const resp = await fetchRecommendedVendors(params);
        const list = resp?.data ?? resp ?? [];
        setRecommendedByService((prev) => ({ ...prev, [id]: list }));
        return list;
      } catch (err) {
        console.error("Error fetching recommended vendors for", id, err);
        setRecommendedByService((prev) => ({ ...prev, [id]: [] }));
        return [];
      }
    };

    if (serviceId) return await fetchFor(String(serviceId));

    const toFetch = Object.keys(selectedServices).filter(
      (id) => selectedServices[id]
    );
    if (toFetch.length === 0) return {};
    setIsSearching(true);
    try {
      const promises = toFetch.map((id) =>
        fetchFor(id)
          .then((list) => ({ id, list }))
          .catch(() => ({ id, list: [] }))
      );
      const results = await Promise.all(promises);
      const next = { ...recommendedByService };
      results.forEach((r) => (next[r.id] = r.list));
      setRecommendedByService(next);
      return next;
    } finally {
      setIsSearching(false);
    }
  };

  // select/deselect vendor for a given service
  const selectVendorForService = (serviceId, vendor) => {
    setSelectedVendorsByService((prev) => {
      const key = String(serviceId);
      // toggle: if same vendor is already selected, unselect; otherwise set
      if (prev[key] && prev[key].vendorId === vendor.vendorId) {
        const copy = { ...prev };
        delete copy[key];
        return copy;
      }
      return { ...prev, [key]: vendor };
    });
  };

  const VendorCard = ({ vendor, serviceId }) => {
    const isSelectedForThisService =
      selectedVendorsByService[String(serviceId)] &&
      selectedVendorsByService[String(serviceId)].vendorId === vendor.vendorId;

    return (
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.5 }}
        whileHover={{ y: -5 }}
      >
        <Card className="card-modern h-100 position-relative">
          <Card.Body className="d-flex flex-column">
            <Card.Title className="d-flex justify-content-between align-items-start">
              <span>{vendor.vendorName}</span>
              {isSelectedForThisService ? (
                <Button
                  variant={
                    isSelectedForThisService ? "success" : "outline-primary"
                  }
                  size="sm"
                  onClick={() => selectVendorForService(serviceId, vendor)}
                >
                  <>
                    <FaCheckCircle className="me-1" /> Selected
                  </>
                </Button>
              ) : null}
            </Card.Title>
            <div className="align-items-center d-flex flex-column">
              <a
                href={vendor.businessLogoUrl || null}
                target="_blank"
                rel="noopener noreferrer"
              >
                <img
                  src={vendor.businessLogoUrl || "/default-avatar.png"}
                  alt="Profile"
                  className="rounded-rectangle mb-3"
                  style={{
                    width: 300,
                    height: 150,
                    borderRadius: "8px",
                    objectFit: "cover",
                    marginTop: 10,
                  }}
                />
              </a>
              <small>Press on image to view</small>
            </div>
            <small className="text-muted fw-bold d-flex align-items-center">
              <FaStar className="me-1" /> {vendor.vendorRating}
            </small>
            <small className="text-muted fw-bold d-flex align-items-center">
              <FaMapMarkerAlt className="me-1" /> {vendor.vendorCity}
            </small>

            <div className="mt-auto">
              <Row className="g-2">
                <Col xs={12} lg={6}>
                  <Button
                    variant={compareList.find(v => v.vendorId === vendor.vendorId) ? "warning" : "outline-secondary"}
                    size="sm"
                    className="w-100"
                    onClick={() => toggleCompare(vendor)}
                    title="Add to comparison"
                  >
                    <FaExchangeAlt className="me-1" />
                    {compareList.find(v => v.vendorId === vendor.vendorId) ? "In Compare" : "Compare"}
                  </Button>
                </Col>
                <Col xs={12} lg={6}>
                  <Button
                    variant="primary"
                    size="sm"
                    className="w-100"
                    onClick={() => selectVendorForService(serviceId, vendor)}
                  >
                    {isSelectedForThisService ? "Unselect" : "Select"}
                  </Button>
                </Col>
              </Row>
            </div>
          </Card.Body>
        </Card>
      </motion.div>
    );
  };

  // budget caps indexed by lowercased service name
  const budgetCapsByServiceName = {
    catering: 500000,
    venue: 1000000,
    photography: 300000,
    decoration: 400000,
    transportation: 200000,
    "music & dj": 200000,
    flowers: 150000,
    security: 150000,
    "makeup & styling": 250000,
  };

  // compute required services (those available & selected)
  const requiredServiceIds = availableServices
    .filter((s) => selectedServices[String(s.serviceId)])
    .map((s) => String(s.serviceId));

  const allServicesHaveSelection = requiredServiceIds.every((id) =>
    Boolean(selectedVendorsByService[id])
  );

  return (
    <Container className="my-4 fade-in">
      <motion.div
        initial={{ opacity: 0, y: -20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.6 }}
      >
        <div className="d-flex justify-content-between align-items-center mb-4">
          <div>
            <h1 className="mb-0 gradient-text">Plan Your Perfect Event</h1>
            <p className="text-muted">
              Find and book the best vendors for your special day
            </p>
          </div>
          {compareList.length > 0 && (
            <Button variant="warning" className="btn-modern" onClick={() => setShowComparisonView(true)}>
              <FaExchangeAlt className="me-2" />
              Compare ({compareList.length})
            </Button>
          )}
        </div>
      </motion.div>

      <Card className="card-modern mb-4 p-4">
        <Form>
          <Row className="mb-4">
            <Col md={6}>
              <Form.Group>
                <Form.Label className="fw-semibold">
                  <FaCalendarAlt className="me-2 text-primary" /> Event Type
                </Form.Label>
                <Form.Select
                  value={eventType?.eventTypeId ?? ""}
                  onChange={(e) => {
                    const id = Number(e.target.value);
                    const found = eventTypesList.find(
                      (t) => Number(t.eventTypeId) === id
                    );
                    if (found) {
                      setEventType(found);
                    } else {
                      // fallback: keep a minimal object
                      setEventType({
                        name: String(e.target.value),
                        eventTypeId: id,
                      });
                    }
                  }}
                  className="form-control-modern"
                >
                  <option value="">Select event type</option>
                  {eventTypesList.map((t) => (
                    <option key={t.eventTypeId} value={t.eventTypeId}>
                      {t.name}
                    </option>
                  ))}
                </Form.Select>
              </Form.Group>
            </Col>
            <Col md={6}>
              <Form.Group>
                <Form.Label className="fw-semibold">
                  <FaMapMarkerAlt className="me-2 text-danger" /> Location
                </Form.Label>

                {location === "" && selectedState === "" && (
                  <Form.Select
                    className="mb-2"
                    value={selectedState}
                    onChange={(e) => {
                      const state = e.target.value;
                      setSelectedState(state);
                      setSelectedCity("");
                      setCities([]);
                      fetchCities(state);
                    }}
                  >
                    <option value="">Select State</option>
                    {states.map((state) => (
                      <option key={state} value={state}>
                        {state}
                      </option>
                    ))}
                  </Form.Select>
                )}

                {location === "" && selectedState !== "" && (
                  <Form.Select
                    className="mb-2"
                    value={selectedCity}
                    onChange={(e) => setSelectedCity(e.target.value)}
                    disabled={!selectedState}
                  >
                    <option value="">Select City</option>
                    {cities.map((city) => (
                      <option key={city} value={city}>
                        {city}
                      </option>
                    ))}
                  </Form.Select>
                )}

                {location !== "" && (
                  <Form.Control
                    type="text"
                    value={location}
                    readOnly
                    className="form-control-modern"
                    placeholder="City, State, India"
                  />
                )}
              </Form.Group>
            </Col>
          </Row>

          <Row className="mb-4">
            <Col md={4}>
              <Form.Group>
                <Form.Label className="fw-semibold">
                  <FaCalendarAlt className="me-2 text-success" /> Event Date
                </Form.Label>
                <Form.Control
                  type="date"
                  value={date}
                  onChange={(e) => setDate(e.target.value)}
                  className="form-control-modern"
                />
              </Form.Group>
            </Col>
            <Col md={4}>
              <Form.Group>
                <Form.Label className="fw-semibold">
                  <FaUsers className="me-2 text-info" /> Guest Count
                </Form.Label>
                <Form.Control
                  type="number"
                  value={guestCount}
                  onChange={(e) => setGuestCount(e.target.value)}
                  className="form-control-modern"
                  placeholder="Number of guests"
                />
              </Form.Group>
            </Col>
            <Col md={4}>
              <Form.Group>
                <Form.Label className="fw-semibold d-flex justify-content-between">
                  <span>
                    <FaRupeeSign className="me-2 text-warning" /> Total Budget
                  </span>
                  <span className="text-primary">
                    {formatCurrency(totalBudget)}
                  </span>
                </Form.Label>
                <Form.Range
                  min={10000}
                  max={2000000}
                  step={10000}
                  value={Number(totalBudget)}
                  onChange={(e) => setTotalBudget(e.target.value)}
                  aria-label="Total budget"
                  style={rangeBackground(totalBudget, 10000, 2000000)}
                />
                <div className="d-flex justify-content-between small text-muted">
                  <span>{formatCurrency(10000)}</span>
                  <span>{formatCurrency(2000000)}</span>
                </div>
              </Form.Group>
            </Col>
          </Row>

          <Form.Label className="fw-semibold mb-3">Select Services:</Form.Label>
          <Row className="mb-4">
            {availableServices.map(({ name, serviceId, iconUrl, color }) => (
              <Col md={3} key={serviceId} className="mb-3">
                <Card
                  className={`service-card ${
                    selectedServices[String(serviceId)] ? "selected" : ""
                  }`}
                  onClick={() => toggleService(serviceId)}
                  style={{
                    cursor: "pointer",
                    borderColor: selectedServices[String(serviceId)]
                      ? color
                      : "#e2e8f0",
                    backgroundColor: selectedServices[String(serviceId)]
                      ? `${color}10`
                      : "white",
                  }}
                >
                  <Card.Body className="text-center p-3">
                    <div style={{ fontSize: "2rem" }}>{iconUrl}</div>
                    <div className="fw-semibold mt-2">{name}</div>
                    <Form.Check
                      type="checkbox"
                      checked={!!selectedServices[String(serviceId)]}
                      readOnly
                      className="mt-2"
                    />
                  </Card.Body>
                </Card>
              </Col>
            ))}
          </Row>

          {availableServices.map(({ name, serviceId, color }) => {
            if (!selectedServices[String(serviceId)]) return null;
            const max =
              budgetCapsByServiceName[(name || "").toLowerCase()] || 500000;
            const val = Number(budgets[String(serviceId)] || 0);
            return (
              <motion.div
                key={serviceId}
                initial={{ opacity: 0, height: 0 }}
                animate={{ opacity: 1, height: "auto" }}
                exit={{ opacity: 0, height: 0 }}
              >
                <Form.Group className="mb-3">
                  <Form.Label
                    className="fw-semibold d-flex justify-content-between"
                    style={{ color }}
                  >
                    <span>Budget for {name}</span>
                    <span className="text-dark">{formatCurrency(val)}</span>
                  </Form.Label>
                  <Form.Range
                    min={0}
                    max={max}
                    step={5000}
                    value={val}
                    onChange={(e) =>
                      handleBudgetChange(serviceId, e.target.value)
                    }
                    aria-label={`Budget for ${name}`}
                    style={rangeBackground(val, 0, max, color)}
                  />
                  <div className="d-flex justify-content-between small text-muted">
                    <span>{formatCurrency(0)}</span>
                    <span>{formatCurrency(max)}</span>
                  </div>
                </Form.Group>
              </motion.div>
            );
          })}

          <Button
            variant="primary"
            size="lg"
            className="w-100 btn-modern gradient-primary"
            onClick={async () => {
              setIsSearching(true);
              setShowResults(false);
              setShowGoogleResults(false);
              
              // Fetch from Google Places
              let googleResults = [];
              if (eventType?.name && location) {
                let keyword = eventType.name;
                // Map event type to business keywords
                if (/wedding/i.test(keyword)) keyword = "wedding planner OR wedding venue";
                else if (/birthday/i.test(keyword)) keyword = "birthday party organizer OR event venue";
                else if (/conference/i.test(keyword)) keyword = "conference venue OR event space";
                else if (/photography/i.test(keyword)) keyword = "photographer";
                else if (/catering/i.test(keyword)) keyword = "caterer OR catering service";
                
                googleResults = await googlePlacesSearch(keyword, location);
                setGoogleVendors(googleResults.slice(0, 9).map((place, idx) => convertGooglePlaceToVendor(place, idx)));
              }
              
              // Fetch your own recommended vendors
              await recommendedVendors();
              
              setTimeout(() => {
                setIsSearching(false);
                setShowResults(true);
                setShowGoogleResults(googleResults.length > 0);
              }, 600);
            }}
          >
            <FaSearch className="me-2" /> Find Perfect Vendors
          </Button>
        </Form>
      </Card>

      <Modal
        show={isSearching}
        onHide={() => {}}
        backdrop="static"
        keyboard={false}
        centered
      >
        <Modal.Body className="text-center py-4">
          <div className="spinner-border text-primary mb-3" role="status">
            <span className="visually-hidden">Searching...</span>
          </div>
          <div className="fw-semibold">Searching vendors</div>
          <div className="text-muted small">
            {location} • {eventType.name}
          </div>
        </Modal.Body>
      </Modal>

      {showResults && (
        <div className="mt-4">
          {/* Compare Button in Results */}
          {compareList.length > 0 && (
            <div className="mb-4">
              <Button
                variant="warning"
                size="lg"
                onClick={() => setShowComparisonView(true)}
                className="d-flex align-items-center justify-content-center w-100"
              >
                <FaExchangeAlt className="me-2" />
                Compare {compareList.length} Vendors
              </Button>
            </div>
          )}

          {/* Google Places Results */}
          {showGoogleResults && googleVendors.length > 0 && (
            <div className="mb-4">
              <h4 className="d-flex align-items-center mb-3">
                <span>Vendors from Google</span>
                <small className="text-muted ms-2">(Local Businesses)</small>
              </h4>
              <Row className="g-3">
                {googleVendors.map((vendor) => (
                  <Col md={6} lg={4} key={vendor.vendorId} className="mb-3">
                    <UnifiedVendorCard
                      vendor={vendor}
                      isInCompare={Boolean(compareList.find(v => v.vendorId === vendor.vendorId))}
                      onCompare={toggleCompare}
                      showServiceButtons={false}
                    />
                  </Col>
                ))}
              </Row>
            </div>
          )}

          {availableServices.map(({ serviceId, name }) =>
            selectedServices[String(serviceId)] &&
            recommendedByService[String(serviceId)]?.length > 0 ? (
              <div key={serviceId} className="mb-4">
                <h4 className="d-flex justify-content-between align-items-center mb-3">
                  <span>{name} Services</span>
                  <small className="text-muted">
                    {selectedVendorsByService[String(serviceId)] ? (
                      <>
                        <FaCheckCircle className="me-2 text-success" />
                        Selected: {selectedVendorsByService[String(serviceId)].vendorName}
                      </>
                    ) : (
                      "No selection yet"
                    )}
                  </small>
                </h4>
                <Row className="g-3">
                  {recommendedByService[String(serviceId)].map((vs, idx) => {
                    const isSelected =
                      selectedVendorsByService[String(serviceId)] &&
                      selectedVendorsByService[String(serviceId)].vendorId ===
                        (vs.vendorId || vs.vendor?.vendorId);

                    return (
                      <Col md={6} lg={4} key={`${serviceId}-${idx}`}>
                        <UnifiedVendorCard
                          vendor={vs}
                          serviceId={serviceId}
                          isSelectedForService={isSelected}
                          isInCompare={Boolean(compareList.find(v => v.vendorId === vs.vendorId))}
                          onSelect={(vendor) => selectVendorForService(serviceId, vendor)}
                          onCompare={toggleCompare}
                          showServiceButtons={true}
                        />
                      </Col>
                    );
                  })}
                </Row>
              </div>
            ) : null
          )}

          {/* CONTINUE button - only enabled when user has selected one vendor for every required service */}
          <div className="d-flex justify-content-end mt-4">
            <Button
              variant="success"
              size="lg"
              disabled={
                !allServicesHaveSelection || requiredServiceIds.length === 0
              }
              onClick={() => {
                // open BookingModal with entire selection
                setShowBookingModal(true);
              }}
              className="btn-modern"
            >
              Continue to Booking <FaArrowRight className="ms-2" />
            </Button>
          </div>
        </div>
      )}

      <BookingModal
        show={showBookingModal}
        onHide={() => setShowBookingModal(false)}
        eventDate={date}
        guestCount={guestCount}
        location={location}
        selectedVendors={selectedVendorsByService}
        selectedServices={selectedServices}
        budgets={budgets}
        eventType={
          eventType?.eventTypeId ? Number(eventType.eventTypeId) : null
        }
      />

      {/* Vendor Comparison Modal */}
      {showComparisonView && (
        <Modal
          show={showComparisonView}
          onHide={() => setShowComparisonView(false)}
          size="xl"
          fullscreen="lg"
          centered
        >
          <Modal.Header closeButton>
            <Modal.Title>Vendor Comparison</Modal.Title>
          </Modal.Header>
          <Modal.Body className="p-0">
            <VendorComparison
              vendors={compareList}
              onClose={() => setShowComparisonView(false)}
              onSelectVendor={(vendor) => {
                // For Google places, just close the comparison view
                if (vendor.isGooglePlace) {
                  setShowComparisonView(false);
                  return;
                }
                // Find the service this vendor belongs to and select it
                Object.keys(recommendedByService).forEach((serviceId) => {
                  const found = recommendedByService[serviceId].find(
                    (v) => (v.vendorId || v.vendor?.vendorId) === vendor.vendorId
                  );
                  if (found) {
                    selectVendorForService(Number(serviceId), vendor);
                  }
                });
                setShowComparisonView(false);
              }}
            />
          </Modal.Body>
        </Modal>
      )}
    </Container>
  );
};

export default SearchAndBook;
