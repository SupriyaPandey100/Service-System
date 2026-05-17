package com.HomeService.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet("/about")
public class AboutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
     
        HttpSession session = request.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("userSession") != null);
        request.setAttribute("isLoggedIn", isLoggedIn);

        
        Cookie[] cookies = request.getCookies();
        
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("lastAboutVisit".equals(cookie.getName())) {
                   
                    break;
                }
            }
        }
        
       
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd_HH:mm:ss");
        String currentTime = LocalDateTime.now().format(dtf);
        Cookie visitCookie = new Cookie("lastAboutVisit", currentTime);
        visitCookie.setMaxAge(60 * 60 * 24 * 30); // 30 days
        visitCookie.setPath("/");
        response.addCookie(visitCookie);

     
        request.getRequestDispatcher("/WEB-INF/pages/about.jsp").forward(request, response);
    }
}