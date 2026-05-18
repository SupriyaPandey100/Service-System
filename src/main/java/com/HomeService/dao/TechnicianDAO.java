package com.HomeService.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.HomeService.model.TechnicianModel;
import com.HomeService.utils.DBconfig;

/**
 * TechnicianDAO - Data Access Object for Technician management.
 * Optimized for HomeService project with full CRUD for Admin.
 */
public class TechnicianDAO {

    /**
     * Requirement: Get all technicians
     * Fetches all registered technicians to be displayed in a table.
     * Ordered by technician_id descending (newest first).
     */
    public List<TechnicianModel> getAllTechnicians() throws SQLException {
        List<TechnicianModel> technicianList = new ArrayList<>();
        String query = "SELECT * FROM technicians ORDER BY technician_id DESC";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                TechnicianModel tech = new TechnicianModel();
                tech.setTechnicianId(rs.getInt("technician_id"));
                tech.setFullName(rs.getString("full_name"));
                tech.setEmail(rs.getString("email"));
                tech.setPhone(rs.getString("phone"));
                tech.setServices(rs.getString("services"));
                tech.setRating(rs.getDouble("rating"));
                tech.setCompletedJobs(rs.getInt("completed_jobs"));
                tech.setStatus(rs.getString("status"));
                technicianList.add(tech);
            }
        }
        return technicianList;
    }

    /**
     * Requirement: Add new technician
     * Inserts a new technician record into the database.
     */
    public void addTechnician(TechnicianModel tech) throws SQLException {
        String query = "INSERT INTO technicians (full_name, email, phone, services, rating, completed_jobs, status) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, tech.getFullName());
            stmt.setString(2, tech.getEmail());
            stmt.setString(3, tech.getPhone());
            stmt.setString(4, tech.getServices());
            stmt.setDouble(5, tech.getRating());
            stmt.setInt(6, tech.getCompletedJobs());
            stmt.setString(7, tech.getStatus());

            stmt.executeUpdate();
        }
    }

    /**
     * Requirement: Update technician status
     * Allows Admin to toggle status between ACTIVE or INACTIVE.
     */
    public void updateStatus(int id, String status) throws SQLException {
        String query = "UPDATE technicians SET status = ? WHERE technician_id = ?";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, status);
            stmt.setInt(2, id);
            stmt.executeUpdate();
        }
    }

    /**
     * Requirement: Delete technician
     * Removes a technician record from the database.
     */
    public void deleteTechnician(int id) throws SQLException {
        String query = "DELETE FROM technicians WHERE technician_id = ?";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    /**
     * Requirement: Get technician by ID
     * Fetches a single technician record for editing.
     */
    public TechnicianModel getTechnicianById(int id) throws SQLException {
        String query = "SELECT * FROM technicians WHERE technician_id = ?";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    TechnicianModel tech = new TechnicianModel();
                    tech.setTechnicianId(rs.getInt("technician_id"));
                    tech.setFullName(rs.getString("full_name"));
                    tech.setEmail(rs.getString("email"));
                    tech.setPhone(rs.getString("phone"));
                    tech.setServices(rs.getString("services"));
                    tech.setRating(rs.getDouble("rating"));
                    tech.setCompletedJobs(rs.getInt("completed_jobs"));
                    tech.setStatus(rs.getString("status"));
                    return tech;
                }
            }
        }
        return null;
    }

    /**
     * Requirement: Update technician
     * Allows Admin to edit all fields of an existing technician.
     */
    public void updateTechnician(TechnicianModel tech) throws SQLException {
        String query = "UPDATE technicians SET full_name = ?, email = ?, phone = ?, services = ?, rating = ?, completed_jobs = ?, status = ? WHERE technician_id = ?";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, tech.getFullName());
            stmt.setString(2, tech.getEmail());
            stmt.setString(3, tech.getPhone());
            stmt.setString(4, tech.getServices());
            stmt.setDouble(5, tech.getRating());
            stmt.setInt(6, tech.getCompletedJobs());
            stmt.setString(7, tech.getStatus());
            stmt.setInt(8, tech.getTechnicianId());

            stmt.executeUpdate();
        }
    }
}