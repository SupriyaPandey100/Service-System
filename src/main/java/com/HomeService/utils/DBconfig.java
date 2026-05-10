package com.HomeService.utils;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 * Utility class to manage MySQL database connections.
 * Matches Task A requirements for Database Development.
 */
public class DBconfig {

    // Database credentials matching your local XAMPP/MySQL setup
    private static final String URL = "jdbc:mysql://localhost:3306/servicehub_db";
    private static final String USER = "root";
    private static final String PASSWORD = ""; // Leave empty if using default XAMPP settings

    /**
     * Establishes and returns a connection to the database.
     */
    public static Connection getConnection() {
        Connection conn = null;
        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("✅ Successfully connected to Service Hub DB");
        } catch (Exception e) {
            System.out.println("Database Connection Failed!");
            e.printStackTrace(); 
        }
        return conn;
    }
}