package com.HomeService.service;

import com.service_hub.dao.UserDAO;
import com.service_hub.model.UserModel;
import com.service_hub.utils.PasswordUtil;

public class LoginService {
    private UserDAO dao;

    public LoginService() {
        this.dao = new UserDAO();
    }

    public UserModel authenticate(String email, String password) throws Exception {
        UserModel user = dao.getUserByEmail(email);

        if (user != null && PasswordUtil.checkPassword(password, user.getPassword())) {
            // APPROVAL WORKFLOW CHECK
            if ("PENDING".equalsIgnoreCase(user.getStatus())) {
                throw new Exception("Your account is waiting for Admin approval.");
            } else if ("REJECTED".equalsIgnoreCase(user.getStatus())) {
                throw new Exception("Your registration was rejected.");
            }
            return user; // Authentication passed and user is approved
        }
        
        throw new Exception("Invalid email or password.");
    }
}