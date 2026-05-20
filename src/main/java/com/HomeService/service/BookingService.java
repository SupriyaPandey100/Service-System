package com.HomeService.service;

import java.util.List;

import com.HomeService.dao.BookingDAO;
import com.HomeService.model.BookingModel;

public class BookingService {

    private BookingDAO bookingDAO = new BookingDAO();

    public List<BookingModel> getAllBookings() throws Exception {
        return bookingDAO.getAllBookings();
    }

    public List<BookingModel> getBookingsByStatus(String status) throws Exception {
        return bookingDAO.getBookingsByStatus(status);
    }

    public int getTotalBookingsCount() throws Exception {
        return bookingDAO.getTotalBookingsCount();
    }

    public int getPendingBookingsCount() throws Exception {
        return bookingDAO.getPendingBookingsCount();
    }

    public int getConfirmedBookingsCount() throws Exception {
        return bookingDAO.getBookingsByStatus("CONFIRMED").size();
    }

    public int getCompletedBookingsCount() throws Exception {
        return bookingDAO.getBookingsByStatus("COMPLETED").size();
    }

    public int getCancelledBookingsCount() throws Exception {
        return bookingDAO.getBookingsByStatus("CANCELLED").size();
    }

    public boolean assignTechnician(int bookingId, int technicianId) throws Exception {
        return bookingDAO.assignTechnician(bookingId, technicianId);
    }

    public boolean updateBookingStatus(int bookingId, String status) throws Exception {
        if ("CANCELLED".equalsIgnoreCase(status)) {
            return bookingDAO.cancelBooking(bookingId);
        } else if ("COMPLETED".equalsIgnoreCase(status)) {
            return bookingDAO.completeBooking(bookingId);
        }
        return false;
    }
}