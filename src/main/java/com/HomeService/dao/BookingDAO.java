package com.HomeService.dao;

import com.HomeService.model.BookingModel;
import com.HomeService.utils.DBconfig;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BookingDAO {

    // Helper method - looks up the real service_id from services table by name
    // This is needed because ServiceServlet uses an inner class with no real DB id
    private int getServiceIdByName(Connection conn, String serviceName) {
        String sql = "SELECT service_id FROM services WHERE service_name = ? LIMIT 1";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, serviceName);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("service_id");
            }
        } catch (SQLException e) {
            System.out.println("[BookingDAO] Could not find service_id for: " + serviceName);
        }
        return 0;
    }

    // 1. CREATE booking - looks up real service_id from services table first
    public boolean createBooking(BookingModel b) {

        String sql = "INSERT INTO bookings "
                   + "(user_id, service_id, service_name, service_price, customer_name, "
                   + "customer_phone, preferred_date, preferred_time, service_address, "
                   + "additional_notes, total_amount, status, payment_status) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'pending', 'pending')";

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBconfig.getConnection();

            // Look up the real service_id from services table using the service name
            int realServiceId = getServiceIdByName(conn, b.getServiceName());
            System.out.println("[BookingDAO] Resolved service_id = " + realServiceId + " for: " + b.getServiceName());

            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, b.getUserId());
            stmt.setInt(2, realServiceId);
            stmt.setString(3, b.getServiceName());
            stmt.setDouble(4, b.getServicePrice());
            stmt.setString(5, b.getCustomerName());
            stmt.setString(6, b.getCustomerPhone());
            stmt.setString(7, b.getPreferredDate());
            stmt.setString(8, b.getPreferredTime());
            stmt.setString(9, b.getServiceAddress());
            stmt.setString(10, b.getAdditionalNotes());
            stmt.setDouble(11, b.getTotalAmount());

            int rows = stmt.executeUpdate();
            System.out.println("[BookingDAO] Rows inserted: " + rows);
            return rows > 0;

        } catch (SQLException e) {
            System.out.println("[BookingDAO] createBooking FAILED");
            System.out.println("  SQL State : " + e.getSQLState());
            System.out.println("  Error Code: " + e.getErrorCode());
            System.out.println("  Message   : " + e.getMessage());
            return false;

        } finally {
            try { if (stmt != null) stmt.close(); } catch (SQLException ignored) {}
            try { if (conn != null) conn.close(); } catch (SQLException ignored) {}
        }
    }

    // 2. Fetch bookings for a user with optional status filter
    public List<BookingModel> getUserBookings(int userId, String statusFilter) {
        List<BookingModel> list = new ArrayList<>();

        String sql = "SELECT * FROM bookings WHERE user_id = ?";
        if (statusFilter != null && !statusFilter.equalsIgnoreCase("All") && !statusFilter.isEmpty()) {
            sql += " AND status = ?";
        }
        sql += " ORDER BY booking_date DESC";

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBconfig.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);

            if (statusFilter != null && !statusFilter.equalsIgnoreCase("All") && !statusFilter.isEmpty()) {
                stmt.setString(2, statusFilter);
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                BookingModel b = new BookingModel();
                b.setBookingId(rs.getInt("booking_id"));
                b.setUserId(rs.getInt("user_id"));
                b.setServiceId(rs.getInt("service_id"));
                b.setServiceName(rs.getString("service_name"));
                b.setServicePrice(rs.getDouble("service_price"));
                b.setCustomerName(rs.getString("customer_name"));
                b.setCustomerPhone(rs.getString("customer_phone"));
                b.setPreferredDate(rs.getString("preferred_date"));
                b.setPreferredTime(rs.getString("preferred_time"));
                b.setServiceAddress(rs.getString("service_address"));
                b.setAdditionalNotes(rs.getString("additional_notes"));
                b.setTotalAmount(rs.getDouble("total_amount"));
                b.setStatus(rs.getString("status"));
                b.setPaymentStatus(rs.getString("payment_status"));
                b.setPaymentMethod(rs.getString("payment_method"));
                b.setBookingDate(rs.getTimestamp("booking_date"));
                b.setUpdatedAt(rs.getTimestamp("updated_at"));
                b.setCompletedDate(rs.getString("completed_date"));
                b.setCancellationReason(rs.getString("cancellation_reason"));
                list.add(b);
            }

        } catch (SQLException e) {
            System.out.println("[BookingDAO] getUserBookings FAILED: " + e.getMessage());
        } finally {
            try { if (stmt != null) stmt.close(); } catch (SQLException ignored) {}
            try { if (conn != null) conn.close(); } catch (SQLException ignored) {}
        }

        return list;
    }

    // 3. Count bookings per status for tab badges
    public Map<String, Integer> getBookingCounts(int userId) {
        Map<String, Integer> counts = new HashMap<>();
        counts.put("All", 0);
        counts.put("pending", 0);
        counts.put("confirmed", 0);
        counts.put("completed", 0);
        counts.put("cancelled", 0);

        String sql = "SELECT status, COUNT(*) as count FROM bookings WHERE user_id = ? GROUP BY status";

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBconfig.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);

            ResultSet rs = stmt.executeQuery();
            int total = 0;
            while (rs.next()) {
                String stat = rs.getString("status");
                int count   = rs.getInt("count");
                counts.put(stat, count);
                total += count;
            }
            counts.put("All", total);

        } catch (SQLException e) {
            System.out.println("[BookingDAO] getBookingCounts FAILED: " + e.getMessage());
        } finally {
            try { if (stmt != null) stmt.close(); } catch (SQLException ignored) {}
            try { if (conn != null) conn.close(); } catch (SQLException ignored) {}
        }

        return counts;
    }
}