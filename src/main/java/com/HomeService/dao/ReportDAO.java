package com.HomeService.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.HomeService.model.TechnicianModel;
import com.HomeService.utils.DBconfig;

public class ReportDAO {

    public int getTotalBookingsCount() throws Exception {
        String sql = "SELECT COUNT(*) FROM bookings";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public int getTotalRevenue() throws Exception {
        String sql = "SELECT COALESCE(SUM(total_amount), 0) FROM bookings WHERE UPPER(status) = 'COMPLETED'";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {

            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    public int getTotalCustomers() throws Exception {
        String sql = "SELECT COUNT(*) FROM users WHERE UPPER(role) = 'USER'";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public Map<String, Integer> getBookingStatusCounts() throws Exception {
        Map<String, Integer> statusCounts = new HashMap<>();

        String sql = "SELECT UPPER(status) AS status, COUNT(*) as count FROM bookings GROUP BY UPPER(status)";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {

            while (rs.next()) {
                String status = rs.getString("status");
                int count = rs.getInt("count");
                statusCounts.put(status, count);
            }
        }
        return statusCounts;
    }

    public List<TechnicianModel> getTopTechnicians() throws Exception {
        List<TechnicianModel> topTechnicians = new ArrayList<>();

        String sql = "SELECT * FROM technicians WHERE UPPER(status) = 'ACTIVE' ORDER BY completed_jobs DESC LIMIT 5";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {

            while (rs.next()) {
                TechnicianModel tech = new TechnicianModel();
                tech.setTechnicianId(rs.getInt("technician_id"));
                tech.setFullName(rs.getString("full_name"));
                tech.setEmail(rs.getString("email"));
                tech.setPhone(rs.getString("phone"));
                tech.setServices(rs.getString("services"));
                tech.setCompletedJobs(rs.getInt("completed_jobs"));
                tech.setStatus(rs.getString("status"));
                topTechnicians.add(tech);
            }
        }
        return topTechnicians;
    }
}