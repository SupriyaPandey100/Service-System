package com.HomeService.controller;

import java.io.IOException;
import java.util.List;

import com.HomeService.dao.UserDAO;
import com.HomeService.model.UserModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/manageuser")
public class ManageUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            UserDAO dao = new UserDAO();
            List<UserModel> users = dao.getAllUsers();
            users.removeIf(u -> "ADMIN".equalsIgnoreCase(u.getRole()));
            request.setAttribute("users", users);
            request.getRequestDispatcher("/WEB-INF/pages/manageuser.jsp").forward(request, response);
        } catch (Exception e) { e.printStackTrace(); }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String action = request.getParameter("action");
            UserDAO dao = new UserDAO();

            if ("approve".equals(action)) {
				dao.updateUserStatus(id, "ACTIVE");
			} else if ("reject".equals(action)) {
				dao.updateUserStatus(id, "REJECTED");
			}

            response.sendRedirect("manageuser");
        } catch (Exception e) { e.printStackTrace(); }
    }
}