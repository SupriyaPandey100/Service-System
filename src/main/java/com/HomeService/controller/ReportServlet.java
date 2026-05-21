package com.HomeService.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.HomeService.dao.ReportDAO;
import com.HomeService.model.TechnicianModel;
import com.HomeService.model.UserModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/reports")
public class ReportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userSession") == null) {
            response.sendRedirect("login");
            return;
        }

        UserModel loggedInUser = (UserModel) session.getAttribute("userSession");

        if (!"ADMIN".equalsIgnoreCase(loggedInUser.getRole())) {
            response.sendRedirect("dashboard");
            return;
        }

        try {
            ReportDAO reportDAO = new ReportDAO();

            int totalBookings = reportDAO.getTotalBookingsCount();
            int totalRevenue = reportDAO.getTotalRevenue();
            int totalCustomers = reportDAO.getTotalCustomers();

            Map<String, Integer> bookingStatus = reportDAO.getBookingStatusCounts();
            List<TechnicianModel> topTechnicians = reportDAO.getTopTechnicians();

            request.setAttribute("totalBookings", totalBookings);
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("totalCustomers", totalCustomers);
            request.setAttribute("bookingStatus", bookingStatus);
            request.setAttribute("topTechnicians", topTechnicians);

            request.getRequestDispatcher("/WEB-INF/pages/reports.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admindashboard");
        }
    }
}