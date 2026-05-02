package Final.Year.Project.bmv.service;

import Final.Year.Project.bmv.entity.VendorProfile;
import Final.Year.Project.bmv.entity.Bookings;
import Final.Year.Project.bmv.repository.BookingRepository;
import Final.Year.Project.bmv.repository.VendorProfileRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;

@Service
public class DemandForecastingService {

    @Autowired
    private BookingRepository bookingRepository;

    @Autowired
    private VendorProfileRepository vendorProfileRepository;

    /**
     * Forecast demand for next N days
     */
    public DemandForecast forecastDemand(Long vendorId, int daysAhead) {
        VendorProfile vendor = vendorProfileRepository.findById(vendorId)
                .orElseThrow(() -> new RuntimeException("Vendor not found"));

        LocalDateTime sixMonthsAgo = LocalDateTime.now().minusMonths(6);
        List<Bookings> historicalData = bookingRepository.findHistoricalBookings(vendorId, sixMonthsAgo);

        Map<LocalDate, Integer> dailyBookings = aggregateBookingsByDate(historicalData);
        List<Double> trend = calculateTrend(dailyBookings);
        List<Double> seasonality = calculateSeasonality(dailyBookings);

        List<DailyForecast> forecasts = new ArrayList<>();
        double baseline = calculateBaseline(dailyBookings);

        for (int day = 1; day <= daysAhead; day++) {
            LocalDate forecastDate = LocalDate.now().plusDays(day);
            double predicted = baseline +
                    (trend.isEmpty() ? 0 : trend.get(day % Math.max(1, trend.size()))) +
                    seasonality.get(forecastDate.getDayOfWeek().getValue() - 1);

            forecasts.add(new DailyForecast(
                    forecastDate,
                    Math.max(0, predicted),
                    getConfidenceLevel(historicalData.size())
            ));
        }

        return new DemandForecast(vendorId, forecasts, LocalDate.now());
    }

    private Map<LocalDate, Integer> aggregateBookingsByDate(List<Bookings> bookings) {
        Map<LocalDate, Integer> result = new TreeMap<>();
        bookings.forEach(b -> {
            if (b.getEvent() != null && b.getEvent().getEventDate() != null) {
                LocalDate date = b.getEvent().getEventDate();
                result.put(date, result.getOrDefault(date, 0) + 1);
            }
        });
        return result;
    }

    private List<Double> calculateTrend(Map<LocalDate, Integer> dailyBookings) {
        if (dailyBookings.isEmpty()) return new ArrayList<>();

        List<Double> trend = new ArrayList<>();
        List<Integer> values = new ArrayList<>(dailyBookings.values());

        int window = 7;
        for (int i = 0; i < values.size(); i += window) {
            int start = i;
            int end = Math.min(i + window, values.size());
            double avg = values.subList(start, end).stream()
                    .mapToInt(Integer::intValue)
                    .average()
                    .orElse(0);
            trend.add(avg);
        }

        return trend;
    }

    private List<Double> calculateSeasonality(Map<LocalDate, Integer> dailyBookings) {
        Map<Integer, List<Integer>> byDayOfWeek = new HashMap<>();

        dailyBookings.forEach((date, count) -> {
            int dayOfWeek = date.getDayOfWeek().getValue();
            byDayOfWeek.computeIfAbsent(dayOfWeek, k -> new ArrayList<>()).add(count);
        });

        List<Double> seasonality = new ArrayList<>();
        for (int day = 1; day <= 7; day++) {
            List<Integer> dayBookings = byDayOfWeek.get(day);
            double avg = dayBookings == null ? 0 : dayBookings.stream()
                    .mapToInt(Integer::intValue)
                    .average()
                    .orElse(0);
            seasonality.add(avg);
        }

        return seasonality;
    }

    private double calculateBaseline(Map<LocalDate, Integer> dailyBookings) {
        return dailyBookings.values().stream()
                .mapToInt(Integer::intValue)
                .average()
                .orElse(0);
    }

    private double getConfidenceLevel(int dataPoints) {
        return Math.min(0.95, 0.5 + (dataPoints / 1000.0));
    }

    public static class DemandForecast {
        public Long vendorId;
        public List<DailyForecast> forecasts;
        public LocalDate generatedAt;

        public DemandForecast(Long vendorId, List<DailyForecast> forecasts, LocalDate generatedAt) {
            this.vendorId = vendorId;
            this.forecasts = forecasts;
            this.generatedAt = generatedAt;
        }
    }

    public static class DailyForecast {
        public LocalDate date;
        public Double predictedBookings;
        public Double confidence;

        public DailyForecast(LocalDate date, Double predictedBookings, Double confidence) {
            this.date = date;
            this.predictedBookings = predictedBookings;
            this.confidence = confidence;
        }
    }
}

