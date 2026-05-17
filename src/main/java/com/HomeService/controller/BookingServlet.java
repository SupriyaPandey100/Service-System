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

@WebServlet("/book")
public class BookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(true);

        
        Object loggedUser  = session.getAttribute("loggedUser");
        Object userSession = session.getAttribute("userSession");
        if (loggedUser != null && userSession == null) session.setAttribute("userSession", loggedUser);
        else if (userSession != null && loggedUser == null) session.setAttribute("loggedUser", userSession);

        
        String serviceName = request.getParameter("serviceName");
        String price       = request.getParameter("price");
        String serviceId   = request.getParameter("serviceId");

        if (serviceName != null && !serviceName.trim().isEmpty()) {
            session.setAttribute("pendingServiceName", serviceName);
            session.setAttribute("pendingPrice", price);
            session.setAttribute("pendingServiceId", serviceId != null ? serviceId : "0");
        }

        
        if (session.getAttribute("loggedUser") == null && session.getAttribute("userSession") == null) {
            session.setAttribute("redirectAfterLogin", request.getContextPath() + "/book");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        
        if (session.getAttribute("pendingServiceName") == null) {
            response.sendRedirect(request.getContextPath() + "/services");
            return;
        }

        
        request.getRequestDispatcher("/WEB-INF/pages/booking_form.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            (session.getAttribute("loggedUser") == null && session.getAttribute("userSession") == null)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        UserModel user = (UserModel) session.getAttribute("loggedUser");
        if (user == null) user = (UserModel) session.getAttribute("userSession");

        String serviceName  = (String) session.getAttribute("pendingServiceName");
        String priceStr     = (String) session.getAttribute("pendingPrice");
        String serviceIdStr = (String) session.getAttribute("pendingServiceId");

       
        String customerPhone   = request.getParameter("customerPhone");
        String preferredDate   = request.getParameter("preferredDate");
        String preferredTime   = request.getParameter("preferredTime");
        String serviceAddress  = request.getParameter("serviceAddress");
        String additionalNotes = request.getParameter("additionalNotes");

        double price = 0;
        try {
            if (priceStr != null && !priceStr.isEmpty()) {
                price = Double.parseDouble(priceStr);
            }
        } catch (NumberFormatException e) {
            price = 0;
        }

        int serviceId = 0;
        try {
            if (serviceIdStr != null && !serviceIdStr.isEmpty()) {
                serviceId = Integer.parseInt(serviceIdStr);
            }
        } catch (NumberFormatException e) {
            serviceId = 0;
        }

       
        BookingModel booking = new BookingModel();
        booking.setUserId(user.getId());
        booking.setServiceId(serviceId);
        booking.setServiceName(serviceName);
        booking.setServicePrice(price);
        booking.setCustomerName(user.getFullName());
        booking.setCustomerPhone(customerPhone);
        booking.setPreferredDate(preferredDate);
        booking.setPreferredTime(preferredTime);
        booking.setServiceAddress(serviceAddress);
        booking.setAdditionalNotes(additionalNotes);
        booking.setTotalAmount(price);
      
        BookingDAO dao = new BookingDAO();
        boolean saved = dao.createBooking(booking);

       
        session.removeAttribute("pendingServiceName");
        session.removeAttribute("pendingPrice");
        session.removeAttribute("pendingServiceId");
        session.removeAttribute("redirectAfterLogin");

        
        if (saved) {
            session.setAttribute("successMessage",
                "Your booking for " + serviceName + " has been placed successfully! We will confirm it shortly.");
        } else {
            session.setAttribute("errorMessage",
                "Something went wrong while saving your booking. Please try again.");
        }

       
        response.sendRedirect(request.getContextPath() + "/bookings");
    }
}