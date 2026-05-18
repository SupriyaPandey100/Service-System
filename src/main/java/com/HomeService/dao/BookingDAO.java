package com.HomeService.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.HomeService.model.BookingModel;
import com.HomeService.utils.DBconfig;

public class BookingDAO {

    /* Get all bookings */
    public List<BookingModel> getAllBookings() throws Exception {

        List<BookingModel> bookings = new ArrayList<>();

        String sql = """
            SELECT
                b.*,
                s.service_name,
                s.price,
                u.full_name AS customer_name,
                u.phone AS customer_phone,
                t.full_name AS technician_name,
                t.phone AS technician_phone
            FROM bookings b
            LEFT JOIN services s ON b.service_id = s.service_id
            LEFT JOIN users u ON b.user_id = u.user_id
            LEFT JOIN users t ON b.technician_id = t.user_id
            ORDER BY b.created_at DESC
        """;

        try (
            Connection conn = DBconfig.getConnection();
            PreparedStatement pst = conn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery()
        ) {

            while (rs.next()) {

                BookingModel booking = new BookingModel();

                booking.setBookingId(rs.getInt("booking_id"));
                booking.setUserId(rs.getInt("user_id"));
                booking.setServiceId(rs.getInt("service_id"));
                booking.setTechnicianId(rs.getInt("technician_id"));

                booking.setCustomerName(rs.getString("customer_name"));
                booking.setCustomerPhone(rs.getString("customer_phone"));

                booking.setServiceName(rs.getString("service_name"));

                booking.setTechnicianName(rs.getString("technician_name"));
                booking.setTechnicianPhone(rs.getString("technician_phone"));

                booking.setScheduledDate(rs.getDate("scheduled_date"));
                booking.setScheduledTime(rs.getString("scheduled_time"));

                booking.setAddress(rs.getString("address"));
                booking.setStatus(rs.getString("status"));
                booking.setNotes(rs.getString("notes"));

                booking.setPrice(rs.getDouble("price"));
                booking.setCreatedAt(rs.getTimestamp("created_at"));

                bookings.add(booking);
            }
        }

        return bookings;
    }

    /* Get bookings by status */
    public List<BookingModel> getBookingsByStatus(String status) throws Exception {

        List<BookingModel> bookings = new ArrayList<>();

        String sql = """
            SELECT
                b.*,
                s.service_name,
                s.price,
                u.full_name AS customer_name,
                u.phone AS customer_phone,
                t.full_name AS technician_name,
                t.phone AS technician_phone
            FROM bookings b
            LEFT JOIN services s ON b.service_id = s.service_id
            LEFT JOIN users u ON b.user_id = u.user_id
            LEFT JOIN users t ON b.technician_id = t.user_id
            WHERE b.status = ?
            ORDER BY b.created_at DESC
        """;

        try (
            Connection conn = DBconfig.getConnection();
            PreparedStatement pst = conn.prepareStatement(sql)
        ) {

            pst.setString(1, status);

            ResultSet rs = pst.executeQuery();

            while (rs.next()) {

                BookingModel booking = new BookingModel();

                booking.setBookingId(rs.getInt("booking_id"));
                booking.setUserId(rs.getInt("user_id"));
                booking.setServiceId(rs.getInt("service_id"));
                booking.setTechnicianId(rs.getInt("technician_id"));

                booking.setCustomerName(rs.getString("customer_name"));
                booking.setCustomerPhone(rs.getString("customer_phone"));

                booking.setServiceName(rs.getString("service_name"));

                booking.setTechnicianName(rs.getString("technician_name"));
                booking.setTechnicianPhone(rs.getString("technician_phone"));

                booking.setScheduledDate(rs.getDate("scheduled_date"));
                booking.setScheduledTime(rs.getString("scheduled_time"));

                booking.setAddress(rs.getString("address"));
                booking.setStatus(rs.getString("status"));
                booking.setNotes(rs.getString("notes"));

                booking.setPrice(rs.getDouble("price"));
                booking.setCreatedAt(rs.getTimestamp("created_at"));

                bookings.add(booking);
            }
        }

        return bookings;
    }

    /* Total bookings count */
    public int getTotalBookingsCount() throws Exception {

        String sql = "SELECT COUNT(*) FROM bookings";

        try (
            Connection conn = DBconfig.getConnection();
            PreparedStatement pst = conn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery()
        ) {

            if (rs.next()) {
                return rs.getInt(1);
            }
        }

        return 0;
    }

    /* Count by status */
    public int getCountByStatus(String status) throws Exception {

        String sql = "SELECT COUNT(*) FROM bookings WHERE status = ?";

        try (
            Connection conn = DBconfig.getConnection();
            PreparedStatement pst = conn.prepareStatement(sql)
        ) {

            pst.setString(1, status);

            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }
        }

        return 0;
    }

    /* Recent bookings */
    public List<BookingModel> getRecentBookings(int limit) throws Exception {

        List<BookingModel> bookings = new ArrayList<>();

        String sql = """
            SELECT
                b.*,
                s.service_name,
                s.price
            FROM bookings b
            LEFT JOIN services s ON b.service_id = s.service_id
            ORDER BY b.created_at DESC
            LIMIT ?
        """;

        try (
            Connection conn = DBconfig.getConnection();
            PreparedStatement pst = conn.prepareStatement(sql)
        ) {

            pst.setInt(1, limit);

            ResultSet rs = pst.executeQuery();

            while (rs.next()) {

                BookingModel booking = new BookingModel();

                booking.setBookingId(rs.getInt("booking_id"));
                booking.setServiceName(rs.getString("service_name"));
                booking.setStatus(rs.getString("status"));
                booking.setScheduledDate(rs.getDate("scheduled_date"));
                booking.setPrice(rs.getDouble("price"));

                bookings.add(booking);
            }
        }

        return bookings;
    }

    /* Update booking status */
    public boolean updateBookingStatus(int bookingId, String status) throws Exception {

        String sql =
                "UPDATE bookings SET status = ? WHERE booking_id = ?";

        try (
            Connection conn = DBconfig.getConnection();
            PreparedStatement pst = conn.prepareStatement(sql)
        ) {

            pst.setString(1, status);
            pst.setInt(2, bookingId);

            return pst.executeUpdate() > 0;
        }
    }

    /* Assign technician */
    public boolean assignTechnician(int bookingId, int technicianId) throws Exception {

        String sql = """
            UPDATE bookings
            SET technician_id = ?
            WHERE booking_id = ?
        """;

        try (
            Connection conn = DBconfig.getConnection();
            PreparedStatement pst = conn.prepareStatement(sql)
        ) {

            pst.setInt(1, technicianId);
            pst.setInt(2, bookingId);

            return pst.executeUpdate() > 0;
        }
    }
}