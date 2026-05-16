package com.HomeService.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.Year;
import java.util.*;
import java.util.stream.Collectors;

/**
 * Controller for the Services Page (MVC Architecture).
 * Handles Session verification, Cookie tracking, and Dynamic Data generation.
 */
@WebServlet("/services")
public class ServiceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public static class Service {
        private String name, category, duration, description, imageUrl;
        private int price, reviews;
        private double rating;
        
        public Service(String name, String category, int price, double rating, 
                      int reviews, String duration, String description, String imageUrl) {
            this.name = name;
            this.category = category;
            this.price = price;
            this.rating = rating;
            this.reviews = reviews;
            this.duration = duration;
            this.description = description;
            this.imageUrl = imageUrl;
        }
        
        // Getters required for JSP Expression Language (EL)
        public String getName() { return name; }
        public String getCategory() { return category; }
        public int getPrice() { return price; }
        public double getRating() { return rating; }
        public int getReviews() { return reviews; }
        public String getDuration() { return duration; }
        public String getDescription() { return description; }
        public String getImageUrl() { return imageUrl; }
    }
    
    // Simulating a Database Access Object (DAO) fetch
    private List<Service> getAllServices() {
        List<Service> services = new ArrayList<>();
        services.add(new Service("Plumbing Repair", "Plumbing", 1500, 4.8, 156, "2 hours", "Professional plumbing repair services for leaks, clogs, and pipes", "images/plumbing.jpg"));
        services.add(new Service("Electrical Installation", "Electrical", 2000, 4.9, 203, "3 hours", "Licensed electricians for wiring and installations", "images/electrical.jpg"));
        services.add(new Service("House Painting", "Painting", 5000, 4.7, 89, "1 day", "Interior and exterior painting with premium quality paints", "images/painting.jpg"));
        services.add(new Service("Deep Cleaning", "Cleaning", 3000, 4.9, 312, "4 hours", "Comprehensive deep cleaning service for your entire home", "images/cleaning.jpg"));
        services.add(new Service("Pest Control", "Cleaning", 2500, 0.0, 0, "2 hours", "Complete home pest control and sanitization", "images/pest-control.jpg"));
        return services;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. SESSION MANAGEMENT & SYNCHRONIZATION
        HttpSession session = request.getSession(false);
        if (session != null) {
            Object loggedUser = session.getAttribute("loggedUser");
            Object userSession = session.getAttribute("userSession");
            
            // Sync session keys so headers can read the user profile seamlessly
            if (loggedUser != null && userSession == null) {
                session.setAttribute("userSession", loggedUser);
            } else if (userSession != null && loggedUser == null) {
                session.setAttribute("loggedUser", userSession);
            }
        }
        
        // 2. FETCH & FILTER DYNAMIC DATA
        String categoryFilter = request.getParameter("category");
        String searchQuery = request.getParameter("search");
        List<Service> allServices = getAllServices();
        List<Service> filteredServices = allServices;
        
        if (categoryFilter != null && !categoryFilter.isEmpty() && !categoryFilter.equals("all")) {
            filteredServices = allServices.stream()
                .filter(service -> service.getCategory().equalsIgnoreCase(categoryFilter))
                .collect(Collectors.toList());
        }
        
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            String searchLower = searchQuery.toLowerCase().trim();
            filteredServices = filteredServices.stream()
                .filter(service -> 
                    service.getName().toLowerCase().contains(searchLower) ||
                    service.getDescription().toLowerCase().contains(searchLower) ||
                    service.getCategory().toLowerCase().contains(searchLower))
                .collect(Collectors.toList());
        }

        // Dynamically extract unique categories for the tabs
        List<String> dynamicCategories = allServices.stream()
                .map(Service::getCategory)
                .distinct()
                .collect(Collectors.toList());

        // 3. COOKIE MANAGEMENT
        Cookie[] cookies = request.getCookies();
        String lastCategory = null;
        if (cookies != null) {
            for (Cookie c : cookies) {
                if ("lastSearchedCategory".equals(c.getName())) {
                    lastCategory = c.getValue();
                }
            }
        }
        
        if (categoryFilter != null && !categoryFilter.equals("all")) {
            Cookie categoryCookie = new Cookie("lastSearchedCategory", categoryFilter);
            categoryCookie.setMaxAge(60 * 60 * 24 * 7); 
            categoryCookie.setPath("/");
            response.addCookie(categoryCookie);
        }

        // 4. SET ATTRIBUTES FOR JSP
        request.setAttribute("serviceList", filteredServices);
        request.setAttribute("dynamicCategories", dynamicCategories);
        request.setAttribute("selectedCategory", categoryFilter != null ? categoryFilter : "all");
        request.setAttribute("searchQuery", searchQuery != null ? searchQuery : "");
        request.setAttribute("suggestedCategory", lastCategory);
        request.setAttribute("currentYear", Year.now().getValue()); 
        
        request.getRequestDispatcher("/WEB-INF/pages/services.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}