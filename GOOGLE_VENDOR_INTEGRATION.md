# Backend Changes for Google Vendor Comparison

## Summary

Added **optional backend support** for tracking external (Google Places) vendor interactions. The comparison feature works entirely on the frontend, but these backend additions enable:

- ✅ Tracking user interactions with Google vendors
- ✅ Bookmarking external vendors
- ✅ Analytics (viewing history, comparison tracking)
- ✅ Personal notes on external vendors
- ✅ Comparison statistics

---

## Files Added

### 1. **GoogleVendorDto.java** (`src/main/java/.../dto/`)
Location: `Final/Year/Project/bmv/dto/GoogleVendorDto.java`

DTO for Google Places vendors with fields compatible with comparison display.

**Fields:**
- `vendorId`: "google_{place_id}"
- `isGooglePlace`: true
- `vendorName`, `rating`, `city`, `formatted_address`
- `businessLogoUrl`, `completedJobs`, `acceptanceRate`
- `googlePlaceId`: Link to Google Places

**Usage:** Can be used to standardize Google vendor data across API endpoints.

---

### 2. **ExternalVendor.java** (`src/main/java/.../entity/`)
Location: `Final/Year/Project/bmv/entity/ExternalVendor.java`

JPA Entity for storing external vendor interaction history in database.

**Schema:**
```sql
CREATE TABLE external_vendors (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    vendor_name VARCHAR(255),
    google_place_id VARCHAR(255) UNIQUE,
    formatted_address TEXT,
    rating DOUBLE,
    user_ratings_total INT,
    business_photo_url VARCHAR(500),
    city VARCHAR(100),
    view_count INT DEFAULT 0,
    comparison_count INT DEFAULT 0,
    is_bookmarked BOOLEAN DEFAULT FALSE,
    notes TEXT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    last_viewed TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
```

**Tracking Data:**
- `viewCount`: How many times user viewed this vendor
- `comparisonCount`: How many times included in comparison
- `isBookmarked`: User favorited this vendor
- `notes`: User's personal notes

---

### 3. **ExternalVendorRepository.java** (`src/main/java/.../repository/`)
Location: `Final/Year/Project/bmv/repository/ExternalVendorRepository.java`

Spring Data JPA repository for CRUD operations on external vendors.

**Key Methods:**
- `findByUserAndGooglePlaceId()`: Get existing vendor record
- `findByUserAndIsBookmarkedTrue()`: Get user's bookmarks
- `findByUserOrderByLastViewedDesc()`: Get viewing history
- `findMostComparedVendors()`: Get analytics

---

### 4. **ExternalVendorService.java** (`src/main/java/.../service/`)
Location: `Final/Year/Project/bmv/service/ExternalVendorService.java`

Business logic service for external vendor management.

**Key Methods:**
```java
// Track a viewed external vendor
trackVendorView(user, googlePlaceId, vendorName, address, rating, reviews, photoUrl, city)

// Track comparison event
trackComparison(user, googlePlaceId)

// Bookmark/unbookmark
toggleBookmark(user, googlePlaceId)

// Add personal notes
addNotes(user, googlePlaceId, notes)

// Get analytics
getUserBookmarks(user)
getUserHistory(user)
getMostComparedVendors(user)
```

---

### 5. **ExternalVendorController.java** (`src/main/java/.../controller/`)
Location: `Final/Year/Project/bmv/controller/ExternalVendorController.java`

REST API endpoints for external vendor interactions.

**Endpoints:**

#### Track Vendor View
```
POST /api/external-vendors/track-view
Body: {
  "userId": 1,
  "googlePlaceId": "ChIJN1blFLsCUUgR",
  "vendorName": "ABC Catering",
  "address": "123 Some St, City",
  "rating": "4.5",
  "reviews": "120",
  "photoUrl": "https://...",
  "city": "Mumbai"
}
Response: ExternalVendor object
```

#### Track Comparison
```
POST /api/external-vendors/track-comparison
Body: {
  "userId": 1,
  "googlePlaceId": "ChIJN1blFLsCUUgR"
}
Response: ExternalVendor object (comparison count incremented)
```

#### Bookmark/Unbookmark
```
POST /api/external-vendors/toggle-bookmark
Body: {
  "userId": 1,
  "googlePlaceId": "ChIJN1blFLsCUUgR"
}
Response: ExternalVendor object (isBookmarked toggled)
```

#### Add Notes
```
POST /api/external-vendors/add-notes
Body: {
  "userId": 1,
  "googlePlaceId": "ChIJN1blFLsCUUgR",
  "notes": "Great service, will contact later"
}
Response: ExternalVendor object (notes updated)
```

#### Get Bookmarks
```
GET /api/external-vendors/bookmarks/{userId}
Response: List<ExternalVendor>
```

#### Get History
```
GET /api/external-vendors/history/{userId}
Response: List<ExternalVendor> (ordered by last_viewed DESC)
```

#### Get Most Compared
```
GET /api/external-vendors/most-compared/{userId}
Response: List<ExternalVendor> (ordered by comparisonCount)
```

#### Clear History
```
DELETE /api/external-vendors/history/{userId}
Response: "User history cleared successfully"
```

---

## How It Works

### Flow 1: Comparing Vendors (No Backend Required ✅)
```
Frontend:
1. User adds vendors to compare (both DB & Google)
2. Click "Compare n Vendors"
3. VendorComparison component displays side-by-side
4. No backend call needed
```

### Flow 2: Tracking Google Vendor View (Optional ✅)
```
Frontend:
1. User views Google vendor card
2. Call POST /api/external-vendors/track-view
3. Backend records view in ExternalVendor table

Backend:
1. Get or create ExternalVendor record
2. Increment viewCount
3. Update lastViewed timestamp
4. Save to database
```

### Flow 3: Tracking Comparison (Optional ✅)
```
Frontend:
1. User adds Google vendor to compare list
2. Call POST /api/external-vendors/track-comparison
3. Backend increments comparison count

Backend:
1. Gets ExternalVendor record
2. Increments comparisonCount
3. Saves to database
```

### Flow 4: Bookmarking (Optional ✅)
```
Frontend:
1. User clicks bookmark button on Google vendor
2. Call POST /api/external-vendors/toggle-bookmark
3. Backend toggles isBookmarked flag
```

---

## Database Migration (if using existing DB)

Run this SQL to create the external_vendors table:

```sql
CREATE TABLE external_vendors (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    vendor_name VARCHAR(255),
    google_place_id VARCHAR(255) UNIQUE,
    formatted_address TEXT,
    rating DOUBLE,
    user_ratings_total INT,
    business_photo_url VARCHAR(500),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    view_count INT DEFAULT 0,
    comparison_count INT DEFAULT 0,
    is_bookmarked BOOLEAN DEFAULT 0,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_viewed TIMESTAMP,
    INDEX idx_user_id (user_id),
    INDEX idx_google_place_id (google_place_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);
```

**OR** let Hibernate auto-create by setting in `application.properties`:
```properties
spring.jpa.hibernate.ddl-auto=update
```

---

## Integration with Frontend

### Optional: Call tracking endpoints in SearchAndBook.js

```javascript
// When user views a Google vendor
const trackGoogleVendorView = async (userId, googleVendor) => {
  try {
    await axios.post('/api/external-vendors/track-view', {
      userId: userId,
      googlePlaceId: googleVendor.place_id,
      vendorName: googleVendor.name,
      address: googleVendor.formatted_address,
      rating: String(googleVendor.rating || 0),
      reviews: String(googleVendor.user_ratings_total || 0),
      photoUrl: googleVendor.photos?.[0]?.photo_reference,
      city: googleVendor.formatted_address.split(',')[1]?.trim()
    });
  } catch (err) {
    console.error('Error tracking vendor view', err);
  }
};

// When user adds Google vendor to comparison
const trackComparison = async (userId, googlePlaceId) => {
  try {
    await axios.post('/api/external-vendors/track-comparison', {
      userId: userId,
      googlePlaceId: googlePlaceId
    });
  } catch (err) {
    console.error('Error tracking comparison', err);
  }
};
```

---

## Important Notes

### ✅ What Works Without Backend Changes
- ✅ **Comparison display** - Works on frontend only
- ✅ **Filtering & sorting** - Client-side
- ✅ **Booking platform vendors** - Uses existing endpoints
- ✅ **Google Places search** - Frontend API (no backend needed)

### ⚠️ Limitations
- ❌ Google vendors cannot be booked through your platform
- ❌ No direct payment integration with external vendors
- ❌ External vendors aren't connected to booking system
- ❌ Contact info must come from Google Maps link

### 🎯 Future Enhancements
1. **Request Quote from External Vendor** - Add email/SMS notification system
2. **Lead Management** - Track leads sent to external vendors
3. **Partnership Program** - Convert interested external vendors to platform vendors
4. **Advanced Analytics** - Most viewed, most compared, conversion rate
5. **Recommendation Engine** - Based on user viewing/comparison history

---

## Testing the API

### Compile & Run
1. Compile backend: `mvn clean install`
2. Run: `mvn spring-boot:run`
3. Ensure `spring.jpa.hibernate.ddl-auto=update` in `application.properties`

### cURL Examples:

```bash
# Track vendor view
curl -X POST http://localhost:8081/api/external-vendors/track-view \
  -H "Content-Type: application/json" \
  -d '{
    "userId": "1",
    "googlePlaceId": "ChIJN1blFLsCUUgR",
    "vendorName": "ABC Catering",
    "address": "123 Main St, Mumbai",
    "rating": "4.5",
    "reviews": "120",
    "photoUrl": "https://...",
    "city": "Mumbai"
  }'

# Get bookmarks
curl -X GET http://localhost:8081/api/external-vendors/bookmarks/1

# Get history
curl -X GET http://localhost:8081/api/external-vendors/history/1

# Toggle bookmark
curl -X POST http://localhost:8081/api/external-vendors/toggle-bookmark \
  -H "Content-Type: application/json" \
  -d '{
    "userId": "1",
    "googlePlaceId": "ChIJN1blFLsCUUgR"
  }'
```

---

## Conclusion

**For basic Google vendor comparison to work: NO BACKEND CHANGES ARE NEEDED** ✅

The frontend implementation is sufficient. These backend additions provide optional analytics and vendor management features that enhance the user experience and provide valuable business intelligence.

To enable these features, simply:
1. All 5 files have been added to your project
2. Run the database migration SQL (or let Hibernate auto-create with `ddl-auto=update`)
3. Add optional tracking calls in frontend when needed

The comparison feature works immediately without any of these additions.

---

## File Checklist

- ✅ GoogleVendorDto.java - Added to `dto/`
- ✅ ExternalVendor.java - Added to `entity/`
- ✅ ExternalVendorRepository.java - Added to `repository/`
- ✅ ExternalVendorService.java - Added to `service/`
- ✅ ExternalVendorController.java - Added to `controller/`
- ✅ GOOGLE_VENDOR_INTEGRATION.md - Documentation (this file)

All files are ready to use!
