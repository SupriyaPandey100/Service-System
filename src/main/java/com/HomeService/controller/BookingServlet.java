package com.HomeService.controller;

import com.HomeService.dao.BookingDAO;
import com.HomeService.model.BookingModel;
import com.HomeService.model.UserModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(urlPatterns = {"/book", "/bookings"})
public class BookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(true);
        
        // 1. SESSION ATTRIBUTE SYNCHRONIZATION
        Object loggedUser = session.getAttribute("loggedUser");
        Object userSession = session.getAttribute("userSession");
        
        if (loggedUser != null && userSession == null) {
            session.setAttribute("userSession", loggedUser);
        } else if (userSession != null && loggedUser == null) {
            session.setAttribute("loggedUser", userSession);
        }

        // 2. SECURITY INTERCEPT
        if (session.getAttribute("loggedUser") == null) {
            request.setAttribute("error", "Please sign in to your account to continue.");
            request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
            return;
        }

        UserModel user = (UserModel) session.getAttribute("loggedUser");
        String servletPath = request.getServletPath();

        // ==========================================================================
        // ROUTE A: MY BOOKINGS DASHBOARD (/bookings)
        // ==========================================================================
        if ("/bookings".equals(servletPath)) {
            BookingDAO bookingDAO = new BookingDAO();
            String statusFilter = request.getParameter("status");
            if (statusFilter == null || statusFilter.trim().isEmpty()) {
                statusFilter = "All";
            }
            
            // NOTE: If your UserModel uses getUserId() instead of getId(), change it here!
            List<BookingModel> bookingsList = bookingDAO.getUserBookings(user.getId(), statusFilter);
            Map<String, Integer> counts = bookingDAO.getBookingCounts(user.getId());
            
            // Pass the exact variable names your booking.jsp file is looking for
            request.setAttribute("bookingsList", bookingsList);
            request.setAttribute("currentStatus", statusFilter);
            request.setAttribute("counts", counts);
            
            // Forward safely to the JSP 
            request.getRequestDispatcher("/WEB-INF/pages/bookings.jsp").forward(request, response);
            return; 
        }

        // ==========================================================================
        // ROUTE B: CHECKOUT FORM (/book)
        // ==========================================================================
        if ("/book".equals(servletPath)) {
            String serviceName = request.getParameter("serviceName");
            String price = request.getParameter("price");
            
            if (serviceName != null && !serviceName.trim().isEmpty()) {
                session.setAttribute("pendingServiceName", serviceName);
                session.setAttribute("pendingPrice", price);
            }

            // Fallback: If they go to /book without a service, send to /services
            if (session.getAttribute("pendingServiceName") == null) {
                response.sendRedirect(request.getContextPath() + "/services");
                return;
            }

            request.getRequestDispatcher("/WEB-INF/pages/booking_form.jsp").forward(request, response);
            return;
        }
        
        response.sendRedirect(request.getContextPath() + "/dashboard");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        UserModel user = (UserModel) session.getAttribute("loggedUser");
        String servletPath = request.getServletPath();

        // ONLY process the data if it came from the checkout form
        if ("/book".equals(servletPath)) {
            try {
                // 1. Grab inputs from the checkout form
                String address = request.getParameter("address");
                String bookingDate = request.getParameter("bookingDate");
                String bookingTime = request.getParameter("bookingTime");
                String instructions = request.getParameter("instructions");
                
                // 2. Grab the hidden service details from the session
                String serviceName = (String) session.getAttribute("pendingServiceName");
                String priceStr = (String) session.getAttribute("pendingPrice");
                
                // 3. Safely extract the number from "NPR 1500" or similar string
                int price = 0;
                if (priceStr != null) {
                    try {
                        price = Integer.parseInt(priceStr.replaceAll("[^0-9]", ""));
                    } catch (NumberFormatException e) {
                        System.out.println("Error parsing price: " + priceStr);
                    }
                }
                
                // 4. Save to Database!
                BookingDAO bookingDAO = new BookingDAO();
                // NOTE: If your UserModel uses getUserId() instead of getId(), change it here!
                boolean isSaved = bookingDAO.saveBooking(
                    user.getId(), 
                    serviceName, 
                    price, 
                    address, 
                    bookingDate, 
                    bookingTime, 
                    instructions
                );
                
                if (isSaved) {
                    // Success! Clear the temporary session data
                    session.removeAttribute("pendingServiceName");
                    session.removeAttribute("pendingPrice");
                    
                    // Send them straight to the "Pending" tab on their dashboard
                    response.sendRedirect(request.getContextPath() + "/bookings?status=Pending&success=true");
                } else {
                    System.out.println("DATABASE ERROR: Failed to insert booking.");
                    response.sendRedirect(request.getContextPath() + "/services?error=db_fail");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/services?error=exception");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/bookings");
        }
    }
}