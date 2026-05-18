package com.HomeService.controller;

import com.HomeService.dao.UserDAO;
import com.HomeService.model.UserModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * ============================================================================
 * Controller: LoginServlet
 * URL Mapping: /login
 * Purpose: Manages user authentication routines, builds state verification 
 * session pools, and handles explicit multi-track landing redirects.
 * ============================================================================
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        /* Standard secure dispatch down to the login page template view */
        request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Retrieve raw form data values from the incoming request payload
        String email = request.getParameter("email");
        String pass = request.getParameter("password");

        // Simple validation check: Stop early if user submits empty fields
        if (email == null || pass == null || email.trim().isEmpty() || pass.trim().isEmpty()) {
            request.setAttribute("error", "Please enter both Email and Password.");
            request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
            return;
        }

        UserDAO dao = new UserDAO();
        
        try {
            // 2. Query the data storage tier via the Data Access Object pattern
            UserModel user = dao.getUserByEmail(email.trim());
            
            // Check if user credentials map out completely and match up with the database record
            if (user != null && user.getPassword().equals(pass)) {
                
                // Clear out any old session identities before instantiating a new tracking track window
                HttpSession oldSession = request.getSession(false);
                if (oldSession != null) {
                    oldSession.invalidate();
                }
                
                // Establish a completely fresh authenticated session layer context
                HttpSession session = request.getSession(true);
                
                /* ==============================================================================
                  SESSION ATTRIBUTE SYNCHRONIZATION
                  Populates both naming styles simultaneously so headers instantly read identification
                  ============================================================================== */
                session.setAttribute("loggedUser", user); 
                session.setAttribute("userSession", user); 
                
                /* ==============================================================================
                  BOUNCE-BACK CHECKOUT TRAFFIC ROUTING
                  If a quick-booking pipeline flag exists, skip the default layout workspace areas
                  ============================================================================== */
                if (session.getAttribute("pendingServiceName") != null) {
                    response.sendRedirect(request.getContextPath() + "/book");
                } else {
                    // Default Success Path: Direct absolute redirection down to your working dashboard route mapping
                    response.sendRedirect(request.getContextPath() + "/dashboard");
                }
                return; // Structural break to stop further compilation operations
                
            } else {
                // If credentials are bad, provide explicit screen warning variables
                request.setAttribute("error", "Invalid email address or password context.");
                request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            // Print the exact system file exceptions to your terminal track console logs for diagnostics
            System.out.println("CRITICAL ERROR: Login processing pipeline crashed inside UserDAO query execution.");
            e.printStackTrace();
            
            // Safe fallback response message block
            request.setAttribute("error", "An internal system connection error occurred. Please try again.");
            request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
        }
    }
}