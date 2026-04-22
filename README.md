# 🎉 BookMyVendor

> **Revolutionizing Event Vendor Management with AI-Powered Recommendations**

A comprehensive, full-stack platform that simplifies finding, comparing, and booking event vendors. Powered by intelligent recommendations and seamless integration with Google Places API.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Java](https://img.shields.io/badge/Java-21-orange)](https://www.oracle.com/java/technologies/javase/jdk21-archive.html)
[![React](https://img.shields.io/badge/React-18.3-blue)](https://react.dev/)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.5.6-brightgreen)](https://spring.io/projects/spring-boot)
[![MySQL](https://img.shields.io/badge/MySQL-8.0-blue)](https://www.mysql.com/)

---

## ✨ Key Features

### 🤖 **AI-Powered Vendor Recommendations**
- **Smart Matching Algorithm**: Evaluates vendors based on budget, ratings, reliability, and capacity
- **Personalized Scores**: 0-100% recommendation scores tailored to user preferences
- **Multi-Criteria Analysis**: Considers 5+ factors for optimal vendor suggestions
- **Real-Time Insights**: Instant vendor suitability assessment

### 🔍 **Unified Vendor Discovery**
- **Dual Source Integration**: Access both database vendors AND Google Places API results
- **Smart Search**: Filter by location, service type, budget, and availability
- **Rich Vendor Profiles**: Comprehensive information including ratings, pricing, and capacity
- **Live Availability**: Real-time booking status and responsiveness metrics

### 🎯 **Vendor Comparison**
- **Side-by-Side Analysis**: Compare multiple vendors simultaneously
- **Visual Highlighting**: Color-coded metrics for easy comparison
- **Price Range Visualization**: Clear pricing breakdowns
- **Capacity & Specialization**: Detailed service specifications
- **AI Score Comparison**: Data-driven recommendations

### 💬 **Interactive Booking & Communication**
- **Instant Booking Requests**: Send inquiries directly to vendors
- **SMS Notifications**: Twilio-powered SMS alerts for real-time updates
- **Email OTP Verification**: Secure authentication with automated emails
- **Review & Rating System**: Community-driven quality assurance
- **Vendor Response Tracking**: Monitor inquiry status in real-time

### 📊 **Comprehensive Dashboards**
- **User Dashboard**: Manage bookings, reviews, and preferences
- **Vendor Dashboard**: Manage business profile, inquiries, and analytics
- **Event Calendar**: Visual organization of booked events
- **Performance Metrics**: Analytics on vendor acceptance rates and response times

---

## 🏗️ Architecture Overview

```
BookMyVendor
├── Frontend (React 18.3)
│   ├── Components: Vendor Cards, Comparison View, Booking Modal
│   ├── Context API: Global state management
│   ├── Services: Firebase Auth, Axios API calls, Image Upload
│   └── Pages: Dashboard, Vendor Onboarding, Event Creation
│
└── Backend (Spring Boot 3.5.6)
    ├── Controllers: REST API endpoints
    ├── Services: Business logic & AI recommendations
    ├── Entities: Database models
    ├── Repositories: Data access layer
    └── External APIs: Google Places, Twilio, Gmail
```

### Technology Stack

| Layer | Technologies |
|-------|--------------|
| **Frontend** | React 18.3, Bootstrap 5, Framer Motion, Redux (Context API) |
| **Backend** | Spring Boot 3.5.6, Spring Data JPA, Spring Mail |
| **Database** | MySQL 8.0 with Hibernate ORM |
| **Authentication** | Firebase Authentication |
| **APIs** | Google Places API, Twilio SMS, Gmail SMTP |
| **Image Storage** | Firebase Cloud Storage |
| **Deployment** | Docker & Docker Compose |

---

## 📊 AI Recommendation Algorithm

### Scoring Methodology

The platform uses a **weighted multi-criteria scoring system** to rank vendors:

| Criteria | Weight | Description |
|----------|--------|-------------|
| 💰 Budget Compatibility | 35% | Price range alignment with user budget |
| ⭐ Vendor Rating | 25% | Customer satisfaction (1-5 stars) |
| ✅ Reliability | 20% | Booking acceptance rate |
| ⚡ Responsiveness | 10% | Average response time |
| 👥 Guest Capacity | 10% | Event size accommodation |

### Score Ranges

```
🟢 80-100%  → Highly Recommended
🟡 60-79%   → Recommended
🔴 Below 60% → Consider Alternatives
```

### Example: Real Vendor Scoring

```
Vendor: "Mysore Palace Caterers"
├── Budget Score:        1.0  (₹900-₹2,600 perfect match) × 0.35 = 0.35
├── Rating Score:        0.94 (4.7/5 stars)              × 0.25 = 0.235
├── Reliability Score:   0.85 (85% acceptance rate)      × 0.20 = 0.17
├── Responsiveness Score: 0.90 (2-hour avg response)     × 0.10 = 0.09
└── Capacity Score:      0.95 (100-1700 guests)          × 0.10 = 0.095
                                                   ─────────────────
                                    Final AI Score: 89.5% ✅ HIGHLY RECOMMENDED
```

---

## 🚀 Getting Started

### Prerequisites

- **Java 21** or higher
- **Node.js 16+** and npm
- **MySQL 8.0+**
- **Docker & Docker Compose** (for containerized deployment)

### Installation

#### 1. **Clone the Repository**

```bash
git clone https://github.com/yourusername/BookMyVendor.git
cd BookMyVendor
```

#### 2. **Backend Setup (Spring Boot)**

```bash
cd bookmyvendor/bmv

# Configure database in application.properties
nano src/main/resources/application.properties

# Set your credentials:
# - MySQL database URL
# - Twilio SMS credentials
# - Google Places API key
# - Gmail SMTP credentials

# Build with Maven
./mvnw clean build

# Run the application
./mvnw spring-boot:run
```

The backend will start on `http://localhost:8081`

#### 3. **Frontend Setup (React)**

```bash
cd frontend/bookmyvendor

# Install dependencies
npm install

# Create .env file with API configuration
echo "REACT_APP_API_BASE_URL=http://localhost:8081" > .env

# Start development server
npm start
```

The frontend will start on `http://localhost:3000`

#### 4. **Environment Configuration**

Create a `.env` file in the backend with:

```env
# Database
SPRING_DATASOURCE_URL=jdbc:mysql://localhost:3306/mydb
SPRING_DATASOURCE_USERNAME=root
SPRING_DATASOURCE_PASSWORD=root

# Twilio SMS
TWILIO_ACCOUNT_SID=your_account_sid
TWILIO_AUTH_TOKEN=your_auth_token
TWILIO_PHONE_NUMBER=your_twilio_number

# Google Places API
GOOGLE_PLACES_API_KEY=your_api_key

# Email (OTP)
SPRING_MAIL_USERNAME=your_email@gmail.com
SPRING_MAIL_PASSWORD=your_app_password
```

#### 5. **Docker Deployment**

```bash
cd bookmyvendor/bmv

# Build and run with Docker Compose
docker-compose up --build

# Access the application:
# Backend: http://localhost:8081
# Frontend: http://localhost:3000
```

---

## 📱 API Endpoints

### Vendor Endpoints
```
GET    /api/vendors                 # List all vendors
GET    /api/vendors/{id}            # Get vendor details
POST   /api/vendors                 # Create vendor profile
PUT    /api/vendors/{id}            # Update vendor
DELETE /api/vendors/{id}            # Delete vendor
```

### Recommendation Endpoints
```
POST   /api/recommendations/score   # Get AI score for vendor
GET    /api/recommendations/top     # Get top recommended vendors
POST   /api/recommendations/compare # Compare multiple vendors
```

### Booking Endpoints
```
POST   /api/bookings                # Create booking request
GET    /api/bookings/{id}           # Get booking details
PUT    /api/bookings/{id}/status    # Update booking status
```

### Google Integration
```
GET    /api/google-vendors/search   # Search Google Places
GET    /api/google-vendors/{placeId} # Get Google vendor details
```

---

## 🧪 Testing

### Run Backend Tests
```bash
cd bookmyvendor/bmv
./mvnw test
```

### Run Frontend Tests
```bash
cd frontend/bookmyvendor
npm test
```

### Coverage Report
```bash
./mvnw jacoco:report
npm test -- --coverage
```

---

## 📚 Project Structure

```
BookMyVendor/
├── bookmyvendor/
│   ├── bmv/                          # Backend (Spring Boot)
│   │   ├── src/main/java/
│   │   │   ├── controller/           # REST Controllers
│   │   │   ├── service/              # Business Logic & AI
│   │   │   ├── entity/               # Database Models
│   │   │   ├── repository/           # Data Access
│   │   │   └── config/               # Configuration
│   │   ├── src/main/resources/
│   │   │   └── application.properties
│   │   ├── pom.xml                   # Maven Dependencies
│   │   └── docker-compose.yml        # Docker Configuration
│   │
│   └── frontend/bookmyvendor/        # Frontend (React)
│       ├── src/
│       │   ├── components/           # React Components
│       │   ├── pages/                # Page Components
│       │   ├── services/             # API Services
│       │   ├── contexts/             # Global State
│       │   └── utils/                # Utilities
│       ├── public/
│       ├── package.json              # npm Dependencies
│       └── .env                      # Environment Config
│
└── docs/                             # Documentation
    ├── API_DOCUMENTATION.md
    ├── ARCHITECTURE.md
    └── DEPLOYMENT_GUIDE.md
```

---

## 🔐 Security Features

✅ **Firebase Authentication** - Secure user & vendor authentication  
✅ **Email OTP Verification** - Additional security layer  
✅ **SMS 2FA** - Twilio-powered two-factor authentication  
✅ **CORS Protection** - Cross-origin request validation  
✅ **Input Validation** - Server-side validation for all inputs  
✅ **SQL Injection Prevention** - Parameterized queries via JPA  
✅ **Secure Password Hashing** - BCrypt encryption  

---

## 🎯 Future Enhancements

- 🤖 **Advanced ML** - Deep learning for preference prediction
- 📍 **Location-Based Services** - Geo-spatial vendor matching
- 💳 **Online Payments** - Razorpay/Stripe integration
- 📊 **Analytics Dashboard** - Business intelligence for vendors
- 🌐 **Multi-Language Support** - Localization for regional markets
- 🎨 **AR Vendor Preview** - Augmented reality event visualization
- 📱 **Mobile App** - Native iOS & Android applications
- 🔔 **Push Notifications** - Real-time event updates

---

## 🤝 Contributing

We welcome contributions! Here's how:

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/AmazingFeature`)
3. **Commit** your changes (`git commit -m 'Add AmazingFeature'`)
4. **Push** to the branch (`git push origin feature/AmazingFeature`)
5. **Open** a Pull Request

### Development Guidelines
- Follow Google Java Style Guide for backend code
- Use React best practices and hooks
- Write unit tests for new features
- Update documentation for API changes

---

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- Spring Boot team for the excellent framework
- React community for amazing tools and libraries
- Google Places API for vendor data
- Firebase for authentication services
- Twilio for SMS capabilities

---

## 📈 Project Statistics

![GitHub Stars](https://img.shields.io/github/stars/yourusername/BookMyVendor?style=social)
![GitHub Forks](https://img.shields.io/github/forks/yourusername/BookMyVendor?style=social)
![GitHub Watchers](https://img.shields.io/github/watchers/yourusername/BookMyVendor?style=social)

---

<div align="center">

**[⬆ Back to Top](#-bookmyvendor)**

Made with 💚 | Simplifying Event Planning | [Visit Website](https://bmvindia.online)

</div>

