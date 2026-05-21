package com.HomeService.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.HomeService.dao.BookingDAO;
import com.HomeService.dao.NotificationDAO;
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
 * Controller: UserDashboardServlet
 * URL Mapping: /dashboard
 * Purpose: Prepares backend system metrics and maps data attributes safely
 * using defensive null guards to isolate runtime database exceptions.
 * ============================================================================
 */
@WebServlet("/dashboard")
public class UserDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Session Verification Gate
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login?error=UnauthorizedAccess");
            return;
        }

        UserModel user = (UserModel) session.getAttribute("loggedUser");

        try {
            // --- 2A. FETCH NOTIFICATION DATA (Defensively Guarded) ---
            NotificationDAO notifDao = new NotificationDAO();
            List<NotificationModel> notifications = null;

            try {
                notifications = notifDao.getUnreadNotificationsForUser(user.getUserId());
            } catch (Exception e) {
                System.out.println("Warning: Notification database tables lookup threw an error. Initializing empty fallback list.");
                e.printStackTrace();
            }

            // If the query failed or returned null, initialize an empty list to protect the view layer
            if (notifications == null) {
                notifications = new ArrayList<>();
            }

            int count = notifications.size();
            session.setAttribute("notificationCount", count); // Saved globally for this user!
            request.setAttribute("notificationsList", notifications);


            // --- 2B. FETCH BOOKING METRICS (Defensively Guarded) ---
            BookingDAO bookingDao = new BookingDAO();
            Map<String, Integer> counts = null;

            try {
                counts = bookingDao.getBookingCounts(user.getUserId());
            } catch (Exception e) {
                System.out.println("Warning: Booking counts database lookup threw an error. Initializing safe fallback mapping.");
                e.printStackTrace();
            }

            // Defensive setup: If the map returns empty or null, manually fill keys with 0
            if (counts == null) {
                counts = new HashMap<>();
                counts.put("All", 0);
                counts.put("Pending", 0);
                counts.put("Completed", 0);
            }

            request.setAttribute("bookingCounts", counts);
            request.setAttribute("user", user);

            // 3. Forward to view layer layout
            request.getRequestDispatcher("/WEB-INF/pages/userdashboard.jsp").forward(request, response);

        } catch (Exception e) {
            System.out.println("CRITICAL ERROR: Failed to assemble dashboard framework components layout.");
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