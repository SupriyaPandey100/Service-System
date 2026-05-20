package com.HomeService.dao;

import com.HomeService.model.UserModel;
import com.HomeService.utils.DBconfig;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * ============================================================================
 * Data Access Layer: User Database Controller (UserDAO.java)
 * Purpose: Handles complete CRUD database transaction tasks for user profiles.
 * ============================================================================
 */
public class UserDAO {

    public UserModel getUserByEmail(String email) throws SQLException {
        String query = "SELECT * FROM users WHERE email = ?"; 
        
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, email);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    UserModel user = new UserModel();
                    
                    /* Explicit Variable Matching Alignment */
                    user.setUserId(rs.getInt("user_id"));
                    user.setFullName(rs.getString("full_name"));
                    user.setEmail(rs.getString("email"));
                    user.setPhone(rs.getString("phone")); 
                    user.setRole(rs.getString("role"));
                    user.setStatus(rs.getString("status"));
                    user.setPassword(rs.getString("password"));
                    
                    // Safely grab the new fields if they exist
                    try { user.setUsername(rs.getString("username")); } catch (Exception e) {}
                    try { user.setProfileImage(rs.getString("profile_image")); } catch (Exception e) {}
                    
                    return user;
                }
            }
        }
        return null;
    }

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

    public List<UserModel> getAllUsers() throws SQLException {
        List<UserModel> userList = new ArrayList<>();
        String query = "SELECT * FROM users";
        
        try (Connection conn = DBconfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            while (rs.next()) {
                UserModel user = new UserModel();
                
                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getString("status"));
                
                userList.add(user);
            }
        }
        return userList;
    }

    public void updateUserStatus(int userId, String status) throws SQLException {
        String query = "UPDATE users SET status = ? WHERE user_id = ?";
        
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, status);
            stmt.setInt(2, userId);
            stmt.executeUpdate();
        }
    }

    // ========================================================================
    // METHODS ADDED BELOW TO FIX ADMIN DASHBOARD ERRORS
    // ========================================================================

    public int getTotalTechniciansCount() throws SQLException {
        String query = "SELECT COUNT(*) FROM users WHERE role = 'TECHNICIAN'";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    public int getTotalUsersCount() throws SQLException {
        String query = "SELECT COUNT(*) FROM users WHERE role = 'USER'";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }
    
    public void updateUserProfile(UserModel user) throws SQLException {
        String query = "UPDATE users SET full_name = ?, username = ?, email = ?, phone = ?, profile_image = ? WHERE user_id = ?";
        
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getUsername());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getPhone());
            stmt.setString(5, user.getProfileImage());
            stmt.setInt(6, user.getUserId()); 
            
            stmt.executeUpdate();
        }
    }

    public int getPendingUsersCount() throws SQLException {
        String query = "SELECT COUNT(*) FROM users WHERE status = 'pending' AND role = 'USER'";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt =prepareStatement(conn, query);
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }
    
    // Helper method for the block above
    private PreparedStatement prepareStatement(Connection conn, String query) throws SQLException {
    	return conn.prepareStatement(query);
    }

    // ========================================================================
    // MISSING METHODS FOR UserService.java (ADDED TO FIX RED X ERRORS)
    // ========================================================================

    public List<UserModel> getPendingUsers() throws SQLException {
        List<UserModel> userList = new ArrayList<>();
        String query = "SELECT * FROM users WHERE status = 'pending' AND role = 'USER'";
        
        try (Connection conn = DBconfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            while (rs.next()) {
                UserModel user = new UserModel();
                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getString("status"));
                userList.add(user);
            }
        }
        return userList;
    }

    public List<UserModel> getAllTechnicians() throws SQLException {
        List<UserModel> techList = new ArrayList<>();
        String query = "SELECT * FROM users WHERE role = 'TECHNICIAN'";
        
        try (Connection conn = DBconfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            while (rs.next()) {
                UserModel user = new UserModel();
                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getString("status"));
                
                try { user.setUsername(rs.getString("username")); } catch(Exception e) {}
                
                techList.add(user);
            }
        }
        return techList;
    }

    public int getActiveUsersCount() throws SQLException {
        String query = "SELECT COUNT(*) FROM users WHERE status = 'active' AND role = 'USER'";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }
}