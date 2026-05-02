package Final.Year.Project.bmv.repository;

import Final.Year.Project.bmv.entity.Bookings;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface BookingRepository extends JpaRepository<Bookings, Long> {
    List<Bookings> findByVendor_VendorId(Long vendorId);
    Optional<Bookings> findByEvent_EventIdAndVendor_VendorIdAndVendorServiceRequest_VendorRequestId(
            Long eventId,
            Long vendorId,
            Long vendorServiceRequestId
    );
    List<Bookings> findByEvent_EventId(Long eventId);

    @Query("SELECT b FROM Bookings b WHERE b.vendor.vendorId = :vendorId AND b.createdAt >= :since ORDER BY b.createdAt DESC")
    List<Bookings> findRecentByVendor(@Param("vendorId") Long vendorId, @Param("since") LocalDateTime since);

    @Query("SELECT b FROM Bookings b WHERE b.vendor.vendorId = :vendorId AND b.createdAt >= :date ORDER BY b.createdAt DESC")
    List<Bookings> findHistoricalBookings(@Param("vendorId") Long vendorId, @Param("date") LocalDateTime date);
}

