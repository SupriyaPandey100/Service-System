package com.HomeService.filter;

import java.io.IOException;

import com.HomeService.model.UserModel;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

// IMPORTANT: Apply this filter to all admin-only pages
//Open AuthenticationFilter.java and update this line:
@WebFilter({"/admindashboard", "/manageBooking", "/manageuser", "/managetechnician"})
public class AuthenticationFilter extends HttpFilter implements Filter {


    private static final long serialVersionUID = 1L;

    @Override
    protected void doFilter(HttpServletRequest request,
                            HttpServletResponse response,
                            FilterChain chain)
            throws IOException, ServletException {

        HttpSession session = request.getSession(false);
        UserModel user = (session != null) ? (UserModel) session.getAttribute("userSession") : null;
        System.out.print(user);
        System.out.print(user.getRole());

        // If no session OR not an Admin, deny access
        if (user == null || !"ADMIN".equalsIgnoreCase(user.getRole())) {
            // Simply redirect to login without adding weird error parameters that might cause loops
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        chain.doFilter(request, response);
    }
}
