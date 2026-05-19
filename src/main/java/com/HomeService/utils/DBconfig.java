package com.HomeService.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DBconfig Utility - Manages JDBC connections to MySQL.
 */
public class DBconfig {

    // Updated to match your new database name
	private static final String URL = "jdbc:mysql://localhost:3306/service_hub_db";
    private static final String USER = "root";
    private static final String PASS = ""; // Default for XAMPP is empty

    /**
     * Establishes a connection to the MySQL database.
     */
    public static Connection getConnection() throws SQLException {
        try {
            // Loading the modern MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // FIXED: Using 'PASS' to match the variable declared above
            return DriverManager.getConnection(URL, USER, PASS);

        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found. Ensure mysql-connector-j.jar is in WEB-INF/lib.", e);
        }
    }
}