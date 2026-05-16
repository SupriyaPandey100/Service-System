package com.HomeService.dao;

import com.HomeService.model.BookingModel;
import com.HomeService.utils.DBconfig;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BookingDAO {

    // 1. Fetch Bookings (With optional status filter)
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
                b.setStatus(rs.getString("status"));
                b.setPrice(rs.getDouble("price"));
                b.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(b);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    // 2. Get counts for the Dashboard AND the Booking Tabs (e.g., Pending (2))
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
        } catch (SQLException e) { e.printStackTrace(); }
        
        return counts;
    }
}