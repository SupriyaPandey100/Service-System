package com.HomeService.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/book")
public class BookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(true);
        
        // 1. SESSION ATTRIBUTE SYNCHRONIZATION
        // Guarantees both tracking conventions match, keeping header components functional
        Object loggedUser = session.getAttribute("loggedUser");
        Object userSession = session.getAttribute("userSession");
        
        if (loggedUser != null && userSession == null) {
            session.setAttribute("userSession", loggedUser);
        } else if (userSession != null && loggedUser == null) {
            session.setAttribute("loggedUser", userSession);
        }

        // 2. CAPTURE DATA FROM SELECTION INTENT
        String serviceName = request.getParameter("serviceName");
        String price = request.getParameter("price");
        
        if (serviceName != null && !serviceName.trim().isEmpty()) {
            session.setAttribute("pendingServiceName", serviceName);
            session.setAttribute("pendingPrice", price);
        }

        // 3. INTERCEPT GUESTS: Force authentication checkpoint
        if (session.getAttribute("loggedUser") == null) {
            request.setAttribute("error", "Please sign in to your account to complete your booking.");
            request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
            return;
        }

        // 4. FALLBACK REDIRECTION
        // If a logged-in user accesses /book directly without selecting a card asset
        if (session.getAttribute("pendingServiceName") == null) {
            response.sendRedirect(request.getContextPath() + "/services");
            return;
        }

        // AUTHORIZED USERS: Render input template form
        request.getRequestDispatcher("/WEB-INF/pages/booking_form.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || (session.getAttribute("loggedUser") == null && session.getAttribute("userSession") == null)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Extract processing payload data from incoming intake form fields
        String address = request.getParameter("address");
        String bookingDate = request.getParameter("bookingDate");
        String bookingTime = request.getParameter("bookingTime");
        String instructions = request.getParameter("instructions");
        String serviceName = (String) session.getAttribute("pendingServiceName");
        
        // Note: Invoke your transactional persistence mapping here 
        // e.g., bookingDAO.createBooking(..., serviceName, bookingDate, address);

        // State lifecycle cleanup: Flush staging variables out of session tracking context memory
        session.removeAttribute("pendingServiceName");
        session.removeAttribute("pendingPrice");

        // Forward safely directly to the user record history view mapping controller
        response.sendRedirect(request.getContextPath() + "/bookings");
    }
}