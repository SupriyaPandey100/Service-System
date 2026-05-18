package com.HomeService.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import com.HomeService.dao.TechnicianDAO;
import com.HomeService.model.TechnicianModel;
import com.HomeService.model.UserModel;

/**
 * Servlet implementation class ManageTechnicianServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/managetechnician" })
public class ManageTechnicianServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManageTechnicianServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * HANDLES GET REQUESTS - Display the Manage Technician page
     * This runs when admin clicks on "Technicians" in navbar
     * Loads all technicians from database and shows them in table
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        
        UserModel loggedInUser = (UserModel) session.getAttribute("user");
        
        if (!"admin".equalsIgnoreCase(loggedInUser.getRole())) {
            response.sendRedirect("dashboard");
            return;
        }
        
        try {
            TechnicianDAO dao = new TechnicianDAO();
            List<TechnicianModel> technicians = dao.getAllTechnicians();
            
            int totalTechnicians = technicians.size();
            int activeCount = 0;
            int inactiveCount = 0;
            
            for (TechnicianModel tech : technicians) {
                if ("active".equalsIgnoreCase(tech.getStatus())) {
                    activeCount++;
                } else {
                    inactiveCount++;
                }
            }
            
            request.setAttribute("technicians", technicians);
            request.setAttribute("totalTechnicians", totalTechnicians);
            request.setAttribute("activeCount", activeCount);
            request.setAttribute("inactiveCount", inactiveCount);
            
            request.getRequestDispatcher("/WEB-INF/pages/manageTechnician.jsp")
                   .forward(request, response);
                   
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    /**
     * HANDLES POST REQUESTS - Add, Update, or Delete technicians
     * This runs when admin submits forms from the page
     * Three actions possible: add, update, delete
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String action = request.getParameter("action");
            TechnicianDAO dao = new TechnicianDAO();
            
            if ("add".equals(action)) {
                
                String name = request.getParameter("full_name");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                String services = request.getParameter("services");
                String ratingStr = request.getParameter("rating");
                String jobsStr = request.getParameter("completed_jobs");
                String status = request.getParameter("status");
                
                if (name == null || name.trim().equals("") || name.length() < 2) {
                    request.setAttribute("message", "❌ Name must be at least 2 characters");
                    request.setAttribute("messageType", "error");
                    doGet(request, response);
                    return;
                }
                
                if (email == null || !email.contains("@") || !email.contains(".")) {
                    request.setAttribute("message", "❌ Please enter a valid email address");
                    request.setAttribute("messageType", "error");
                    doGet(request, response);
                    return;
                }
                
                if (phone == null || phone.length() != 10) {
                    request.setAttribute("message", "❌ Phone number must be 10 digits");
                    request.setAttribute("messageType", "error");
                    doGet(request, response);
                    return;
                }
                
                try {
                    Long.parseLong(phone);
                } catch (NumberFormatException e) {
                    request.setAttribute("message", "❌ Phone number must contain only digits");
                    request.setAttribute("messageType", "error");
                    doGet(request, response);
                    return;
                }
                
                if (services == null || services.trim().equals("")) {
                    request.setAttribute("message", "❌ Services are required");
                    request.setAttribute("messageType", "error");
                    doGet(request, response);
                    return;
                }
                
                double rating = 0;
                if (ratingStr != null && !ratingStr.equals("")) {
                    try {
                        rating = Double.parseDouble(ratingStr);
                        if (rating < 0 || rating > 5) {
                            request.setAttribute("message", "❌ Rating must be between 0 and 5");
                            request.setAttribute("messageType", "error");
                            doGet(request, response);
                            return;
                        }
                    } catch (NumberFormatException e) {
                        request.setAttribute("message", "❌ Rating must be a number");
                        request.setAttribute("messageType", "error");
                        doGet(request, response);
                        return;
                    }
                }
                
                int completedJobs = 0;
                if (jobsStr != null && !jobsStr.equals("")) {
                    try {
                        completedJobs = Integer.parseInt(jobsStr);
                        if (completedJobs < 0) {
                            request.setAttribute("message", "❌ Completed jobs cannot be negative");
                            request.setAttribute("messageType", "error");
                            doGet(request, response);
                            return;
                        }
                    } catch (NumberFormatException e) {
                        request.setAttribute("message", "❌ Completed jobs must be a number");
                        request.setAttribute("messageType", "error");
                        doGet(request, response);
                        return;
                    }
                }
                
                TechnicianModel tech = new TechnicianModel();
                tech.setFullName(name);
                tech.setEmail(email);
                tech.setPhone(phone);
                tech.setServices(services);
                tech.setRating(rating);
                tech.setCompletedJobs(completedJobs);
                tech.setStatus(status);
                
                dao.addTechnician(tech);
                
                request.setAttribute("message", "✅ Technician added successfully!");
                request.setAttribute("messageType", "success");
                
            } else if ("update".equals(action)) {
                
                int id = Integer.parseInt(request.getParameter("technician_id"));
                String name = request.getParameter("full_name");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                String services = request.getParameter("services");
                String ratingStr = request.getParameter("rating");
                String jobsStr = request.getParameter("completed_jobs");
                String status = request.getParameter("status");
                
                if (name == null || name.trim().equals("") || name.length() < 2) {
                    request.setAttribute("message", "❌ Name must be at least 2 characters");
                    request.setAttribute("messageType", "error");
                    doGet(request, response);
                    return;
                }
                
                if (email == null || !email.contains("@") || !email.contains(".")) {
                    request.setAttribute("message", "❌ Please enter a valid email address");
                    request.setAttribute("messageType", "error");
                    doGet(request, response);
                    return;
                }
                
                if (phone == null || phone.length() != 10) {
                    request.setAttribute("message", "❌ Phone number must be 10 digits");
                    request.setAttribute("messageType", "error");
                    doGet(request, response);
                    return;
                }
                
                if (services == null || services.trim().equals("")) {
                    request.setAttribute("message", "❌ Services are required");
                    request.setAttribute("messageType", "error");
                    doGet(request, response);
                    return;
                }
                
                double rating = 0;
                if (ratingStr != null && !ratingStr.equals("")) {
                    try {
                        rating = Double.parseDouble(ratingStr);
                        if (rating < 0 || rating > 5) {
                            request.setAttribute("message", "❌ Rating must be between 0 and 5");
                            request.setAttribute("messageType", "error");
                            doGet(request, response);
                            return;
                        }
                    } catch (NumberFormatException e) {
                        request.setAttribute("message", "❌ Rating must be a number");
                        request.setAttribute("messageType", "error");
                        doGet(request, response);
                        return;
                    }
                }
                
                int completedJobs = 0;
                if (jobsStr != null && !jobsStr.equals("")) {
                    try {
                        completedJobs = Integer.parseInt(jobsStr);
                        if (completedJobs < 0) {
                            request.setAttribute("message", "❌ Completed jobs cannot be negative");
                            request.setAttribute("messageType", "error");
                            doGet(request, response);
                            return;
                        }
                    } catch (NumberFormatException e) {
                        request.setAttribute("message", "❌ Completed jobs must be a number");
                        request.setAttribute("messageType", "error");
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
                tech.setRating(rating);
                tech.setCompletedJobs(completedJobs);
                tech.setStatus(status);
                
                dao.updateTechnician(tech);
                
                request.setAttribute("message", "✅ Technician updated successfully!");
                request.setAttribute("messageType", "success");
                
            } else if ("delete".equals(action)) {
                
                int id = Integer.parseInt(request.getParameter("id"));
                dao.deleteTechnician(id);
                
                request.setAttribute("message", "✅ Technician deleted successfully!");
                request.setAttribute("messageType", "success");
            }
            
            doGet(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "❌ Error: " + e.getMessage());
            request.setAttribute("messageType", "error");
            doGet(request, response);
        }
    }  
}
