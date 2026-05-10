package com.HomeService.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.service_hub.model.UserModel;
import com.service_hub.service.LoginService;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/login.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        LoginService service = new LoginService();
        UserModel loggedInUser = null;

        try {
            // Authenticate user via service layer
            loggedInUser = service.authenticate(email, password);
            
            // Create session and store user object
            HttpSession session = request.getSession();
            session.setAttribute("userSession", loggedInUser);
            
            // ROLE-BASED ROUTING
            if ("ADMIN".equalsIgnoreCase(loggedInUser.getRole())) {
                // IMPORTANT: Use Forward for files inside WEB-INF to avoid 404 errors
                request.getRequestDispatcher("/WEB-INF/pages/admin-dashboard.jsp").forward(request, response);
            } else {
                // Redirect to the /dashboard servlet mapping for regular users
                response.sendRedirect(request.getContextPath() + "/dashboard");
            }

        } catch (Exception e) {
            // Catches "Invalid credentials" or "Account Pending" messages from LoginService
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
        }
    }
}