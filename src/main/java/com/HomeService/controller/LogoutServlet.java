package com.HomeService.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * LogoutServlet - Securely ends the user's session and redirects them.
 */
@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Fetch the current session. 
        // Passing 'false' ensures we don't accidentally create a NEW session just to destroy it.
        HttpSession session = request.getSession(false);
        
        // 2. If a session exists, completely wipe it out
        if (session != null) {
            session.invalidate(); 
        }
        
        // 3. Redirect the user back to the login page securely
        response.sendRedirect(request.getContextPath() + "/login?message=LoggedOut");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Just in case a form posts to /logout, route it to the same logic
        doGet(request, response);
    }
}