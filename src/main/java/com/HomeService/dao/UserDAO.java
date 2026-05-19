package com.HomeService.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.HomeService.model.UserModel;
import com.HomeService.utils.DBconfig;

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
                    return mapUser(rs);
                }
            }
        }
        return null;
    }

    /**
     * Requirement: Data Persistence (Registration)
     * Inserts user data into the users table.
     */
    public void insertUser(UserModel user) throws SQLException {
        String query = "INSERT INTO users (full_name, username, email, phone, password, role, status) "
                     + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        String username = user.getUsername();
        if (username == null || username.trim().isEmpty()) {
            username = user.getFullName();
        }

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, user.getFullName());
            stmt.setString(2, username);
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getPhone());
            stmt.setString(5, user.getPassword());
            stmt.setString(6, user.getRole());
            stmt.setString(7, user.getStatus());

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
                userList.add(mapUser(rs));
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

    /**
     * Requirement: Profile Update
     * Updates full name, username, email and phone of the logged in user.
     *
     * @param user UserModel object with updated data
     * @throws SQLException if a database error occurs
     */
    public void updateUserProfile(UserModel user) throws SQLException {

        String query = "UPDATE users SET full_name = ?, username = ?, email = ?, phone = ?, profile_image = ? WHERE user_id = ?";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getUsername());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getPhone());
            stmt.setString(5, user.getProfileImage());
            stmt.setInt(6, user.getId());

            stmt.executeUpdate();
        }
    }
    /**
     * Checks whether an email is already used by another user.
     *
     * @param email email address
     * @param currentUserId current user id
     * @return true if another account uses this email
     * @throws SQLException if database access fails
     */
    public boolean isEmailTakenByAnotherUser(String email, int currentUserId) throws SQLException {
        String query = "SELECT user_id FROM users WHERE email = ? AND user_id <> ?";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, email);
            stmt.setInt(2, currentUserId);

            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        }
    }

    /**
     * Checks whether a username is already used by another user.
     *
     * @param username username
     * @param currentUserId current user id
     * @return true if another account uses this username
     * @throws SQLException if database access fails
     */
    public boolean isUsernameTakenByAnotherUser(String username, int currentUserId) throws SQLException {
        String query = "SELECT user_id FROM users WHERE username = ? AND user_id <> ?";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, username);
            stmt.setInt(2, currentUserId);

            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        }
    }

    /**
     * Maps a ResultSet row into a UserModel object.
     *
     * @param rs result set
     * @return user model
     * @throws SQLException if database access fails
     */
    private UserModel mapUser(ResultSet rs) throws SQLException {
        UserModel user = new UserModel();
        user.setId(rs.getInt("user_id"));
        user.setFullName(rs.getString("full_name"));
        user.setUsername(rs.getString("username"));
        user.setEmail(rs.getString("email"));
        user.setPhone(rs.getString("phone"));
        user.setPassword(rs.getString("password"));
        user.setRole(rs.getString("role"));
        user.setStatus(rs.getString("status"));
        user.setProfileImage(rs.getString("profile_image"));
        return user;
    }
}