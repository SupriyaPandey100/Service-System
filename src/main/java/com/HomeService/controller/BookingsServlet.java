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


@WebServlet("/bookings")
public class BookingsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            (session.getAttribute("loggedUser") == null && session.getAttribute("userSession") == null)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

    
        UserModel user = (UserModel) session.getAttribute("loggedUser");
        if (user == null) user = (UserModel) session.getAttribute("userSession");

       
        String statusFilter = request.getParameter("status");
        if (statusFilter == null || statusFilter.trim().isEmpty()) {
            statusFilter = "All";
        }

        BookingDAO dao = new BookingDAO();
        List<BookingModel> bookings = dao.getUserBookings(user.getId(), statusFilter);
        Map<String, Integer> counts = dao.getBookingCounts(user.getId());
  String successMessage = (String) session.getAttribute("successMessage");
        String errorMessage   = (String) session.getAttribute("errorMessage");

        if (successMessage != null) {
            request.setAttribute("successMessage", successMessage);
            session.removeAttribute("successMessage");
        }
if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
            session.removeAttribute("errorMessage");
        }

        request.setAttribute("userBookings", bookings);
        request.setAttribute("bookingCounts", counts);
        request.setAttribute("currentStatus", statusFilter);
request.getRequestDispatcher("/WEB-INF/pages/bookings.jsp").forward(request, response);
    }
}