package com.HomeService.service;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import java.util.List;
import com.service_hub.dao.UserDAO;
import com.service_hub.model.UserModel;

public class ListService {
    private UserDAO dao;
    
    public ListService() {
        this.dao = new UserDAO();
    }

    public List<UserModel> fetchAllUsers() throws Exception {
        return dao.getAllUsers(); 
    }
    
    public void updateUserStatus(int userId, String action) throws Exception {
        String newStatus = action.equals("APPROVE") ? "APPROVED" : "REJECTED";
        dao.updateUserStatus(userId, newStatus);
    }
}