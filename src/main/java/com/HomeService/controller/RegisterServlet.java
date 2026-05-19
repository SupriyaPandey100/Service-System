package com.HomeService.controller;

import java.io.IOException;
import java.sql.SQLException;

import com.HomeService.dao.UserDAO;
import com.HomeService.model.UserModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
    }

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirmPassword");

        // 1. Password Validation
        if (password == null || !password.equals(confirm)) {
            request.setAttribute("error", "Passwords do not match!");
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
            return;
        }

        UserDAO dao = new UserDAO();
        try {
            // 2. Pro-Tip: Check if User already exists to avoid SQL errors
            if (dao.getUserByEmail(email) != null) {
                request.setAttribute("error", "An account with this email already exists.");
                request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
                return;
            }

            // 3. Populate Model
            UserModel newUser = new UserModel();
            newUser.setFullName(name);
            newUser.setEmail(email);
            newUser.setPhone(phone);
            newUser.setPassword(password);
            newUser.setRole("USER");
            newUser.setStatus("ACTIVE");

            // 4. Save to Database
            dao.insertUser(newUser);

            // Redirect to login with a success message
            response.sendRedirect(request.getContextPath() + "/login?msg=RegistrationSuccess");

        } catch (SQLException e) {
            e.printStackTrace();
            // TEMPORARY FIX: Show the exact error on the screen
            request.setAttribute("error", "DB Error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
        }
    }
}