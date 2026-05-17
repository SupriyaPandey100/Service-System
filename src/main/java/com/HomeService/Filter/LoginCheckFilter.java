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


 
@WebFilter("/book")
public class LoginCheckFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest  httpRequest  = (HttpServletRequest)  request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        HttpSession session  = httpRequest.getSession(false);
        boolean isLoggedIn   = (session != null)
                && (session.getAttribute("loggedUser")  != null
                 || session.getAttribute("userSession") != null);

        if (isLoggedIn) {
           
            chain.doFilter(request, response);
        } else {
           
            String serviceName  = httpRequest.getParameter("serviceName");
            String price        = httpRequest.getParameter("price");
            String category     = httpRequest.getParameter("category");

            HttpSession newSession = httpRequest.getSession(true);
            if (serviceName != null) newSession.setAttribute("pendingServiceName",     serviceName);
            if (price       != null) newSession.setAttribute("pendingPrice",           price);
            if (category    != null) newSession.setAttribute("pendingServiceCategory", category);

            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
        }
    }

    @Override
    public void destroy() {
   
    }
}