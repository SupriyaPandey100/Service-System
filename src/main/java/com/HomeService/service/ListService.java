package com.HomeService.service;

// --- CRITICAL IMPORTS TO FIX THE ERRORS ---
import java.util.List;
import java.sql.SQLException;
import com.HomeService.dao.UserDAO;
import com.HomeService.model.UserModel;

/**
 * ListService - Business logic layer for managing user lists.
 * Sits between the Controller (Servlet) and the Data Access Layer (DAO).
 */
public class ListService {
    private UserDAO userDAO;

    public ListService() {
        // Initializing the Data Access Object
        this.userDAO = new UserDAO();
    }

    /**
     * Requirement: Dynamic Data Retrieval
     * @return List of UserModel objects from the database
     * @throws SQLException if database access fails
     */
    public List<UserModel> fetchAllUsers() throws SQLException {
        // Calls the DAO to get the current state of the users table
        return userDAO.getAllUsers();
    }

    /**
     * Requirement: Admin Business Logic
     * @param userId The ID of the user to update
     * @param action The string action from the UI
     * @throws SQLException if update fails
     */
    public void updateUserStatus(int userId, String action) throws SQLException {
        // Business Rule: Translate UI actions into database-friendly statuses
        String newStatus = "APPROVE".equalsIgnoreCase(action) ? "APPROVED" : "REJECTED";
        
        // Pass the processed status down to the DAO layer
        userDAO.updateUserStatus(userId, newStatus);
    }
}