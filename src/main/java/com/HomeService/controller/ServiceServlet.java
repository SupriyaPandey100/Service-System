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

@WebServlet("/services")
public class ServiceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public static class Service {
        private String name, category, duration, description, imageUrl;
        private int price, reviews;
        private double rating;

        public Service(String name, String category, int price, double rating,
                       int reviews, String duration, String description, String imageUrl) {
            this.name        = name;
            this.category    = category;
            this.price       = price;
            this.rating      = rating;
            this.reviews     = reviews;
            this.duration    = duration;
            this.description = description;
            this.imageUrl    = imageUrl;
        }

        public String getName()        { return name; }
        public String getCategory()    { return category; }
        public int    getPrice()       { return price; }
        public double getRating()      { return rating; }
        public int    getReviews()     { return reviews; }
        public String getDuration()    { return duration; }
        public String getDescription() { return description; }
        public String getImageUrl()    { return imageUrl; }
    }
    private List<Service> getAllServices() {
        List<Service> services = new ArrayList<>();

        services.add(new Service("Plumbing Repairs",       "Plumbing",   1500, 4.8, 156, "2 hours", "Professional plumbing repair services for leaks, clogs, and pipe issues",           "images/plumbing.jpg"));
        services.add(new Service("Electrical Installation","Electrical", 2000, 4.9, 208, "3 hours", "Licensed electricians for wiring, fixtures, and electrical installations",          "images/electrical.jpg"));
        services.add(new Service("House Painting",         "Painting",   5000, 4.8, 199, "1 day",   "Interior and exterior painting with premium quality paints",                        "images/painting.jpg"));
        services.add(new Service("Deep Cleaning",          "Cleaning",   3000, 4.7, 122, "4 hours", "Complete deep cleaning for your home",                                              "images/cleaning.jpg"));
        services.add(new Service("AC Service & Repair",    "AC Repair",  1800, 4.9, 187, "2 hours", "Air conditioner servicing and maintenance",                                         "images/ac-repair.jpg"));
        services.add(new Service("Custom Carpentry",       "Carpentry",  4000, 4.8, 145, "1 day",   "Custom furniture and woodwork solutions",                                           "images/carpentry.jpg"));
        services.add(new Service("Kitchen Plumbing",       "Plumbing",   1800, 4.7, 111, "2 hours", "Sink and kitchen plumbing services",                                               "images/kitchen-plumbing.jpg"));
        services.add(new Service("Appliance Repair",       "Electrical", 1200, 4.8, 124, "1 hour",  "Repair services for home appliances",                                              "images/appliance-repair.jpg"));
        services.add(new Service("Home Sanitization",      "Cleaning",   2000, 4.8, 143, "3 hours", "Full home sanitization and disinfection service for a healthy living environment",  "images/sanitization.jpg"));
        services.add(new Service("Roof Repair",            "Carpentry",  6000, 4.5,  41, "1 day",   "Professional roof inspection, leak repair, and waterproofing services",             "images/roof-repair.jpg"));
        services.add(new Service("Interior Design",        "Painting",   8000, 4.9,  57, "2 days",  "Complete interior design and room makeover service by expert designers",            "images/interior-design.jpg"));
        services.add(new Service("Pest Control",           "Cleaning",   2500, 4.6,  74, "2 hours", "Complete home pest control and sanitization treatment",                             "images/pest-control.jpg"));

        return services;
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            Object loggedUser  = session.getAttribute("loggedUser");
            Object userSession = session.getAttribute("userSession");
            if (loggedUser != null && userSession == null) session.setAttribute("userSession", loggedUser);
            else if (userSession != null && loggedUser == null) session.setAttribute("loggedUser", userSession);
        }

        String categoryFilter = request.getParameter("category");
        String searchQuery    = request.getParameter("search");
        List<Service> allServices      = getAllServices();
        List<Service> filteredServices = allServices;

        if (categoryFilter != null && !categoryFilter.isEmpty() && !categoryFilter.equals("all")) {
            filteredServices = allServices.stream()
                .filter(s -> s.getCategory().equalsIgnoreCase(categoryFilter))
                .collect(Collectors.toList());
        }

        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            String q = searchQuery.toLowerCase().trim();
            filteredServices = filteredServices.stream()
                .filter(s -> s.getName().toLowerCase().contains(q)
                          || s.getDescription().toLowerCase().contains(q)
                          || s.getCategory().toLowerCase().contains(q))
                .collect(Collectors.toList());
        }

        List<String> dynamicCategories = allServices.stream()
            .map(Service::getCategory)
            .distinct()
            .collect(Collectors.toList());

        Cookie[] cookies     = request.getCookies();
        String lastCategory  = null;
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

        request.setAttribute("serviceList",        filteredServices);
        request.setAttribute("dynamicCategories",  dynamicCategories);
        request.setAttribute("selectedCategory",   categoryFilter != null ? categoryFilter : "all");
        request.setAttribute("searchQuery",        searchQuery != null ? searchQuery : "");
        request.setAttribute("suggestedCategory",  lastCategory);
        request.setAttribute("currentYear",        Year.now().getValue());

        request.getRequestDispatcher("/WEB-INF/pages/services.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}