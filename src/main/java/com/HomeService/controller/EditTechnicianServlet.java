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

@WebServlet("/edittechnician")
public class EditTechnicianServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userSession") == null) {
            response.sendRedirect("login");
            return;
        }

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect("managetechnician");
            return;
        }

        try {
            int id = Integer.parseInt(idParam);
            TechnicianDAO dao = new TechnicianDAO();
            TechnicianModel tech = dao.getTechnicianById(id);

            if (tech == null) {
                response.sendRedirect("managetechnician");
                return;
            }

            request.setAttribute("technician", tech);
            request.getRequestDispatcher("/WEB-INF/pages/edittechnician.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("managetechnician");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("technician_id");
        String name = request.getParameter("full_name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String services = request.getParameter("services");
        String jobsStr = request.getParameter("completed_jobs");
        String status = request.getParameter("status");

        if (name == null || name.trim().isEmpty() || name.length() < 2) {
            request.setAttribute("error", "Name must be at least 2 characters");
            doGet(request, response);
            return;
        }

        if (email == null || !email.contains("@") || !email.contains(".")) {
            request.setAttribute("error", "Please enter a valid email address");
            doGet(request, response);
            return;
        }

        if (phone == null || phone.length() != 10) {
            request.setAttribute("error", "Phone number must be 10 digits");
            doGet(request, response);
            return;
        }

        try {
            Long.parseLong(phone);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Phone number must contain only digits");
            doGet(request, response);
            return;
        }

        if (services == null || services.trim().isEmpty()) {
            request.setAttribute("error", "Services are required");
            doGet(request, response);
            return;
        }

        try {
            int id = Integer.parseInt(idStr);

            int completedJobs = 0;
            if (jobsStr != null && !jobsStr.isEmpty()) {
                completedJobs = Integer.parseInt(jobsStr);
                if (completedJobs < 0) {
                    request.setAttribute("error", "Completed jobs cannot be negative");
                    doGet(request, response);
                    return;
                }
            }

            TechnicianModel tech = new TechnicianModel();
            tech.setTechnicianId(id);
            tech.setFullName(name);
            tech.setEmail(email);
            tech.setPhone(phone);
            tech.setServices(services);
            tech.setCompletedJobs(completedJobs);
            tech.setStatus(status);

            TechnicianDAO dao = new TechnicianDAO();
            dao.updateTechnician(tech);

            response.sendRedirect("managetechnician");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            doGet(request, response);
        }
    }
}