package com.HomeService.controller;

import java.io.IOException;
import java.time.Year;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/services")
public class ServiceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public static class Service {
        private int id;
        private String name, category, description, imageUrl;
        private int price;

        // Cleaned up constructor
        public Service(int id, String name, String category, int price, String description, String imageUrl) {
            this.id          = id;
            this.name        = name;
            this.category    = category;
            this.price       = price;
            this.description = description;
            this.imageUrl    = imageUrl;
        }

        public int    getId()          { return id; }
        public String getName()        { return name; }
        public String getCategory()    { return category; }
        public int    getPrice()       { return price; }
        public String getDescription() { return description; }
        public String getImageUrl()    { return imageUrl; }
    }

    private List<Service> getAllServices() {
        List<Service> services = new ArrayList<>();

        // Cleaned up list matching the database perfectly
        services.add(new Service(1, "Plumbing Repairs",        "Plumbing",   1500, "Professional plumbing repair services for leaks, clogs, and pipe issues",            "images/plumbing.jpg"));
        services.add(new Service(2, "Electrical Installation","Electrical", 2000, "Licensed electricians for wiring, fixtures, and electrical installations",          "images/electrical.jpg"));
        services.add(new Service(3, "House Painting",          "Painting",   5000, "Interior and exterior painting with premium quality paints",                        "images/painting.jpg"));
        services.add(new Service(4, "Deep Cleaning",           "Cleaning",   3000, "Complete deep cleaning for your home",                                              "images/cleaning.jpg"));
        services.add(new Service(5, "AC Service & Repair",     "AC Repair",  1800, "Air conditioner servicing and maintenance",                                         "images/ac-repair.jpg"));
        services.add(new Service(6, "Custom Carpentry",        "Carpentry",  4000, "Custom furniture and woodwork solutions",                                           "images/carpentry.jpg"));
        services.add(new Service(7, "Kitchen Plumbing",        "Plumbing",   1800, "Sink and kitchen plumbing services",                                                "images/kitchen-plumbing.jpg"));
        services.add(new Service(8, "Appliance Repair",        "Electrical", 1200, "Repair services for home appliances",                                               "images/appliance-repair.jpg"));
        services.add(new Service(9, "Home Sanitization",       "Cleaning",   2000, "Full home sanitization and disinfection service for a healthy living environment",  "images/sanitization.jpg"));
        services.add(new Service(10, "Roof Repair",             "Carpentry",  6000, "Professional roof inspection, leak repair, and waterproofing services",             "images/roof-repair.jpg"));
        services.add(new Service(11, "Interior Design",         "Painting",   8000, "Complete interior design and room makeover service by expert designers",             "images/interior-design.jpg"));
        services.add(new Service(12, "Pest Control",            "Cleaning",   2500, "Complete home pest control and sanitization treatment",                              "images/pest-control.jpg"));

        return services;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            Object loggedUser  = session.getAttribute("loggedUser");
            Object userSession = session.getAttribute("userSession");
            if (loggedUser != null && userSession == null) {
				session.setAttribute("userSession", loggedUser);
			} else if (userSession != null && loggedUser == null) {
				session.setAttribute("loggedUser", userSession);
			}
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