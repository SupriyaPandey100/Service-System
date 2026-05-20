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
        try {
            BookingService bookingService = new BookingService();
            UserService userService = new UserService();

            List<BookingModel> bookings = (statusFilter != null && !"all".equals(statusFilter))
                                          ? bookingService.getBookingsByStatus(statusFilter)
                                          : bookingService.getAllBookings();

            request.setAttribute("bookings", bookings);
            request.setAttribute("technicians", userService.getAllTechnicians());
            request.setAttribute("totalCount", bookingService.getTotalBookingsCount());
            // ... (other counts)
        } catch (Exception e) {
            e.printStackTrace();
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

        String action = request.getParameter("action");
        try {
            BookingService bookingService = new BookingService();
            if ("assign".equals(action)) {
                bookingService.assignTechnician(Integer.parseInt(request.getParameter("bookingId")),
                                               Integer.parseInt(request.getParameter("technicianId")));
                session.setAttribute("success", "Technician assigned!");
            }
            // ... (other actions)
        } catch (Exception e) {
            session.setAttribute("error", "Error: " + e.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/manageBooking");
    }
}