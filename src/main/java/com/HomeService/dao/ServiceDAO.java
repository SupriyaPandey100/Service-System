package com.HomeService.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.HomeService.model.ServiceModel;
import com.HomeService.utils.DBconfig;

/**
 * ============================================================================
 * Data Access Layer: Unified Service Catalog Controller (ServiceDAO.java)
 * Purpose: Handles global CRUD operations for platform services across ADMIN and USER views.
 * ============================================================================
 */
public class ServiceDAO {

    // ========================================================================
    // 🔍 DATA RETRIEVAL METHODS (Used by Both Users and Admins)
    // ========================================================================

    /**
     * Retrieves the complete catalog of all active services.
     */
    public List<ServiceModel> getAllServices() throws Exception {
        List<ServiceModel> services = new ArrayList<>();
        String sql = "SELECT * FROM services ORDER BY service_id";

        try (Connection conn = DBconfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                services.add(mapResultSetToService(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error getting all services: " + e.getMessage());
        }
        return services;
    }

    /**
     * Retrieves a specific service profile by its primary ID.
     */
    public ServiceModel getServiceById(int serviceId) throws Exception {
        String sql = "SELECT * FROM services WHERE service_id = ?";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setInt(1, serviceId);

            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToService(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error getting service by ID: " + e.getMessage());
        }
        return null;
    }

    /**
     * Retrieves a filtered list of services based on their category.
     */
    public List<ServiceModel> getServicesByCategory(String category) throws Exception {
        List<ServiceModel> services = new ArrayList<>();
        String sql = "SELECT * FROM services WHERE category = ? ORDER BY service_name";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setString(1, category);

            try (ResultSet rs = pst.executeQuery()) {
                while (rs.next()) {
                    services.add(mapResultSetToService(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error getting services by category: " + e.getMessage());
        }
        return services;
    }

    /**
     * Executes a wildcard database search against service names and categories.
     */
    public List<ServiceModel> searchServices(String keyword) throws Exception {
        List<ServiceModel> services = new ArrayList<>();
        String sql = "SELECT * FROM services WHERE service_name LIKE ? OR category LIKE ? ORDER BY service_name";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            String searchPattern = "%" + keyword + "%";
            pst.setString(1, searchPattern);
            pst.setString(2, searchPattern);

            try (ResultSet rs = pst.executeQuery()) {
                while (rs.next()) {
                    services.add(mapResultSetToService(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error searching services: " + e.getMessage());
        }
        return services;
    }

    /**
     * Extracts a unique list of all active categories currently in the database.
     */
    public List<String> getAllCategories() throws Exception {
        List<String> categories = new ArrayList<>();
        String sql = "SELECT DISTINCT category FROM services ORDER BY category";

        try (Connection conn = DBconfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                categories.add(rs.getString("category"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error getting categories: " + e.getMessage());
        }
        return categories;
    }

    // ========================================================================
    // ⚙️ DATA MUTATION METHODS (Strictly Admin Side Operations)
    // ========================================================================

    /**
     * Appends a newly created service into the database schema.
     */
    public boolean insertService(ServiceModel service) throws Exception {
        String sql = "INSERT INTO services (service_name, category, price, duration, description) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setString(1, service.getServiceName());
            pst.setString(2, service.getCategory());
            pst.setDouble(3, service.getPrice());
            pst.setString(4, service.getDuration());
            pst.setString(5, service.getDescription());

            return pst.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error inserting service: " + e.getMessage());
        }
    }

    /**
     * Modifies the parameters of an existing service record.
     */
    public boolean updateService(ServiceModel service) throws Exception {
        String sql = "UPDATE services SET service_name = ?, category = ?, price = ?, duration = ?, description = ? WHERE service_id = ?";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setString(1, service.getServiceName());
            pst.setString(2, service.getCategory());
            pst.setDouble(3, service.getPrice());
            pst.setString(4, service.getDuration());
            pst.setString(5, service.getDescription());
            pst.setInt(6, service.getServiceId());

            return pst.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error updating service: " + e.getMessage());
        }
    }

    /**
     * Securely deletes a service record from the platform.
     */
    public boolean deleteService(int serviceId) throws Exception {
        String sql = "DELETE FROM services WHERE service_id = ?";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setInt(1, serviceId);
            return pst.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error deleting service: " + e.getMessage());
        }
    }

    /**
     * Retrieves the absolute total count of all service listings for dashboard analytics.
     */
    public int getTotalServicesCount() throws Exception {
        String sql = "SELECT COUNT(*) FROM services";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {

            return rs.next() ? rs.getInt(1) : 0;
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error getting total services count: " + e.getMessage());
        }
    }

    // ========================================================================
    // 🛠️ HELPER UTILITY METHODS (DRY Principle)
    // ========================================================================

    /**
     * Helper method to map a ResultSet row into a structured ServiceModel object cleanly.
     * Prevents having to rewrite these 7 lines of code inside every single fetch method above!
     */
    private ServiceModel mapResultSetToService(ResultSet rs) throws SQLException {
        ServiceModel service = new ServiceModel();
        service.setServiceId(rs.getInt("service_id"));
        service.setServiceName(rs.getString("service_name"));
        service.setCategory(rs.getString("category"));
        service.setPrice(rs.getDouble("price"));
        service.setDuration(rs.getString("duration"));
        service.setDescription(rs.getString("description"));
        return service;
    }
}