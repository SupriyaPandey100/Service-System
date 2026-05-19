package com.HomeService.utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * PasswordUtils - Utility class for password security.
 * Handles hashing and verifying passwords using SHA-256 algorithm.
 */
public class PasswordUtils {

    /**
     * Hashes a plain text password using SHA-256 algorithm.
     * Input  : plain text password string
     * Output : hashed password string to store in database
     */
    public static String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password!", e);
        }
    }

    /**
     * Verifies plain text password against hashed password.
     * Input  : plain text password, hashed password from database
     * Output : true if passwords match, false if not
     */
    public static boolean checkPassword(String plainPassword,
                                         String hashedPassword) {
        String hashedInput = hashPassword(plainPassword);
        return hashedInput.equals(hashedPassword);
    }
}