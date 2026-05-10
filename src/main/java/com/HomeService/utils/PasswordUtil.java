package com.HomeService.utils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import org.mindrot.jbcrypt.BCrypt;

/**
 * Utility class for secure password hashing and verification.
 * Fulfills mandatory encryption requirements for the coursework.
 */
public class PasswordUtil {

    // Work factor for BCrypt (10 is the standard balance of security and performance)
    private static final int COST = 10;

    /**
     * Hashes a plain-text password using BCrypt.
     * @param password The raw password from the registration form
     * @return Hashed password string to be stored in the database
     */
    public static String getHashPassword(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt(COST));
    }

    /**
     * Verifies an input password against the stored hash.
     * @param input The plain-text password entered during login
     * @param storedHash The hashed password retrieved from the database
     * @return true if the passwords match, false otherwise
     */
    public static boolean checkPassword(String input, String storedHash) {
        try {
            return BCrypt.checkpw(input, storedHash);
        } catch (Exception e) {
            // Returns false if the hash is malformed or null
            return false;
        }
    }
}