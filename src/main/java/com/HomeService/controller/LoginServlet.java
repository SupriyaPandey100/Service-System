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

                // 1. Set both session keys so all headers and pages read the user correctly
                session.setAttribute("loggedUser", user);
                session.setAttribute("userSession", user);

                // 2. Check if there is a redirect saved from before login
                //    This is set by BookingServlet when a guest tries to book
                String redirectUrl = (String) session.getAttribute("redirectAfterLogin");

                if (redirectUrl != null && !redirectUrl.isEmpty()) {
                    // Clear the redirect flag so it does not loop
                    session.removeAttribute("redirectAfterLogin");
                    // Go back to /book - BookingServlet will see pendingServiceName
                    // in session and forward straight to booking_form.jsp
                    response.sendRedirect(redirectUrl);

                } else if (session.getAttribute("pendingServiceName") != null) {
                    // Old flow fallback - still works if pendingServiceName is set
                    response.sendRedirect(request.getContextPath() + "/book");

                } else {
                    // Normal login - go to dashboard
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