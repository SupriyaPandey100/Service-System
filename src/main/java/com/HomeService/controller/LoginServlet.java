package com.HomeService.controller;

import java.io.IOException;

import com.HomeService.dao.UserDAO;
import com.HomeService.model.UserModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String pass = request.getParameter("password");

        try {
            UserDAO dao = new UserDAO();
            UserModel user = dao.getUserByEmail(email != null ? email.trim() : "");

            if (user != null && user.getPassword().equals(pass)) {

                // ROBUST STATUS CHECK: Trim whitespace to ensure accuracy against database values
                String status = (user.getStatus() != null) ? user.getStatus().trim() : "";

                if (!"ACTIVE".equalsIgnoreCase(status)) {
                    request.setAttribute("error", "Your account is pending approval or has been rejected.");
                    request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
                    return;
                }
             // Inside your LoginServlet.java -> doPost()
                HttpSession session = request.getSession(true);
                session.setAttribute("userSession", user);

                /* UserDashboardServlet*/
                session.setAttribute("loggedUser", user);

                // Route based on role
                if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                    response.sendRedirect("admindashboard");
                } else {
                    response.sendRedirect("dashboard");
                }


            } else {
                request.setAttribute("error", "Invalid credentials.");
                request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "System error occurred.");
            request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
        }
    }
}