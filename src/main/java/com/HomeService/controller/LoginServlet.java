package com.HomeService.controller;

import com.HomeService.dao.UserDAO;
import com.HomeService.model.UserModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String pass = request.getParameter("password");

        UserDAO dao = new UserDAO();
        try {
            UserModel user = dao.getUserByEmail(email);
            if (user != null && user.getPassword().equals(pass)) {
                HttpSession session = request.getSession();
                
                // 1. SESSION ATTRIBUTE SYNCHRONIZATION
                // Populates both naming conventions simultaneously so headers instantly register identity state
                session.setAttribute("loggedUser", user); 
                session.setAttribute("userSession", user); 
                
                // 2. BOUNCE-BACK CHECKOUT TRAFFIC ROUTING
                // If a pending intent flag exists, bypass the dashboard area entirely
                if (session.getAttribute("pendingServiceName") != null) {
                    response.sendRedirect(request.getContextPath() + "/book");
                } else {
                    // Standard routing fallback behavior
                    response.sendRedirect(request.getContextPath() + "/dashboard");
                }
                
            } else {
                request.setAttribute("error", "Invalid Credentials.");
                request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Database error.");
            request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
        }
    }
}