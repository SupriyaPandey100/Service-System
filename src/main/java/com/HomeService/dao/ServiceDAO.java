package com.HomeService.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.HomeService.model.ServiceModel;
import com.HomeService.utils.DBconfig;

public class ServiceDAO {

    // Get all services
    public List<ServiceModel> getAllServices() throws Exception {
        
        List<ServiceModel> services = new ArrayList<>();
        
        String sql = "SELECT * FROM services ORDER BY service_id";
        
        try (Connection conn = DBconfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                ServiceModel service = new ServiceModel();
                service.setServiceId(rs.getInt("service_id"));
                service.setServiceName(rs.getString("service_name"));
                service.setCategory(rs.getString("category"));
                service.setPrice(rs.getDouble("price"));
                service.setDuration(rs.getString("duration"));
                service.setDescription(rs.getString("description"));
                services.add(service);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error getting all services: " + e.getMessage());
        }
        
        return services;
    }

    // Get service by ID
    public ServiceModel getServiceById(int serviceId) throws Exception {
        
        String sql = "SELECT * FROM services WHERE service_id = ?";
        
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            
            pst.setInt(1, serviceId);
            ResultSet rs = pst.executeQuery();
            
            if (rs.next()) {
                ServiceModel service = new ServiceModel();
                service.setServiceId(rs.getInt("service_id"));
                service.setServiceName(rs.getString("service_name"));
                service.setCategory(rs.getString("category"));
                service.setPrice(rs.getDouble("price"));
                service.setDuration(rs.getString("duration"));
                service.setDescription(rs.getString("description"));
                return service;
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error getting service by ID: " + e.getMessage());
        }
        
        return null;
    }

    // Get services by category
    public List<ServiceModel> getServicesByCategory(String category) throws Exception {
        
        List<ServiceModel> services = new ArrayList<>();
        
        String sql = "SELECT * FROM services WHERE category = ? ORDER BY service_name";
        
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            
            pst.setString(1, category);
            ResultSet rs = pst.executeQuery();
            
            while (rs.next()) {
                ServiceModel service = new ServiceModel();
                service.setServiceId(rs.getInt("service_id"));
                service.setServiceName(rs.getString("service_name"));
                service.setCategory(rs.getString("category"));
                service.setPrice(rs.getDouble("price"));
                service.setDuration(rs.getString("duration"));
                service.setDescription(rs.getString("description"));
                services.add(service);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error getting services by category: " + e.getMessage());
        }
        
        return services;
    }

    // Insert new service
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

    // Update service
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

    // Delete service
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

    // Get total services count (for dashboard)
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

    // Search services by name
    public List<ServiceModel> searchServices(String keyword) throws Exception {
        
        List<ServiceModel> services = new ArrayList<>();
        
        String sql = "SELECT * FROM services WHERE service_name LIKE ? OR category LIKE ? ORDER BY service_name";
        
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + keyword + "%";
            pst.setString(1, searchPattern);
            pst.setString(2, searchPattern);
            
            ResultSet rs = pst.executeQuery();
            
            while (rs.next()) {
                ServiceModel service = new ServiceModel();
                service.setServiceId(rs.getInt("service_id"));
                service.setServiceName(rs.getString("service_name"));
                service.setCategory(rs.getString("category"));
                service.setPrice(rs.getDouble("price"));
                service.setDuration(rs.getString("duration"));
                service.setDescription(rs.getString("description"));
                services.add(service);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error searching services: " + e.getMessage());
        }
        
        return services;
    }

    // Get all unique categories
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
}