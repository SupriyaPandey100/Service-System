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

@WebServlet("/admindashboard")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        UserModel admin = (UserModel) session.getAttribute("userSession");

        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            UserService userService = new UserService();
            BookingService bookingService = new BookingService();

            /* Get statistics for dashboard */
            int totalServices = 8;
            int totalTechnicians = userService.getTotalTechniciansCount();
            int totalBookings = bookingService.getTotalBookingsCount();
            int pendingBookings = bookingService.getPendingBookingsCount();

            /* Get recent bookings */
            List<BookingModel> recentBookings = bookingService.getRecentBookings(5);

            /* Set attributes for JSP */
            request.setAttribute("totalServices", totalServices);
            request.setAttribute("totalTechnicians", totalTechnicians);
            request.setAttribute("totalBookings", totalBookings);
            request.setAttribute("pendingBookings", pendingBookings);
            request.setAttribute("recentBookings", recentBookings);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading dashboard: " + e.getMessage());
        }

        request.getRequestDispatcher("/WEB-INF/pages/admindashboard.jsp").forward(request, response);
    }
}