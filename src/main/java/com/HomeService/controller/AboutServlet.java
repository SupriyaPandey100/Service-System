package com.HomeService.controller;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * Controller for the About Page.
 * Handles dynamic data population, Session verification, and Cookie management.
 */
@WebServlet("/about")
public class AboutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // ==========================================
        // 1. SESSION MANAGEMENT
        // ==========================================
        // Retrieve the current session, but do not create a new one if it doesn't exist
        HttpSession session = request.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("userSession") != null);
        
        // Pass a simple flag to the JSP using EL
        request.setAttribute("isLoggedIn", isLoggedIn);

        // ==========================================
        // 2. COOKIE MANAGEMENT
        // ==========================================
        // Look for a specific cookie that tracks the last time they visited the About page
        Cookie[] cookies = request.getCookies();
        String lastVisitDate = "This is your first time visiting our About page!";
        
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("lastAboutVisit".equals(cookie.getName())) {
                    // Replace the URL-safe underscore back to a space for readability
                    lastVisitDate = "Welcome back! You last visited us on: " + cookie.getValue().replace("_", " ");
                    break;
                }
            }
        }
        
        // Send the cookie message to the JSP
        request.setAttribute("cookieMessage", lastVisitDate);

        // Create a new cookie with the current date/time for their NEXT visit
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd_HH:mm");
        String currentTime = LocalDateTime.now().format(dtf);
        Cookie visitCookie = new Cookie("lastAboutVisit", currentTime);
        visitCookie.setMaxAge(60 * 60 * 24 * 30); // Cookie lasts for 30 days
        visitCookie.setPath("/"); // Available across the application
        response.addCookie(visitCookie);

        // ==========================================
        // 3. DYNAMIC DATA GENERATION
        // ==========================================
        // In a real application, you would fetch these from a Database DAO.
        // For this project, we simulate fetching dynamic business statistics.
        request.setAttribute("happyCustomers", "12,500");
        request.setAttribute("verifiedPros", "850");
        request.setAttribute("serviceCategories", "65");
        request.setAttribute("avgRating", "4.9");

        // Forward the request and dynamic attributes to the View (JSP)
        request.getRequestDispatcher("/WEB-INF/pages/about.jsp").forward(request, response);
    }
}