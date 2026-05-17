package com.HomeService.service;

import java.util.List;


import com.HomeService.dao.BookingDAO;
import com.HomeService.model.BookingModel;

public class BookingService {
    
    private BookingDAO bookingDAO;
    
    public BookingService() {
        this.bookingDAO = new BookingDAO();
    }
    
    /* Get all bookings */
    public List<BookingModel> getAllBookings() throws Exception {
        return bookingDAO.getAllBookings();
    }
    
    /* Get bookings by status */
    public List<BookingModel> getBookingsByStatus(String status) throws Exception {
        return bookingDAO.getBookingsByStatus(status);
    }
    
    /* Get total bookings count */
    public int getTotalBookingsCount() throws Exception {
        return bookingDAO.getTotalBookingsCount();
    }
    
    /* Get pending bookings count */
    public int getPendingBookingsCount() throws Exception {
        return bookingDAO.getCountByStatus("PENDING");
    }
    
    /* Get confirmed bookings count */
    public int getConfirmedBookingsCount() throws Exception {
        return bookingDAO.getCountByStatus("CONFIRMED");
    }
    
    /* Get completed bookings count */
    public int getCompletedBookingsCount() throws Exception {
        return bookingDAO.getCountByStatus("COMPLETED");
    }
    public int getCancelledBookingsCount() throws Exception {
        return bookingDAO.getCountByStatus("CANCELLED");
    }
    
    /* Get recent bookings */
    public List<BookingModel> getRecentBookings(int limit) throws Exception {
        return bookingDAO.getRecentBookings(limit);
    }
    
    /* Update booking status */
    public boolean updateBookingStatus(int bookingId, String status) throws Exception {
        return bookingDAO.updateBookingStatus(bookingId, status);
    }
    
    /* Assign technician to booking */
    public boolean assignTechnician(int bookingId, int technicianId) throws Exception {
        return bookingDAO.assignTechnician(bookingId, technicianId);
    }
}