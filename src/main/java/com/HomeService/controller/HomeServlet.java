package com.HomeService.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // SESSION AUTHENTICATION: Prevent unauthorized access to the services page
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userSession") == null) {
            response.sendRedirect("login");
            return;
        }

        // DYNAMIC DATA: Fetching list from DAO (Model) to avoid static pages
        // request.setAttribute("serviceList", new ServiceDAO().getAllServices());

        request.getRequestDispatcher("/WEB-INF/pages/home.jsp").forward(request, response);
    }
}