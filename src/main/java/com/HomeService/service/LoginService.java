package com.HomeService.service;

import com.HomeService.dao.UserDAO;
import com.HomeService.model.UserModel;
import com.HomeService.utils.PasswordUtil;

public class LoginService {
    private UserDAO userDAO;

    public LoginService() {
        this.userDAO = new UserDAO();
    }

    public UserModel authenticate(String email, String password) throws Exception {
        UserModel user = userDAO.getUserByEmail(email);

        // Verify user exists and password matches the stored BCrypt hash
        if (user != null && PasswordUtil.checkPassword(password, user.getPassword())) {
            
            // Business Rule: Check account status
            if ("PENDING".equalsIgnoreCase(user.getStatus())) {
                throw new Exception("Your account is pending admin approval.");
            } else if ("REJECTED".equalsIgnoreCase(user.getStatus())) {
                throw new Exception("Your account registration was rejected.");
            }
            
            return user;
        }
        
        throw new Exception("Invalid email or password.");
    }
}