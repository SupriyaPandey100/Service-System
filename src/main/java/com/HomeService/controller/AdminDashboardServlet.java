package com.HomeService.controller;

import java.io.IOException;

import com.HomeService.dao.UserDAO;
import com.HomeService.dao.BookingDAO;
import com.HomeService.dao.ServiceDAO;
import com.HomeService.model.UserModel;

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

        // Check if user is logged in
        if (session == null || session.getAttribute("userSession") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Check if user is ADMIN
        UserModel user = (UserModel) session.getAttribute("userSession");
        if (user == null || !"ADMIN".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        try {
            // Create DAO instances
            ServiceDAO serviceDAO = new ServiceDAO();
            UserDAO userDAO = new UserDAO();
            BookingDAO bookingDAO = new BookingDAO();

            // Get counts from database
            int totalServices = serviceDAO.getTotalServicesCount();
            int totalTechnicians = userDAO.getTotalTechniciansCount();
            int totalBookings = bookingDAO.getTotalBookingsCount();
            int pendingBookings = bookingDAO.getPendingBookingsCount();

            // Set attributes for JSP
            request.setAttribute("totalServices", totalServices);
            request.setAttribute("totalTechnicians", totalTechnicians);
            request.setAttribute("totalBookings", totalBookings);
            request.setAttribute("pendingBookings", pendingBookings);

        } catch (Exception e) {
            e.printStackTrace();
            // Set default values if error occurs
            request.setAttribute("totalServices", 0);
            request.setAttribute("totalTechnicians", 0);
            request.setAttribute("totalBookings", 0);
            request.setAttribute("pendingBookings", 0);
        }

        request.getRequestDispatcher("/WEB-INF/pages/admindashboard.jsp")
               .forward(request, response);
    }
}