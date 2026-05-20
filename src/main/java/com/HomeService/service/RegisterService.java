package com.HomeService.service;

import com.HomeService.dao.UserDAO;
import com.HomeService.model.UserModel;
import com.HomeService.utils.PasswordUtil;

public class RegisterService {
    private UserDAO userDAO;

    public RegisterService() {
        this.userDAO = new UserDAO();
    }

    public void addUser(UserModel user) throws Exception {
        // 1. Check if email already exists to prevent duplicate entries
        if (userDAO.getUserByEmail(user.getEmail()) != null) {
            throw new Exception("Email is already registered. Please login.");
        }

        // 2. Hash the password for security
        String hashedPassword = PasswordUtil.getHashPassword(user.getPassword());
        user.setPassword(hashedPassword);

        // 3. Assign defaults
        if (user.getRole() == null) {
            user.setRole("USER");
        }
        user.setStatus("ACTIVE"); // Set to PENDING if admin approval is needed

        // 4. Persist to database
        userDAO.insertUser(user);
    }
}