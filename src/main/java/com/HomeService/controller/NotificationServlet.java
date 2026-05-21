package com.HomeService.controller;

import java.io.IOException;
import java.util.List;

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
 * Controller: NotificationServlet
 * URL: /notifications
 * Purpose: Catches the header bell click, fetches the data, and displays notifications.jsp
 */
@WebServlet("/notifications")
public class NotificationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Security Check
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        UserModel user = (UserModel) session.getAttribute("loggedUser");
        NotificationDAO notifDao = new NotificationDAO();

        try {
            // 2. Fetch unread notifications from database
            List<NotificationModel> notifications = notifDao.getUnreadNotificationsForUser(user.getUserId());
            
            // 3. Send the list to your notifications.jsp file
            request.setAttribute("notificationsList", notifications);

            // 4. Forward to your JSP (Adjust the path if your jsp is inside WEB-INF)
            request.getRequestDispatcher("/WEB-INF/pages/notifications.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("Error loading notifications view.");
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/dashboard");
        }
    }
}