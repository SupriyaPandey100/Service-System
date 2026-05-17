package com.HomeService.dao;

import com.HomeService.model.BookingModel;
import com.HomeService.utils.DBconfig;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BookingDAO {

    // ==========================================================
    // USER METHODS
    // ==========================================================

    // 1. Create a NEW booking from the Checkout Form (Defaults to 'Pending')
    public boolean saveBooking(int userId, String serviceName, int price, String address, String date, String time, String instructions) {
        String sql = "INSERT INTO bookings (user_id, service_name, price, address, service_date, service_time, instructions, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, 'Pending')";
        
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setString(2, serviceName);
            stmt.setInt(3, price);
            stmt.setString(4, address);
            stmt.setString(5, date);
            stmt.setString(6, time);
            stmt.setString(7, instructions);
            
            return stmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 2. Fetch ONLY the logged-in user's bookings (With optional status filter)
    public List<BookingModel> getUserBookings(int userId, String statusFilter) {
        List<BookingModel> list = new ArrayList<>();
        String sql = "SELECT * FROM bookings WHERE user_id = ?";
        
        // If a specific status is requested (and it's not "All"), add it to the query
        if (statusFilter != null && !statusFilter.equalsIgnoreCase("All") && !statusFilter.isEmpty()) {
            sql += " AND status = ?";
        }
        sql += " ORDER BY created_at DESC";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            if (statusFilter != null && !statusFilter.equalsIgnoreCase("All") && !statusFilter.isEmpty()) {
                stmt.setString(2, statusFilter);
            }
            
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                BookingModel b = new BookingModel();
                b.setId(rs.getInt("id"));
                b.setUserId(rs.getInt("user_id"));
                b.setServiceName(rs.getString("service_name"));
                b.setServiceDate(rs.getDate("service_date"));
                b.setServiceTime(rs.getString("service_time"));
                b.setAddress(rs.getString("address")); 
                b.setStatus(rs.getString("status"));
                b.setPrice(rs.getDouble("price"));
                b.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(b);
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
        return list;
    }

    // 3. Get counts for the Dashboard AND the Booking Tabs (e.g., Pending (2))
    public Map<String, Integer> getBookingCounts(int userId) {
        Map<String, Integer> counts = new HashMap<>();
        counts.put("All", 0); counts.put("Pending", 0); 
        counts.put("Confirmed", 0); counts.put("Completed", 0); counts.put("Cancelled", 0);

        String sql = "SELECT status, COUNT(*) as count FROM bookings WHERE user_id = ? GROUP BY status";
        
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            int total = 0;
            while (rs.next()) {
                String stat = rs.getString("status");
                int count = rs.getInt("count");
                counts.put(stat, count);
                total += count;
            }
            counts.put("All", total);
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
        
        return counts;
    }

    // 4. Fetch a specific booking (used for pre-filling the Edit Form)
    public BookingModel getBookingById(int bookingId, int userId) {
        String sql = "SELECT * FROM bookings WHERE id = ? AND user_id = ?";
        BookingModel b = null;
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, bookingId);
            stmt.setInt(2, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                b = new BookingModel();
                b.setId(rs.getInt("id"));
                b.setUserId(rs.getInt("user_id"));
                b.setServiceName(rs.getString("service_name"));
                b.setServiceDate(rs.getDate("service_date"));
                b.setServiceTime(rs.getString("service_time"));
                b.setAddress(rs.getString("address"));
                b.setInstructions(rs.getString("instructions"));
                b.setStatus(rs.getString("status"));
                b.setPrice(rs.getDouble("price"));
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
        return b;
    }

    // 5. Update a booking (Security: ONLY works if status is 'Pending' AND belongs to user)
    public boolean updateUserBooking(int bookingId, int userId, String address, String date, String time, String instructions) {
        String sql = "UPDATE bookings SET address = ?, service_date = ?, service_time = ?, instructions = ? " +
                     "WHERE id = ? AND user_id = ? AND status = 'Pending'";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, address);
            stmt.setString(2, date);
            stmt.setString(3, time);
            stmt.setString(4, instructions);
            stmt.setInt(5, bookingId);
            stmt.setInt(6, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) { 
            e.printStackTrace(); 
            return false; 
        }
    }

    // 6. Delete/Cancel a booking (Security: ONLY works if status is 'Pending' AND belongs to user)
    public boolean deleteBooking(int bookingId, int userId) {
        String sql = "DELETE FROM bookings WHERE id = ? AND user_id = ? AND status = 'Pending'";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, bookingId);
            stmt.setInt(2, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) { 
            e.printStackTrace(); 
            return false; 
        }
    }

    // ==========================================================
    // ADMIN METHODS
    // ==========================================================

    // 7. Fetch ALL bookings for the Admin Dashboard
    public List<BookingModel> getAllBookings() {
        List<BookingModel> list = new ArrayList<>();
        String sql = "SELECT * FROM bookings ORDER BY created_at DESC";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                BookingModel b = new BookingModel();
                b.setId(rs.getInt("id"));
                b.setUserId(rs.getInt("user_id"));
                b.setServiceName(rs.getString("service_name"));
                b.setServiceDate(rs.getDate("service_date"));
                b.setServiceTime(rs.getString("service_time"));
                b.setAddress(rs.getString("address"));
                b.setStatus(rs.getString("status"));
                b.setPrice(rs.getDouble("price"));
                b.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(b);
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
        return list;
    }

    // 8. Update a booking's status (Pending -> Confirmed -> Completed)
    public boolean updateBookingStatus(int bookingId, String newStatus) {
        String sql = "UPDATE bookings SET status = ? WHERE id = ?";
        boolean rowUpdated = false;
        
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, newStatus);
            stmt.setInt(2, bookingId);
            
            rowUpdated = stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowUpdated;
    }
}