package com.HomeService.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.HomeService.model.NotificationModel;
import com.HomeService.utils.DBconfig;

public class NotificationDAO {

    /* FIXED: Removed the 'type' parameter so it matches your database perfectly */
    public boolean createNotification(int userId, String message) {
        String sql = "INSERT INTO notifications (user_id, message) VALUES (?, ?)";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setString(2, message);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println("Error: Failed to create new notification record.");
            e.printStackTrace();
            return false;
        }
    }

    /* FIXED: Removed notif.setType() to stop the dashboard from crashing */
    public List<NotificationModel> getUnreadNotificationsForUser(int userId) {
        List<NotificationModel> notifications = new ArrayList<>();
        String sql = "SELECT * FROM notifications WHERE user_id = ? AND is_read = FALSE ORDER BY created_at DESC";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    NotificationModel notif = new NotificationModel();
                    notif.setId(rs.getInt("id"));
                    notif.setUserId(rs.getInt("user_id"));
                    notif.setMessage(rs.getString("message"));

                    /* THE CRASH IS GONE: We no longer ask for rs.getString("type") here! */

                    notif.setRead(rs.getBoolean("is_read"));
                    notif.setCreatedAt(rs.getTimestamp("created_at"));

                    notifications.add(notif);
                }
            }
        } catch (Exception e) {
            System.out.println("Database Warning: Failed to retrieve notifications array.");
            e.printStackTrace();
        }
        return notifications;
    }

    public boolean markAllAsRead(int userId) {
        String sql = "UPDATE notifications SET is_read = TRUE WHERE user_id = ?";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println("Error: Failed to execute markAllAsRead.");
            e.printStackTrace();
            return false;
        }
    }
}