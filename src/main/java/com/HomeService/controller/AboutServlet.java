package com.HomeService.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/about")
public class AboutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            Object loggedUser  = session.getAttribute("loggedUser");
            Object userSession = session.getAttribute("userSession");
            if (loggedUser != null && userSession == null) {
                session.setAttribute("userSession", loggedUser);
            } else if (userSession != null && loggedUser == null) {
                session.setAttribute("loggedUser", userSession);
            }
        }

        boolean isLoggedIn = (session != null)
                && (session.getAttribute("loggedUser")  != null
                 || session.getAttribute("userSession") != null);

        request.setAttribute("isLoggedIn", isLoggedIn);
        request.getRequestDispatcher("/WEB-INF/pages/about.jsp").forward(request, response);
    }
}