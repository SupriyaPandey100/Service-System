package com.HomeService.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/index")
public class IndexServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // --- 1. DIAGNOSTIC TEST ---
        // If you see this in your Eclipse Console, Tomcat has successfully found this Servlet!
        System.out.println(">>> SUCCESS: IndexServlet is running! <<<");

        // --- 2. ADVANCED COURSEWORK LOGIC: Cookie Management ---
        // Check if the user previously clicked "Remember Me" on the login page
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("userEmail".equals(cookie.getName())) {
                    // Send this data to the JSP so Expression Language (EL) can use it
                    request.setAttribute("rememberedEmail", cookie.getValue());
                }
            }
        }

        // --- 3. MVC FORWARDING ---
        // Forwards to the physical JSP file.
        // CRITICAL: This assumes your index.jsp is located directly inside the src/main/webapp/ folder.
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}