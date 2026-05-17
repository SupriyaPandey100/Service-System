package com.HomeService.dao;

import com.HomeService.model.BookingModel;
import com.HomeService.model.NotificationModel;
import com.HomeService.utils.DBconfig;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SearchDAO {

    // 1. Search Notifications by message keyword
    public List<NotificationModel> searchNotifications(int userId, String query) {
        List<NotificationModel> results = new ArrayList<>();
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

    // 2. Search Bookings by service name or status
    // Column names match your actual DB: booking_id, service_name, service_price,
    // customer_name, customer_phone, preferred_date, preferred_time,
    // service_address, additional_notes, total_amount, status,
    // payment_status, payment_method, booking_date, updated_at
    public List<BookingModel> searchBookings(int userId, String query) {
        List<BookingModel> results = new ArrayList<>();
        String sql = "SELECT * FROM bookings "
                   + "WHERE user_id = ? "
                   + "AND (service_name LIKE ? OR status LIKE ? OR service_address LIKE ?) "
                   + "ORDER BY booking_date DESC";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setString(2, "%" + query + "%");
            stmt.setString(3, "%" + query + "%");
            stmt.setString(4, "%" + query + "%");

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                BookingModel b = new BookingModel();

                // Match exact DB column names from your screenshots
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

                results.add(b);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return results;
    }
}