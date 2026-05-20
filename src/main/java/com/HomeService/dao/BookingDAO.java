package com.HomeService.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.HomeService.model.BookingModel;
import com.HomeService.utils.DBconfig;

public class BookingDAO {

    // ========================================================================
    // 👤 USER SIDE METHODS (Customer Portal)
    // ========================================================================

    public List<BookingModel> getUserBookings(int userId, String statusFilter) {
        List<BookingModel> bookings = new ArrayList<>();
        String sql = "SELECT * FROM bookings WHERE user_id = ?";

        if (!"All".equalsIgnoreCase(statusFilter)) {
            sql += " AND status = ?";
        }
        sql += " ORDER BY booking_id DESC";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            if (!"All".equalsIgnoreCase(statusFilter)) {
                stmt.setString(2, statusFilter);
            }

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    BookingModel booking = new BookingModel();

                    booking.setId(rs.getInt("booking_id"));
                    booking.setUserId(rs.getInt("user_id"));
                    booking.setServiceName(rs.getString("service_name"));
                    booking.setPrice(rs.getDouble("total_amount"));
                    booking.setAddress(rs.getString("service_address"));

                    Date prefDate = rs.getDate("preferred_date");
                    if (prefDate != null) {
                        booking.setServiceDate(prefDate);
                    }
                    booking.setServiceTime(rs.getString("preferred_time"));

                    booking.setStatus(rs.getString("status"));
                    booking.setInstructions(rs.getString("additional_notes"));

                    bookings.add(booking);
                }
            }
        } catch (Exception e) {
            System.out.println("Error in getUserBookings: " + e.getMessage());
            e.printStackTrace();
        }
        return bookings;
    }

    public Map<String, Integer> getBookingCounts(int userId) {
        Map<String, Integer> counts = new HashMap<>();
        counts.put("All", 0);
        counts.put("Pending", 0);
        counts.put("Completed", 0);

        String sql = "SELECT status, COUNT(*) as total FROM bookings WHERE user_id = ? GROUP BY status";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                int totalAll = 0;
                while (rs.next()) {
                    String status = rs.getString("status");
                    int total = rs.getInt("total");

                    if ("pending".equalsIgnoreCase(status)) {
                        counts.put("Pending", total);
                    } else if ("completed".equalsIgnoreCase(status)) {
                        counts.put("Completed", total);
                    }
                    totalAll += total;
                }
                counts.put("All", totalAll);
            }
        } catch (Exception e) {
            System.out.println("Error in getBookingCounts: " + e.getMessage());
            e.printStackTrace();
        }
        return counts;
    }

    // Logic untouched: Safely inserts as 'pending' into the shared database
    public boolean saveBooking(int userId, String serviceName, int price, String address,
                               String bookingDate, String bookingTime, String instructions) {

        String sql = "INSERT INTO bookings (user_id, service_id, service_name, service_price, customer_name, customer_phone, preferred_date, preferred_time, service_address, additional_notes, total_amount, status) " +
                     "VALUES (?, 1, ?, ?, 'Default Customer', '0000000000', ?, ?, ?, ?, ?, 'pending')";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setString(2, serviceName);
            stmt.setInt(3, price);
            stmt.setString(4, bookingDate);
            stmt.setString(5, bookingTime);
            stmt.setString(6, address);
            stmt.setString(7, instructions);
            stmt.setInt(8, price);

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Error in saveBooking: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // ========================================================================
    // 🛡️ ADMIN SIDE METHODS (Management Dashboard)
    // ========================================================================

    public int getTotalBookingsCount() throws Exception {
        return executeCountQuery("SELECT COUNT(*) FROM bookings");
    }

    public int getPendingBookingsCount() throws Exception {
        return executeCountQuery("SELECT COUNT(*) FROM bookings WHERE status = 'PENDING' OR status = 'pending'");
    }

    public List<BookingModel> getAllBookings() throws Exception {
        // FIX: Changed ORDER BY to 'booking_date' to match your database image!
        String sql = "SELECT b.*, u.full_name as customer_name, u.phone as customer_phone, s.service_name, t.full_name as technician_name " +
                     "FROM bookings b " +
                     "LEFT JOIN users u ON b.user_id = u.user_id " +
                     "LEFT JOIN services s ON b.service_id = s.service_id " +
                     "LEFT JOIN users t ON b.technician_id = t.user_id " +
                     "ORDER BY b.booking_date DESC";

        return executeFetchBookingsList(sql, null);
    }

    public List<BookingModel> getBookingsByStatus(String status) throws Exception {
        // FIX: Changed ORDER BY to 'booking_date' to match your database image!
        String sql = "SELECT b.*, u.full_name as customer_name, u.phone as customer_phone, s.service_name, t.full_name as technician_name " +
                     "FROM bookings b " +
                     "LEFT JOIN users u ON b.user_id = u.user_id " +
                     "LEFT JOIN services s ON b.service_id = s.service_id " +
                     "LEFT JOIN users t ON b.technician_id = t.user_id " +
                     "WHERE b.status = ? " +
                     "ORDER BY b.booking_date DESC";

        return executeFetchBookingsList(sql, status);
    }

    public boolean assignTechnician(int bookingId, int technicianId) throws Exception {
        String sql = "UPDATE bookings SET technician_id = ?, status = 'CONFIRMED' WHERE booking_id = ?";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setInt(1, technicianId);
            pst.setInt(2, bookingId);

            return pst.executeUpdate() > 0;
        }
    }

    public boolean cancelBooking(int bookingId) throws Exception {
        return updateBookingStatus(bookingId, "CANCELLED");
    }

    public boolean completeBooking(int bookingId) throws Exception {
        return updateBookingStatus(bookingId, "COMPLETED");
    }

    // ========================================================================
    // 🛠️ HELPER UTILITY METHODS
    // ========================================================================

    private int executeCountQuery(String sql) throws Exception {
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {

            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    private boolean updateBookingStatus(int bookingId, String status) throws Exception {
        String sql = "UPDATE bookings SET status = ? WHERE booking_id = ?";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setString(1, status);
            pst.setInt(2, bookingId);

            return pst.executeUpdate() > 0;
        }
    }

    private List<BookingModel> executeFetchBookingsList(String sql, String filterParam) throws Exception {
        List<BookingModel> bookings = new ArrayList<>();

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            if (filterParam != null) {
                pst.setString(1, filterParam);
            }

            try (ResultSet rs = pst.executeQuery()) {
                while (rs.next()) {
                    BookingModel booking = new BookingModel();

                    booking.setId(rs.getInt("booking_id"));
                    booking.setUserId(rs.getInt("user_id"));
                    booking.setServiceName(rs.getString("service_name"));
                    booking.setPrice(rs.getDouble("total_amount"));
                    booking.setAddress(rs.getString("service_address"));

                    Date prefDate = rs.getDate("preferred_date");
                    if (prefDate != null) {
                        booking.setServiceDate(prefDate);
                    }
                    booking.setServiceTime(rs.getString("preferred_time"));

                    booking.setStatus(rs.getString("status"));
                    booking.setInstructions(rs.getString("additional_notes"));

                    // FIX: Changed from "created_at" to "booking_date" to perfectly match your DB
                    try {
                        booking.setCreatedAt(rs.getTimestamp("booking_date"));
                    } catch (Exception e) {}

                    bookings.add(booking);
                }
            }
        }
        return bookings;
    }
}