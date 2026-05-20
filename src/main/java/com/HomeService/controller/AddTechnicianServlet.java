package com.HomeService.controller;

import java.io.IOException;

import com.HomeService.dao.TechnicianDAO;
import com.HomeService.model.TechnicianModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/addtechnician")
public class AddTechnicianServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userSession") == null) {
            response.sendRedirect("login");
            return;
        }

        request.getRequestDispatcher("/WEB-INF/pages/addtechnician.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("full_name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String services = request.getParameter("services");
        String jobsStr = request.getParameter("completed_jobs");
        String status = request.getParameter("status");

        if (name == null || name.trim().isEmpty() || name.length() < 2) {
            request.setAttribute("error", "Name must be at least 2 characters");
            request.setAttribute("full_name", name);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("services", services);
            request.setAttribute("completed_jobs", jobsStr);
            request.setAttribute("status", status);
            request.getRequestDispatcher("/WEB-INF/pages/addtechnician.jsp")
                   .forward(request, response);
            return;
        }

        if (email == null || !email.contains("@") || !email.contains(".")) {
            request.setAttribute("error", "Please enter a valid email address");
            request.setAttribute("full_name", name);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("services", services);
            request.setAttribute("completed_jobs", jobsStr);
            request.setAttribute("status", status);
            request.getRequestDispatcher("/WEB-INF/pages/addtechnician.jsp")
                   .forward(request, response);
            return;
        }

        if (phone == null || phone.length() != 10) {
            request.setAttribute("error", "Phone number must be 10 digits");
            request.setAttribute("full_name", name);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("services", services);
            request.setAttribute("completed_jobs", jobsStr);
            request.setAttribute("status", status);
            request.getRequestDispatcher("/WEB-INF/pages/addtechnician.jsp")
                   .forward(request, response);
            return;
        }

        try {
            Long.parseLong(phone);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Phone number must contain only digits");
            request.setAttribute("full_name", name);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("services", services);
            request.setAttribute("completed_jobs", jobsStr);
            request.setAttribute("status", status);
            request.getRequestDispatcher("/WEB-INF/pages/addtechnician.jsp")
                   .forward(request, response);
            return;
        }

        if (services == null || services.trim().isEmpty()) {
            request.setAttribute("error", "Services are required");
            request.setAttribute("full_name", name);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("services", services);
            request.setAttribute("completed_jobs", jobsStr);
            request.setAttribute("status", status);
            request.getRequestDispatcher("/WEB-INF/pages/addtechnician.jsp")
                   .forward(request, response);
            return;
        }

        int completedJobs = 0;
        if (jobsStr != null && !jobsStr.isEmpty()) {
            try {
                completedJobs = Integer.parseInt(jobsStr);
                if (completedJobs < 0) {
                    request.setAttribute("error", "Completed jobs cannot be negative");
                    request.setAttribute("full_name", name);
                    request.setAttribute("email", email);
                    request.setAttribute("phone", phone);
                    request.setAttribute("services", services);
                    request.setAttribute("completed_jobs", jobsStr);
                    request.setAttribute("status", status);
                    request.getRequestDispatcher("/WEB-INF/pages/addtechnician.jsp")
                           .forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Completed jobs must be a number");
                request.setAttribute("full_name", name);
                request.setAttribute("email", email);
                request.setAttribute("phone", phone);
                request.setAttribute("services", services);
                request.setAttribute("completed_jobs", jobsStr);
                request.setAttribute("status", status);
                request.getRequestDispatcher("/WEB-INF/pages/addtechnician.jsp")
                       .forward(request, response);
                return;
            }
        }

        try {
            TechnicianModel tech = new TechnicianModel();
            tech.setFullName(name);
            tech.setEmail(email);
            tech.setPhone(phone);
            tech.setServices(services);
            tech.setCompletedJobs(completedJobs);
            tech.setStatus(status != null ? status : "active");

            TechnicianDAO dao = new TechnicianDAO();
            dao.addTechnician(tech);

            response.sendRedirect("managetechnician");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.setAttribute("full_name", name);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("services", services);
            request.setAttribute("completed_jobs", jobsStr);
            request.setAttribute("status", status);
            request.getRequestDispatcher("/WEB-INF/pages/addtechnician.jsp")
                   .forward(request, response);
        }
    }
}