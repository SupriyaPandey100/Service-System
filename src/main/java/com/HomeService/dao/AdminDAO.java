package com.test.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.test.utils.DBConfig;

public class AdminDAO {

    public int getTotalServices() throws Exception {
        Connection con = DBConfig.getConnection();
        String sql = "SELECT COUNT(*) FROM services";
        PreparedStatement pst = con.prepareStatement(sql);
        ResultSet rs = pst.executeQuery();

        int count = 0;
        if (rs.next()) {
            count = rs.getInt(1);
        }

        rs.close(); pst.close(); con.close();
        return count;
    }

    public int getTotalTechnicians() throws Exception {
        Connection con = DBConfig.getConnection();
        String sql = "SELECT COUNT(*) FROM technicians";
        PreparedStatement pst = con.prepareStatement(sql);
        ResultSet rs = pst.executeQuery();

        int count = 0;
        if (rs.next()) {
            count = rs.getInt(1);
        }

        rs.close(); pst.close(); con.close();
        return count;
    }

    public int getTotalBookings() throws Exception {
        Connection con = DBConfig.getConnection();
        String sql = "SELECT COUNT(*) FROM bookings";
        PreparedStatement pst = con.prepareStatement(sql);
        ResultSet rs = pst.executeQuery();

        int count = 0;
        if (rs.next()) {
            count = rs.getInt(1);
        }

        rs.close(); pst.close(); con.close();
        return count;
    }

    public int getPendingBookings() throws Exception {
        Connection con = DBConfig.getConnection();
        String sql = "SELECT COUNT(*) FROM bookings WHERE status='pending'";
        PreparedStatement pst = con.prepareStatement(sql);
        ResultSet rs = pst.executeQuery();

        int count = 0;
        if (rs.next()) {
            count = rs.getInt(1);
        }

        rs.close(); pst.close(); con.close();
        return count;
    }
}