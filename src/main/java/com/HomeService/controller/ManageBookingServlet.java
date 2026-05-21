package com.HomeService.controller;

import java.io.IOException;
import java.util.List;

import com.HomeService.model.BookingModel;
import com.HomeService.model.UserModel;
import com.HomeService.service.BookingService;
import com.HomeService.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/manageBooking")
public class ManageBookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Debug: Check if session or attribute is null
        if (session == null || session.getAttribute("userSession") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        UserModel admin = (UserModel) session.getAttribute("userSession");
        if (!"ADMIN".equals(admin.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String statusFilter = request.getParameter("status");
        if (statusFilter == null || statusFilter.isBlank()) {
            statusFilter = "all";
        }

        try {
            BookingService bookingService = new BookingService();
            UserService userService = new UserService();

            List<BookingModel> bookings = (!"all".equalsIgnoreCase(statusFilter))
                                          ? bookingService.getBookingsByStatus(statusFilter)
                                          : bookingService.getAllBookings();

            request.setAttribute("bookings", bookings);
            request.setAttribute("technicians", userService.getAllTechnicians());
            request.setAttribute("currentStatus", statusFilter);
            request.setAttribute("totalCount", bookingService.getTotalBookingsCount());
            request.setAttribute("pendingCount", bookingService.getPendingBookingsCount());
            request.setAttribute("confirmedCount", bookingService.getConfirmedBookingsCount());
            request.setAttribute("completedCount", bookingService.getCompletedBookingsCount());
            request.setAttribute("cancelledCount", bookingService.getCancelledBookingsCount());
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Unable to load bookings: " + e.getMessage());
        }
        request.getRequestDispatcher("/WEB-INF/pages/manageBooking.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userSession") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        UserModel admin = (UserModel) session.getAttribute("userSession");
        if (!"ADMIN".equalsIgnoreCase(admin.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        try {
            BookingService bookingService = new BookingService();
            if ("assign".equals(action)) {
                boolean updated = bookingService.assignTechnician(
                        Integer.parseInt(request.getParameter("bookingId")),
                        Integer.parseInt(request.getParameter("technicianId")));
                session.setAttribute(updated ? "success" : "error",
                        updated ? "Technician assigned!" : "Booking could not be assigned.");
            } else if ("cancel".equals(action)) {
                boolean updated = bookingService.updateBookingStatus(
                        Integer.parseInt(request.getParameter("bookingId")), "CANCELLED");
                session.setAttribute(updated ? "success" : "error",
                        updated ? "Booking cancelled!" : "Booking could not be cancelled.");
            } else if ("complete".equals(action)) {
                boolean updated = bookingService.updateBookingStatus(
                        Integer.parseInt(request.getParameter("bookingId")), "COMPLETED");
                session.setAttribute(updated ? "success" : "error",
                        updated ? "Booking marked as completed!" : "Booking could not be completed.");
            } else {
                session.setAttribute("error", "Invalid booking action.");
            }
        } catch (Exception e) {
            session.setAttribute("error", "Error: " + e.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/manageBooking");
    }
}