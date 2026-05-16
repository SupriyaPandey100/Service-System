package com.HomeService.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import com.HomeService.dao.UserDAO; // Or ServiceDAO

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
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