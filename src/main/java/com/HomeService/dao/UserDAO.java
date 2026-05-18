package com.HomeService.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.HomeService.model.UserModel;
import com.HomeService.utils.DBconfig;

public class UserDAO {

    /* Get user by email */
    public UserModel getUserByEmail(String email) throws Exception {

        String sql = "SELECT * FROM users WHERE email = ?";

        try (
            Connection conn = DBconfig.getConnection();
            PreparedStatement pst = conn.prepareStatement(sql)
        ) {

            pst.setString(1, email);

            ResultSet rs = pst.executeQuery();

            if (rs.next()) {

                UserModel user = new UserModel();

                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getString("status"));

                /* Optional fields */
                try {
                    user.setAddress(rs.getString("address"));
                } catch (Exception e) {
                }

                try {
                    user.setSpecialization(rs.getString("specialization"));
                } catch (Exception e) {
                }

                return user;
            }
        }

        return null;
    }

    /* Register new user */
    public void insertUser(UserModel user) throws Exception {

        String sql = "INSERT INTO users (full_name, email, phone, address, password, role, status, specialization) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (
            Connection conn = DBconfig.getConnection();
            PreparedStatement pst = conn.prepareStatement(sql)
        ) {

            pst.setString(1, user.getFullName());
            pst.setString(2, user.getEmail());
            pst.setString(3, user.getPhone());
            pst.setString(4, user.getAddress());
            pst.setString(5, user.getPassword());
            pst.setString(6, user.getRole());
            pst.setString(7, user.getStatus());
            pst.setString(8, user.getSpecialization());

            pst.executeUpdate();
        }
    }

    /* Get all users */
    public List<UserModel> getAllUsers() throws Exception {

        List<UserModel> users = new ArrayList<>();

        String sql = "SELECT * FROM users ORDER BY created_at DESC";

        try (
            Connection conn = DBconfig.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql)
        ) {

            while (rs.next()) {

                UserModel user = new UserModel();

                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getString("status"));

                try {
                    user.setSpecialization(rs.getString("specialization"));
                } catch (Exception e) {
                }

                users.add(user);
            }
        }

        return users;
    }

    /* Get pending users */
    public List<UserModel> getPendingUsers() throws Exception {

        List<UserModel> users = new ArrayList<>();

        String sql = "SELECT * FROM users WHERE status = 'pending' AND role = 'USER'";

        try (
            Connection conn = DBconfig.getConnection();
            PreparedStatement pst = conn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery()
        ) {

            while (rs.next()) {

                UserModel user = new UserModel();

                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));

                users.add(user);
            }
        }

        return users;
    }

    /* Get all technicians */
    public List<UserModel> getAllTechnicians() throws Exception {

        List<UserModel> technicians = new ArrayList<>();

        String sql = "SELECT * FROM users WHERE role = 'TECHNICIAN' AND status = 'active'";

        try (
            Connection conn = DBconfig.getConnection();
            PreparedStatement pst = conn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery()
        ) {

            while (rs.next()) {

                UserModel tech = new UserModel();

                tech.setUserId(rs.getInt("user_id"));
                tech.setFullName(rs.getString("full_name"));
                tech.setEmail(rs.getString("email"));
                tech.setPhone(rs.getString("phone"));
                tech.setSpecialization(rs.getString("specialization"));

                technicians.add(tech);
            }
        }

        return technicians;
    }

    /* Update user status */
    public boolean updateUserStatus(int userId, String status) throws Exception {

        String sql = "UPDATE users SET status = ? WHERE user_id = ?";

        try (
            Connection conn = DBconfig.getConnection();
            PreparedStatement pst = conn.prepareStatement(sql)
        ) {

            pst.setString(1, status);
            pst.setInt(2, userId);

            return pst.executeUpdate() > 0;
        }
    }

    /* Total users count */
    public int getTotalUsersCount() throws Exception {

        String sql = "SELECT COUNT(*) FROM users WHERE role = 'USER'";

        try (
            Connection conn = DBconfig.getConnection();
            PreparedStatement pst = conn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery()
        ) {

            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    /* Pending users count */
    public int getPendingUsersCount() throws Exception {

        String sql = "SELECT COUNT(*) FROM users WHERE status = 'pending' AND role = 'USER'";

        try (
            Connection conn = DBconfig.getConnection();
            PreparedStatement pst = conn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery()
        ) {

            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    /* Active users count */
    public int getActiveUsersCount() throws Exception {

        String sql = "SELECT COUNT(*) FROM users WHERE status = 'active' AND role = 'USER'";

        try (
            Connection conn = DBconfig.getConnection();
            PreparedStatement pst = conn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery()
        ) {

            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    /* Total technicians count */
    public int getTotalTechniciansCount() throws Exception {

        String sql = "SELECT COUNT(*) FROM users WHERE role = 'TECHNICIAN'";

        try (
            Connection conn = DBconfig.getConnection();
            PreparedStatement pst = conn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery()
        ) {

            return rs.next() ? rs.getInt(1) : 0;
        }
    }
}