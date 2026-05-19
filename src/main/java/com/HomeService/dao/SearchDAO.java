package com.HomeService.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.HomeService.model.BookingModel; // <-- UNCOMMENTED
import com.HomeService.model.NotificationModel;
import com.HomeService.utils.DBconfig;

public class SearchDAO {

    // 1. Search Notifications
    public List<NotificationModel> searchNotifications(int userId, String query) {
        List<NotificationModel> results = new ArrayList<>();
        // Using % surrounds the query with wildcards (e.g., searches for "*plumbing*")
        String sql = "SELECT * FROM notifications WHERE user_id = ? AND message LIKE ? ORDER BY created_at DESC";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setString(2, "%" + query + "%");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                NotificationModel notif = new NotificationModel();
                notif.setId(rs.getInt("id"));
                notif.setMessage(rs.getString("message"));
                notif.setType(rs.getString("type"));
                notif.setCreatedAt(rs.getTimestamp("created_at"));
                results.add(notif);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return results;
    }

    // 2. Search Bookings <-- UNCOMMENTED AND FULLY IMPLEMENTED
    public List<BookingModel> searchBookings(int userId, String query) {
        List<BookingModel> results = new ArrayList<>();
        // Searches by service name or booking status
        String sql = "SELECT * FROM bookings WHERE user_id = ? AND (service_name LIKE ? OR status LIKE ?) ORDER BY created_at DESC";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setString(2, "%" + query + "%");
            stmt.setString(3, "%" + query + "%");

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
                results.add(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return results;
    }
}