package com.HomeService.utils;

import org.mindrot.jbcrypt.BCrypt;

/**
 * Security utility for hashing and verifying passwords.
 * Fulfills the requirement for secure credential storage.
 */
public class PasswordUtil {
    private static final int WORK_FACTOR = 10;

    public static String getHashPassword(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(WORK_FACTOR));
    }

    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        try {
            return BCrypt.checkpw(plainPassword, hashedPassword);
        } catch (Exception e) {
            return false;
        }
    }
}