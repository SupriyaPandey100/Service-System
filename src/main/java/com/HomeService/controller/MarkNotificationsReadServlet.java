package com.HomeService.controller;

import java.io.IOException;

import com.HomeService.dao.NotificationDAO;
import com.HomeService.model.UserModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * ============================================================================
 * Controller: MarkNotificationsReadServlet
 * Purpose: Securely captures on-page modal trigger hits, executes SQL updates,
 * and handles safe path forwards back into the dashboard.
 * ============================================================================
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

        /* 1. Fetch active container session without instantiating new tracks */
        HttpSession session = request.getSession(false);
        UserModel user = null;

        if (session != null) {
            user = (UserModel) session.getAttribute("loggedUser");
        }

        /* Defensive Guard: If user credentials are missing, block execution and exit straight to login */
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login?error=SessionExpired");
            return;
        }

        try {
            /* 2. Instantiate data layout controller to alter state tracking flags */
            NotificationDAO notifDao = new NotificationDAO();

            /* Fixed Alignment: Updated call to cleanly use user.getUserId() to maintain database synchronization */
            notifDao.markAllAsRead(user.getUserId());

            /* SUCCESS ROUTE: Return cleanly back into the populated user dashboard grid mapping */
            response.sendRedirect(request.getContextPath() + "/dashboard");

        } catch (Exception e) {
            /* Print precise line exceptions to our local development console window */
            System.out.println("Error processing state modifier update inside MarkNotificationsReadServlet.");
            e.printStackTrace();

            /* FAILURE ROUTE: If database connections time out, handle gracefully via catch parameters */
            response.sendRedirect(request.getContextPath() + "/login?error=DashboardLoadFailed");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        /* Route any unexpected client POST requests directly through standard GET logic */
        doGet(request, response);
    }
}