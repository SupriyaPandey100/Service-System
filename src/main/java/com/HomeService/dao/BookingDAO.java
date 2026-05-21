package com.HomeService.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.HomeService.model.BookingModel;
import com.HomeService.utils.DBconfig;

public class BookingDAO {

    // Get total bookings count
    public int getTotalBookingsCount() throws Exception {
        String sql = "SELECT COUNT(*) FROM bookings";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error getting total bookings count: " + e.getMessage());
        }

        return 0;
    }

    // Get pending bookings count
    public int getPendingBookingsCount() throws Exception {
        String sql = "SELECT COUNT(*) FROM bookings WHERE status = 'PENDING'";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error getting pending bookings count: " + e.getMessage());
        }

        return 0;
    }

    // Get all bookings
    public List<BookingModel> getAllBookings() throws Exception {
        List<BookingModel> bookings = new ArrayList<>();

        String sql = "SELECT b.*, u.full_name as customer_name, s.service_name, t.full_name as technician_name " +
                     "FROM bookings b " +
                     "LEFT JOIN users u ON b.user_id = u.user_id " +
                     "LEFT JOIN services s ON b.service_id = s.service_id " +
                     "LEFT JOIN users t ON b.technician_id = t.user_id " +
                     "ORDER BY b.created_at DESC";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {

            while (rs.next()) {
                BookingModel booking = new BookingModel();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setUserId(rs.getInt("user_id"));
                booking.setCustomerName(rs.getString("customer_name"));
                booking.setServiceId(rs.getInt("service_id"));
                booking.setServiceName(rs.getString("service_name"));
                booking.setTechnicianId(rs.getInt("technician_id"));
                booking.setTechnicianName(rs.getString("technician_name"));
                booking.setScheduledDate(rs.getDate("scheduled_date"));
                booking.setScheduledTime(rs.getString("scheduled_time"));
                booking.setAddress(rs.getString("address"));
                booking.setStatus(rs.getString("status"));
                booking.setNotes(rs.getString("notes"));
                booking.setCreatedAt(rs.getTimestamp("created_at"));
                bookings.add(booking);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error getting all bookings: " + e.getMessage());
        }

        return bookings;
    }

    // Get bookings by status
    public List<BookingModel> getBookingsByStatus(String status) throws Exception {
        List<BookingModel> bookings = new ArrayList<>();

        String sql = "SELECT b.*, u.full_name as customer_name, s.service_name, t.full_name as technician_name " +
                     "FROM bookings b " +
                     "LEFT JOIN users u ON b.user_id = u.user_id " +
                     "LEFT JOIN services s ON b.service_id = s.service_id " +
                     "LEFT JOIN users t ON b.technician_id = t.user_id " +
                     "WHERE b.status = ? " +
                     "ORDER BY b.created_at DESC";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setString(1, status);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                BookingModel booking = new BookingModel();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setUserId(rs.getInt("user_id"));
                booking.setCustomerName(rs.getString("customer_name"));
                booking.setServiceId(rs.getInt("service_id"));
                booking.setServiceName(rs.getString("service_name"));
                booking.setTechnicianId(rs.getInt("technician_id"));
                booking.setTechnicianName(rs.getString("technician_name"));
                booking.setScheduledDate(rs.getDate("scheduled_date"));
                booking.setScheduledTime(rs.getString("scheduled_time"));
                booking.setAddress(rs.getString("address"));
                booking.setStatus(rs.getString("status"));
                bookings.add(booking);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error getting bookings by status: " + e.getMessage());
        }

        return bookings;
    }

    // Assign technician to booking
    public boolean assignTechnician(int bookingId, int technicianId) throws Exception {
        String sql = "UPDATE bookings SET technician_id = ?, status = 'CONFIRMED' WHERE booking_id = ?";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setInt(1, technicianId);
            pst.setInt(2, bookingId);

            return pst.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error assigning technician: " + e.getMessage());
        }
    }

    // Cancel booking
    public boolean cancelBooking(int bookingId) throws Exception {
        String sql = "UPDATE bookings SET status = 'CANCELLED' WHERE booking_id = ?";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setInt(1, bookingId);

            return pst.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error cancelling booking: " + e.getMessage());
        }
    }

    // Complete booking
    public boolean completeBooking(int bookingId) throws Exception {
        String sql = "UPDATE bookings SET status = 'COMPLETED' WHERE booking_id = ?";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setInt(1, bookingId);

            return pst.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error completing booking: " + e.getMessage());
        }
    }
}