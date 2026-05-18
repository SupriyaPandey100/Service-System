package com.HomeService.controller;

import java.io.IOException;

import com.HomeService.dao.UserDAO;
import com.HomeService.model.UserModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is already logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("userSession") != null) {
            UserModel user = (UserModel) session.getAttribute("userSession");
            
            // Redirect based on role if already logged in
            if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/admindashboard");
            } else if ("TECHNICIAN".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/technician/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
            return;
        }

        request.getRequestDispatcher("/WEB-INF/pages/login.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Input validation
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Please enter both email and password");
            request.getRequestDispatcher("/WEB-INF/pages/login.jsp")
                   .forward(request, response);
            return;
        }

        try {
            UserDAO userDAO = new UserDAO();
            UserModel user = userDAO.getUserByEmail(email);

            // Check if user exists and password matches
            if (user != null && user.getPassword().equals(password)) {
                
                // Check if account is active
                if (!"active".equalsIgnoreCase(user.getStatus()) && !"ACTIVE".equalsIgnoreCase(user.getStatus())) {
                    request.setAttribute("error", "Your account is pending approval. Please wait for admin approval.");
                    request.getRequestDispatcher("/WEB-INF/pages/login.jsp")
                           .forward(request, response);
                    return;
                }

                // Create session
                HttpSession session = request.getSession();
                session.setAttribute("userSession", user);
                session.setAttribute("userId", user.getUserId());
                session.setAttribute("userName", user.getFullName());
                session.setAttribute("userRole", user.getRole());
                session.setMaxInactiveInterval(30 * 60); // 30 minutes

                // Set cookie for remember me functionality
                Cookie userCookie = new Cookie("userEmail", user.getEmail());
                userCookie.setMaxAge(60 * 60 * 24 * 7); // 7 days
                userCookie.setPath(request.getContextPath());
                response.addCookie(userCookie);

                // Redirect based on role
                String role = user.getRole();
                System.out.println("Login successful - User: " + user.getEmail() + ", Role: " + role);

                if ("ADMIN".equalsIgnoreCase(role)) {
                    response.sendRedirect(request.getContextPath() + "/admindashboard");
                } else if ("TECHNICIAN".equalsIgnoreCase(role)) {
                    response.sendRedirect(request.getContextPath() + "/technician/dashboard");
                } else {
                    // Regular customer
                    response.sendRedirect(request.getContextPath() + "/home");
                }

            } else {
                request.setAttribute("error", "Invalid email or password");
                request.getRequestDispatcher("/WEB-INF/pages/login.jsp")
                       .forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Login failed: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/pages/login.jsp")
                   .forward(request, response);
        }
    }
}