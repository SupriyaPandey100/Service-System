package com.HomeService.controller;

import java.io.IOException;
import java.util.List;

import com.HomeService.dao.TechnicianDAO;
import com.HomeService.model.TechnicianModel;
import com.HomeService.model.UserModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/managetechnician")
public class ManageTechnicianServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userSession") == null) {
            response.sendRedirect("login");
            return;
        }

        UserModel loggedInUser = (UserModel) session.getAttribute("userSession");

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

            request.getRequestDispatcher("/WEB-INF/pages/managetechnician.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String action = request.getParameter("action");
            TechnicianDAO dao = new TechnicianDAO();

            // ONLY handle DELETE now (Add and Edit are in separate servlets)
            if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.deleteTechnician(id);
                request.setAttribute("message", "Technician deleted successfully!");
                request.setAttribute("messageType", "success");
            }

            doGet(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Error: " + e.getMessage());
            request.setAttribute("messageType", "error");
            doGet(request, response);
        }
    }
}