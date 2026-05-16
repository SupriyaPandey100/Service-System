package com.HomeService.controller;

import com.HomeService.dao.SearchDAO;
import com.HomeService.model.BookingModel; // <-- UNCOMMENTED
import com.HomeService.model.NotificationModel;
import com.HomeService.model.UserModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
// PrintWriter import removed! No more HTML strings in Java.

@WebServlet("/search")
public class SearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Security check
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        UserModel user = (UserModel) session.getAttribute("loggedUser");
        String searchQuery = request.getParameter("query");

        // If search is completely empty, load the page with empty results
        if (searchQuery == null || searchQuery.trim().isEmpty()) {
            request.getRequestDispatcher("/WEB-INF/pages/search_results.jsp").forward(request, response);
            return;
        }

        // 2. Fetch the data using the DAO
        SearchDAO searchDao = new SearchDAO();
        List<NotificationModel> notificationResults = searchDao.searchNotifications(user.getId(), searchQuery);
        
        // <-- NOW SEARCHING BOOKINGS TOO -->
        List<BookingModel> bookingResults = searchDao.searchBookings(user.getId(), searchQuery); 
        
        // 3. Pass results to JSP
        request.setAttribute("searchQuery", searchQuery);
        request.setAttribute("notificationResults", notificationResults);
        request.setAttribute("bookingResults", bookingResults);
        
        // Check if anything was found at all in either list
        boolean hasResults = !notificationResults.isEmpty() || !bookingResults.isEmpty(); 
        request.setAttribute("hasResults", hasResults);
        
        // Send the user object back to the header
        request.setAttribute("user", user);
        
        // 4. Forward to the View (JSP handles all the HTML!)
        request.getRequestDispatcher("/WEB-INF/pages/search_results.jsp").forward(request, response);
    }
}