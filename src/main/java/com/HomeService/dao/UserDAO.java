package com.HomeService.dao;

import com.HomeService.model.UserModel;
import com.HomeService.utils.DBconfig;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * UserDAO - Data Access Object for User management.
 * Optimized for ServiceHub project with full CRUD for Admin and Customer roles.
 */
public class UserDAO {

    /**
     * Requirement: Authentication & Profile Retrieval
     * Used during Login and for checking if an account already exists.
     */
    public UserModel getUserByEmail(String email) throws SQLException {
        String query = "SELECT * FROM users WHERE email = ?"; 
        
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, email);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    // Logic: Map database columns to the UserModel object
                    UserModel user = new UserModel(
                        rs.getInt("user_id"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("phone"), 
                        rs.getString("role"),
                        rs.getString("status")
                    );
                    user.setPassword(rs.getString("password"));
                    return user;
                }
            }
        }
        return null;
    }

    /**
     * Requirement: Data Persistence (Registration)
     * Inserts 6 parameters to match the 'servicehome_db' users table structure.
     */
    public void insertUser(UserModel user) throws SQLException {
        String query = "INSERT INTO users (full_name, email, phone, password, role, status) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPhone());    
            stmt.setString(4, user.getPassword());
            stmt.setString(5, user.getRole());
            stmt.setString(6, user.getStatus());
            
            stmt.executeUpdate();
        }
    }

    /**
     * Requirement: Dynamic List Retrieval (Admin Dashboard)
     * Fetches all registered users to be displayed in a table.
     */
    public List<UserModel> getAllUsers() throws SQLException {
        List<UserModel> userList = new ArrayList<>();
        String query = "SELECT * FROM users";
        
        try (Connection conn = DBconfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            while (rs.next()) {
                UserModel user = new UserModel(
                    rs.getInt("user_id"),
                    rs.getString("full_name"),
                    rs.getString("email"),
                    rs.getString("phone"),
                    rs.getString("role"),
                    rs.getString("status")
                );
                userList.add(user);
            }
        }
        return userList;
    }

    /**
     * Requirement: Administrative Controls
     * Allows Admin to toggle status between ACTIVE, PENDING, or REJECTED.
     */
    public void updateUserStatus(int userId, String status) throws SQLException {
        String query = "UPDATE users SET status = ? WHERE user_id = ?";
        
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, status);
            stmt.setInt(2, userId);
            stmt.executeUpdate();
        }
    }
}