package com.HomeService.Filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Filter to protect the booking route.
 * If a guest tries to access /book, we store their intent and redirect to login.
 * Written manually - handles login wall for booking actions only.
 */
@WebFilter("/book")
public class LoginCheckFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // nothing to initialize
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest   = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        HttpSession session   = httpRequest.getSession(false);
        boolean isLoggedIn    = (session != null)
                && (session.getAttribute("loggedUser") != null
                 || session.getAttribute("userSession") != null);

        if (isLoggedIn) {
            // user is logged in, let the request through normally
            chain.doFilter(request, response);
        } else {
            // save what the user wanted to book so we can resume after login
            String serviceName = httpRequest.getParameter("serviceName");
            String price       = httpRequest.getParameter("price");

            HttpSession newSession = httpRequest.getSession(true);
            if (serviceName != null) {
                newSession.setAttribute("pendingServiceName", serviceName);
            }
            if (price != null) {
                newSession.setAttribute("pendingPrice", price);
            }

            // send them to login page
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
        }
    }

    @Override
    public void destroy() {
        // nothing to clean up
    }
}