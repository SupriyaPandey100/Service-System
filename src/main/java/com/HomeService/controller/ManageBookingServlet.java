package com.HomeService.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import com.HomeService.model.BookingModel;
import com.HomeService.model.UserModel;
import com.HomeService.service.BookingService;
import com.HomeService.service.UserService;

@WebServlet("/admin/manageBooking")
public class ManageBookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get session without creating a new one
        HttpSession session = request.getSession(false);
        
        // Check if session exists
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Check if user is logged in
        UserModel admin = (UserModel) session.getAttribute("userSession");
        
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String statusFilter = request.getParameter("status");
        
        try {
            BookingService bookingService = new BookingService();
            UserService userService = new UserService();
            
            // Get bookings based on status filter
            List<BookingModel> bookings;
            if (statusFilter != null && !"all".equals(statusFilter)) {
                bookings = bookingService.getBookingsByStatus(statusFilter);
            } else {
                bookings = bookingService.getAllBookings();
            }
            
            // Get counts
            int totalCount = bookingService.getTotalBookingsCount();
            int pendingCount = bookingService.getPendingBookingsCount();
            int confirmedCount = bookingService.getConfirmedBookingsCount();
            int completedCount = bookingService.getCompletedBookingsCount();
            int cancelledCount = bookingService.getCancelledBookingsCount();
            
            // Get technicians for assignment
            List<UserModel> technicians = userService.getAllTechnicians();
            
            // Set attributes for JSP
            request.setAttribute("bookings", bookings);
            request.setAttribute("technicians", technicians);
            request.setAttribute("totalCount", totalCount);
            request.setAttribute("pendingCount", pendingCount);
            request.setAttribute("confirmedCount", confirmedCount);
            request.setAttribute("completedCount", completedCount);
            request.setAttribute("cancelledCount", cancelledCount);
            request.setAttribute("currentStatus", statusFilter);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading bookings: " + e.getMessage());
        }
        
        request.getRequestDispatcher("/WEB-INF/pages/manageBooking.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get session without creating a new one
        HttpSession session = request.getSession(false);
        
        // Check if session exists
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Check if user is logged in
        UserModel admin = (UserModel) session.getAttribute("userSession");
        
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        
        try {
            BookingService bookingService = new BookingService();
            
            if ("assign".equals(action)) {
                int bookingId = Integer.parseInt(request.getParameter("bookingId"));
                int technicianId = Integer.parseInt(request.getParameter("technicianId"));
                bookingService.assignTechnician(bookingId, technicianId);
                session.setAttribute("success", "Technician assigned successfully");
                
            } else if ("complete".equals(action)) {
                int bookingId = Integer.parseInt(request.getParameter("bookingId"));
                bookingService.updateBookingStatus(bookingId, "COMPLETED");
                session.setAttribute("success", "Booking marked as completed");
                
            } else if ("cancel".equals(action)) {
                int bookingId = Integer.parseInt(request.getParameter("bookingId"));
                bookingService.updateBookingStatus(bookingId, "CANCELLED");
                session.setAttribute("success", "Booking cancelled successfully");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Error: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/manageBooking");
    }
}