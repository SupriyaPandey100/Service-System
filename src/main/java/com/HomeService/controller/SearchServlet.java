package com.HomeService.controller;

import java.io.IOException;
import java.util.List;

import com.HomeService.dao.SearchDAO;
import com.HomeService.model.BookingModel;
import com.HomeService.model.NotificationModel;
import com.HomeService.model.UserModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * ============================================================================
 * Controller: SearchServlet
 * URL Mapping: /search
 * Purpose: Dynamically intercepts programmatic queries, searches matching database
 * records for alerts and booking transactions, and forwards parameters to the view.
 * ============================================================================
 */
@WebServlet("/search")
public class SearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Session and Security Check Guard
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        UserModel user = (UserModel) session.getAttribute("loggedUser");
        String searchQuery = request.getParameter("query");

        // If search parameters are empty, forward context directly without executing heavy query scripts
        if (searchQuery == null || searchQuery.trim().isEmpty()) {
            request.getRequestDispatcher("/WEB-INF/pages/search_results.jsp").forward(request, response);
            return;
        }

        // 2. Fetch Multi-Tier Collections using the Search Data Access Object
        SearchDAO searchDao = new SearchDAO();

        /* Fixed Alignment: Swapped user.getId() out for your accurate getUserId() signature mapping */
        List<NotificationModel> notificationResults = searchDao.searchNotifications(user.getUserId(), searchQuery);
        List<BookingModel> bookingResults = searchDao.searchBookings(user.getUserId(), searchQuery);

        // 3. Request Attribute Context Packaging
        request.setAttribute("searchQuery", searchQuery);
        request.setAttribute("notificationResults", notificationResults);
        request.setAttribute("bookingResults", bookingResults);

        // Compute state evaluation checks to verify if records were parsed inside either collection
        boolean hasResults = (notificationResults != null && !notificationResults.isEmpty())
                          || (bookingResults != null && !bookingResults.isEmpty());
        request.setAttribute("hasResults", hasResults);

        // Maintain system identity mappings globally across layout headers
        request.setAttribute("user", user);

        // 4. Forward Payload to View Layer
        request.getRequestDispatcher("/WEB-INF/pages/search_results.jsp").forward(request, response);
    }
}