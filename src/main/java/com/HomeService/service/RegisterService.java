package com.HomeService.service;

import com.service_hub.dao.UserDAO;
import com.service_hub.model.UserModel;
import com.service_hub.utils.PasswordUtil;

public class RegisterService {
    private UserDAO dao;

    public RegisterService() {
        this.dao = new UserDAO();
    }

    /**
     * Processes a new user registration.
     * Fulfills coursework security requirements by encrypting passwords before DB insertion.
     */
    public void addUser(UserModel user) throws Exception {
        // 1. Encrypt the plain-text password using BCrypt
        String hashedPassword = PasswordUtil.getHashPassword(user.getPassword());
        user.setPassword(hashedPassword);
        
        // 2. Assign a default role if one hasn't been set
        if (user.getRole() == null || user.getRole().trim().isEmpty()) {
            user.setRole("USER");
        }

        // 3. Pass the secured model to the DAO
        dao.insertUser(user);
    }
}