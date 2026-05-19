package com.HomeService.controller;

import com.HomeService.dao.NotificationDAO;
import com.HomeService.model.UserModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet implementation class MarkNotificationsReadServlet
 * Clears the user's unread notifications and redirects back to the dashboard.
 */
@WebServlet("/mark-notifications-read")
public class MarkNotificationsReadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    public MarkNotificationsReadServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        if (session != null && session.getAttribute("loggedUser") != null) {
            UserModel user = (UserModel) session.getAttribute("loggedUser");
            
            NotificationDAO notifDao = new NotificationDAO();
            notifDao.markAllAsRead(user.getId());
        }
        
      
        response.sendRedirect(request.getContextPath() + "/dashboard");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
       
        doGet(request, response);
    }
}