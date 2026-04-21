package Final.Year.Project.bmv.controller;

import Final.Year.Project.bmv.entity.ExternalVendor;
import Final.Year.Project.bmv.entity.Users;
import Final.Year.Project.bmv.service.ExternalVendorService;
import Final.Year.Project.bmv.service.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * Controller for managing external vendors (Google Places, etc.)
 * Tracks user interactions with external vendors for analytics and personalization
 */
@RestController
@RequestMapping("/api/external-vendors")
@CrossOrigin(origins = "http://localhost:3000")
public class ExternalVendorController {

    @Autowired
    private ExternalVendorService externalVendorService;

    @Autowired
    private UsersService usersService;

    /**
     * Track when a user views/interacts with an external (Google Places) vendor
     * Request body: {userId, googlePlaceId, vendorName, address, rating, reviews, photoUrl, city}
     */
    @PostMapping("/track-view")
    public ResponseEntity<?> trackVendorView(@RequestBody Map<String, String> map) {
        try {
            Long userId = Long.parseLong(map.get("userId"));
            Users user = usersService.getUserById(userId);
            
            if (user == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("User not found");
            }

            String googlePlaceId = map.get("googlePlaceId");
            String vendorName = map.get("vendorName");
            String address = map.get("address");
            Double rating = Double.parseDouble(map.getOrDefault("rating", "0"));
            Integer reviews = Integer.parseInt(map.getOrDefault("reviews", "0"));
            String photoUrl = map.get("photoUrl");
            String city = map.get("city");

            ExternalVendor tracked = externalVendorService.trackVendorView(
                    user, googlePlaceId, vendorName, address, rating, reviews, photoUrl, city
            );

            return ResponseEntity.ok(tracked);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body("Error tracking vendor view: " + e.getMessage());
        }
    }

    /**
     * Track when an external vendor is added to comparison
     * Request body: {userId, googlePlaceId}
     */
    @PostMapping("/track-comparison")
    public ResponseEntity<?> trackComparison(@RequestBody Map<String, String> map) {
        try {
            Long userId = Long.parseLong(map.get("userId"));
            Users user = usersService.getUserById(userId);
            
            if (user == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("User not found");
            }

            String googlePlaceId = map.get("googlePlaceId");
            ExternalVendor tracked = externalVendorService.trackComparison(user, googlePlaceId);

            return ResponseEntity.ok(tracked);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body("Error tracking comparison: " + e.getMessage());
        }
    }

    /**
     * Bookmark/unbookmark an external vendor
     * Request body: {userId, googlePlaceId}
     */
    @PostMapping("/toggle-bookmark")
    public ResponseEntity<?> toggleBookmark(@RequestBody Map<String, String> map) {
        try {
            Long userId = Long.parseLong(map.get("userId"));
            Users user = usersService.getUserById(userId);
            
            if (user == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("User not found");
            }

            String googlePlaceId = map.get("googlePlaceId");
            ExternalVendor vendor = externalVendorService.toggleBookmark(user, googlePlaceId);

            if (vendor == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("External vendor not found");
            }

            return ResponseEntity.ok(vendor);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body("Error toggling bookmark: " + e.getMessage());
        }
    }

    /**
     * Add personal notes to an external vendor
     * Request body: {userId, googlePlaceId, notes}
     */
    @PostMapping("/add-notes")
    public ResponseEntity<?> addNotes(@RequestBody Map<String, String> map) {
        try {
            Long userId = Long.parseLong(map.get("userId"));
            Users user = usersService.getUserById(userId);
            
            if (user == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("User not found");
            }

            String googlePlaceId = map.get("googlePlaceId");
            String notes = map.get("notes");
            ExternalVendor vendor = externalVendorService.addNotes(user, googlePlaceId, notes);

            if (vendor == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("External vendor not found");
            }

            return ResponseEntity.ok(vendor);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body("Error adding notes: " + e.getMessage());
        }
    }

    /**
     * Get all bookmarked external vendors for a user
     */
    @GetMapping("/bookmarks/{userId}")
    public ResponseEntity<?> getUserBookmarks(@PathVariable Long userId) {
        try {
            Users user = usersService.getUserById(userId);
            
            if (user == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("User not found");
            }

            List<ExternalVendor> bookmarks = externalVendorService.getUserBookmarks(user);
            return ResponseEntity.ok(bookmarks);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body("Error fetching bookmarks: " + e.getMessage());
        }
    }

    /**
     * Get user's viewing history of external vendors
     */
    @GetMapping("/history/{userId}")
    public ResponseEntity<?> getUserHistory(@PathVariable Long userId) {
        try {
            Users user = usersService.getUserById(userId);
            
            if (user == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("User not found");
            }

            List<ExternalVendor> history = externalVendorService.getUserHistory(user);
            return ResponseEntity.ok(history);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body("Error fetching history: " + e.getMessage());
        }
    }

    /**
     * Get most compared external vendors for a user
     */
    @GetMapping("/most-compared/{userId}")
    public ResponseEntity<?> getMostComparedVendors(@PathVariable Long userId) {
        try {
            Users user = usersService.getUserById(userId);
            
            if (user == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("User not found");
            }

            List<ExternalVendor> mostCompared = externalVendorService.getMostComparedVendors(user);
            return ResponseEntity.ok(mostCompared);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body("Error fetching most compared: " + e.getMessage());
        }
    }

    /**
     * Clear all external vendor history for a user
     */
    @DeleteMapping("/history/{userId}")
    public ResponseEntity<?> clearUserHistory(@PathVariable Long userId) {
        try {
            Users user = usersService.getUserById(userId);
            
            if (user == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("User not found");
            }

            externalVendorService.clearUserHistory(user);
            return ResponseEntity.ok("User history cleared successfully");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body("Error clearing history: " + e.getMessage());
        }
    }
}
