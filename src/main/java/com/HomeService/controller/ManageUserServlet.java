package com.HomeService.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;

import com.HomeService.dao.UserDAO;
import com.HomeService.model.UserModel;

/**
 * Servlet implementation class ManageUserServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/manageuser" })
public class ManageUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManageUserServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            UserDAO dao = new UserDAO();
            List<UserModel> usersFromDB = dao.getAllUsers();

            
            List<UserModel> allUsers = new ArrayList<>();

            for(UserModel u : usersFromDB) {

                String role = u.getRole();

                if(role != null && !role.trim().equalsIgnoreCase("admin")) {
                    allUsers.add(u);
                }
            }

            
            String statusFilter = request.getParameter("status");

            if(statusFilter == null || statusFilter.isEmpty()) {
                statusFilter = "all";
            }

            
            List<UserModel> filteredUsers = new ArrayList<>();

            if("all".equalsIgnoreCase(statusFilter)) {

                filteredUsers = allUsers;

            } else {

                for(UserModel u : allUsers) {

                    if(u.getStatus().equalsIgnoreCase(statusFilter)) {
                        filteredUsers.add(u);
                    }
                }
            }

            
            int totalUsers = allUsers.size();
            int pendingCount = 0;
            int approvedCount = 0;
            int rejectedCount = 0;

            for(UserModel u : allUsers) {

                if("pending".equalsIgnoreCase(u.getStatus())) {

                    pendingCount++;

                } else if("approved".equalsIgnoreCase(u.getStatus())) {

                    approvedCount++;

                } else if("rejected".equalsIgnoreCase(u.getStatus())) {

                    rejectedCount++;
                }
            }

            
            request.setAttribute("users", filteredUsers);
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("pendingCount", pendingCount);
            request.setAttribute("approvedCount", approvedCount);
            request.setAttribute("rejectedCount", rejectedCount);
            request.setAttribute("currentFilter", statusFilter);

            request.getRequestDispatcher("/WEB-INF/pages/manageuser.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int id = Integer.parseInt(request.getParameter("id"));
            String action = request.getParameter("action");

            
            String currentFilter = request.getParameter("currentFilter");

            if(currentFilter == null || currentFilter.isEmpty()) {
                currentFilter = "all";
            }

            UserDAO dao = new UserDAO();

            
            if(action.equals("approve")) {

                dao.updateUserStatus(id, "approved");

            } else if(action.equals("reject")) {

                dao.updateUserStatus(id, "rejected");
            }

            
            response.sendRedirect("manageuser?status=" + currentFilter);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}