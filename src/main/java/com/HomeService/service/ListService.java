package com.HomeService.service;


import java.util.List;
import java.sql.SQLException;
import com.HomeService.dao.UserDAO;
import com.HomeService.model.UserModel;

public class ListService {
    private UserDAO userDAO;

    public ListService() {
  
        this.userDAO = new UserDAO();
    }

   
    public List<UserModel> fetchAllUsers() throws SQLException {
   
        return userDAO.getAllUsers();
    }

    
    public void updateUserStatus(int userId, String action) throws SQLException {
     
        String newStatus = "APPROVE".equalsIgnoreCase(action) ? "APPROVED" : "REJECTED";
   
        userDAO.updateUserStatus(userId, newStatus);
    }
}