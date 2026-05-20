package com.HomeService.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.HomeService.model.TechnicianModel;
import com.HomeService.utils.DBconfig;

public class TechnicianDAO {

    // Get all technicians
    public List<TechnicianModel> getAllTechnicians() throws SQLException {
        List<TechnicianModel> list = new ArrayList<>();
        String sql = "SELECT technician_id, full_name, email, phone, services, completed_jobs, status FROM technicians ORDER BY technician_id DESC";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {

            while (rs.next()) {
                TechnicianModel t = new TechnicianModel();
                t.setTechnicianId(rs.getInt("technician_id"));
                t.setFullName(rs.getString("full_name"));
                t.setEmail(rs.getString("email"));
                t.setPhone(rs.getString("phone"));
                t.setServices(rs.getString("services"));
                t.setCompletedJobs(rs.getInt("completed_jobs"));
                t.setStatus(rs.getString("status"));
                list.add(t);
            }
        }
        return list;
    }

    // Add new technician
    public void addTechnician(TechnicianModel tech) throws SQLException {
        String sql = "INSERT INTO technicians (full_name, email, phone, services, completed_jobs, status) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setString(1, tech.getFullName());
            pst.setString(2, tech.getEmail());
            pst.setString(3, tech.getPhone());
            pst.setString(4, tech.getServices());
            pst.setInt(5, tech.getCompletedJobs());
            pst.setString(6, tech.getStatus());

            pst.executeUpdate();
        }
    }

    // Update technician
    public void updateTechnician(TechnicianModel tech) throws SQLException {
        String sql = "UPDATE technicians SET full_name = ?, email = ?, phone = ?, services = ?, completed_jobs = ?, status = ? WHERE technician_id = ?";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setString(1, tech.getFullName());
            pst.setString(2, tech.getEmail());
            pst.setString(3, tech.getPhone());
            pst.setString(4, tech.getServices());
            pst.setInt(5, tech.getCompletedJobs());
            pst.setString(6, tech.getStatus());
            pst.setInt(7, tech.getTechnicianId());

            pst.executeUpdate();
        }
    }

    // Update technician status only
    public void updateStatus(int id, String status) throws SQLException {
        String sql = "UPDATE technicians SET status = ? WHERE technician_id = ?";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setString(1, status);
            pst.setInt(2, id);
            pst.executeUpdate();
        }
    }

    // Delete technician
    public void deleteTechnician(int id) throws SQLException {
        String sql = "DELETE FROM technicians WHERE technician_id = ?";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setInt(1, id);
            pst.executeUpdate();
        }
    }

    // Get technician by ID
    public TechnicianModel getTechnicianById(int id) throws SQLException {
        String sql = "SELECT technician_id, full_name, email, phone, services, completed_jobs, status FROM technicians WHERE technician_id = ?";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setInt(1, id);

            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    TechnicianModel t = new TechnicianModel();
                    t.setTechnicianId(rs.getInt("technician_id"));
                    t.setFullName(rs.getString("full_name"));
                    t.setEmail(rs.getString("email"));
                    t.setPhone(rs.getString("phone"));
                    t.setServices(rs.getString("services"));
                    t.setCompletedJobs(rs.getInt("completed_jobs"));
                    t.setStatus(rs.getString("status"));
                    return t;
                }
            }
        }
        return null;
    }
}