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

    // 1. Create a new notification (Used by Admin actions)
    public boolean createNotification(int userId, String message, String type) {
        String sql = "INSERT INTO notifications (user_id, message, type) VALUES (?, ?, ?)";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setString(2, message);
            stmt.setString(3, type);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 2. Fetch unread notifications for the User Dashboard
    public List<NotificationModel> getUnreadNotificationsForUser(int userId) {
        List<NotificationModel> notifications = new ArrayList<>();
        // Gets unread notifications, newest ones first
        String sql = "SELECT * FROM notifications WHERE user_id = ? AND is_read = FALSE ORDER BY created_at DESC";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                NotificationModel notif = new NotificationModel();
                notif.setId(rs.getInt("id"));
                notif.setUserId(rs.getInt("user_id"));
                notif.setMessage(rs.getString("message"));
                notif.setType(rs.getString("type"));
                notif.setRead(rs.getBoolean("is_read"));
                notif.setCreatedAt(rs.getTimestamp("created_at"));

                notifications.add(notif);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return notifications;
    }

    // 3. Mark all notifications as read (When user clicks "Mark all as read")
    public boolean markAllAsRead(int userId) {
        String sql = "UPDATE notifications SET is_read = TRUE WHERE user_id = ?";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}