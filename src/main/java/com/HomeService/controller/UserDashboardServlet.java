package com.HomeService.controller;

import com.HomeService.dao.NotificationDAO;
import com.HomeService.dao.BookingDAO; 
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
import java.util.Map;

@WebServlet("/dashboard") 
public class UserDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Authentication & Security Check
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login?error=UnauthorizedAccess");
            return;
        }

        // 2. Retrieve Logged-In User
        UserModel user = (UserModel) session.getAttribute("loggedUser");
        
        try {
            // --- 3A. FETCH DYNAMIC NOTIFICATIONS ---
            NotificationDAO notifDao = new NotificationDAO();
            List<NotificationModel> notifications = notifDao.getUnreadNotificationsForUser(user.getId());
            
            // Pass the count for the red bell icon
            request.setAttribute("notificationCount", notifications.size());
            // Pass the actual list for the sidebar
            request.setAttribute("notificationsList", notifications);
            
            
            // --- 3B. FETCH DYNAMIC BOOKING DATA ---
            BookingDAO bookingDao = new BookingDAO();
            Map<String, Integer> counts = bookingDao.getBookingCounts(user.getId());
            
            // CRITICAL FIX: Pass the entire map to match what userdashboard.jsp is expecting
            // This allows the JSP to dynamically call ${bookingCounts['All']}, ${bookingCounts['Pending']}, etc.
            request.setAttribute("bookingCounts", counts);
            
            
            // Send the user object to the JSP context
            request.setAttribute("user", user);

            // 4. Forward to the View
            request.getRequestDispatcher("/WEB-INF/pages/userdashboard.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/login?error=DashboardLoadFailed");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}