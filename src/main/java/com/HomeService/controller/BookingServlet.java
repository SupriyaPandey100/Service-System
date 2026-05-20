package com.HomeService.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.HomeService.dao.BookingDAO;
import com.HomeService.model.BookingModel;
import com.HomeService.model.UserModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * ============================================================================
 * Controller: BookingServlet
 * URL Mappings: /book & /bookings
 * Purpose: Captures appointment scheduling requests and handles secure routing.
 * ============================================================================
 */
@WebServlet(urlPatterns = {"/book", "/bookings"})
public class BookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(true);

        Object loggedUser = session.getAttribute("loggedUser");
        Object userSession = session.getAttribute("userSession");

        if (loggedUser != null && userSession == null) {
            session.setAttribute("userSession", loggedUser);
        } else if (userSession != null && loggedUser == null) {
            session.setAttribute("loggedUser", userSession);
        }

        if (session.getAttribute("loggedUser") == null) {
            request.setAttribute("error", "Please sign in to your account to continue.");
            request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
            return;
        }

        UserModel user = (UserModel) session.getAttribute("loggedUser");
        String servletPath = request.getServletPath();

        if ("/bookings".equals(servletPath)) {
            try {
                BookingDAO bookingDAO = new BookingDAO();
                String statusFilter = request.getParameter("status");

                if (statusFilter == null || statusFilter.trim().isEmpty()) {
                    statusFilter = "All";
                }

                /* Compiles flawlessly with zero red markers because user matches getUserId() signature */
                List<BookingModel> bookingsList = bookingDAO.getUserBookings(user.getUserId(), statusFilter);
                Map<String, Integer> counts = bookingDAO.getBookingCounts(user.getUserId());

                request.setAttribute("bookingsList", bookingsList);
                request.setAttribute("currentStatus", statusFilter);
                request.setAttribute("counts", counts);

                request.getRequestDispatcher("/WEB-INF/pages/bookings.jsp").forward(request, response);
                return;

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/login?error=DashboardLoadFailed");
                return;
            }
        }

        if ("/book".equals(servletPath)) {
            String serviceName = request.getParameter("serviceName");
            String price = request.getParameter("price");

            if (serviceName != null && !serviceName.trim().isEmpty()) {
                session.setAttribute("pendingServiceName", serviceName);
                session.setAttribute("pendingPrice", price);
            }

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

        if ("/book".equals(servletPath)) {
            try {
                String address = request.getParameter("address");
                String bookingDate = request.getParameter("bookingDate");
                String bookingTime = request.getParameter("bookingTime");
                String instructions = request.getParameter("instructions");

                String serviceName = (String) session.getAttribute("pendingServiceName");
                String priceStr = (String) session.getAttribute("pendingPrice");

                int price = 0;
                if (priceStr != null) {
                    try {
                        price = Integer.parseInt(priceStr.replaceAll("[^0-9]", ""));
                    } catch (NumberFormatException e) {
                        System.out.println("Warning: Error parsing price formatting string.");
                    }
                }

                BookingDAO bookingDAO = new BookingDAO();

                boolean isSaved = bookingDAO.saveBooking(
                    user.getUserId(),
                    serviceName,
                    price,
                    address,
                    bookingDate,
                    bookingTime,
                    instructions
                );

                if (isSaved) {
                    session.removeAttribute("pendingServiceName");
                    session.removeAttribute("pendingPrice");
                    response.sendRedirect(request.getContextPath() + "/bookings?status=Pending&success=true");
                } else {
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