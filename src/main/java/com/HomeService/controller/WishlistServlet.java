package com.HomeService.controller;

import java.io.IOException;
import java.util.List;

import com.HomeService.dao.WishlistDAO;
import com.HomeService.model.UserModel;
import com.HomeService.model.WishlistModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/wishlist")
public class WishlistServlet extends HttpServlet {
    private final WishlistDAO wishlistDao = new WishlistDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        UserModel user = (UserModel) session.getAttribute("loggedUser");
        String action = request.getParameter("action");

        // --- NEW CODE: Add Item Logic ---
        if ("add".equals(action)) {
            try {
                int serviceId = Integer.parseInt(request.getParameter("id"));
                // We need to add this method to your DAO if you haven't yet!
                wishlistDao.addItem(user.getUserId(), serviceId);

                // Redirect back to services page after adding
                response.sendRedirect(request.getContextPath() + "/services?msg=added");
                return;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        // --------------------------------

        if ("delete".equals(action)) {
            int wishlistId = Integer.parseInt(request.getParameter("id"));
            wishlistDao.removeItem(wishlistId);
            response.sendRedirect(request.getContextPath() + "/wishlist");
            return;
        }

        List<WishlistModel> wishlistItems = wishlistDao.getUserWishlist(user.getUserId());
        request.setAttribute("wishlistItems", wishlistItems);
        request.setAttribute("itemCount", wishlistItems.size());

        request.getRequestDispatcher("/WEB-INF/pages/wishlist.jsp").forward(request, response);
    }
}