package com.HomeService.service;

import java.util.List;

import com.HomeService.dao.UserDAO;
import com.HomeService.model.UserModel;
import com.HomeService.utils.PasswordUtil;

public class UserService {

    private UserDAO userDAO;

    public UserService() {
        userDAO = new UserDAO();
    }

    public UserModel authenticate(String email, String password) throws Exception {

        UserModel user = userDAO.getUserByEmail(email);

        if (user == null) {
            throw new Exception("Invalid email or password");
        }

        /* Admin bypass */
        if (!"ADMIN".equals(user.getRole())
                && !"active".equalsIgnoreCase(user.getStatus())) {

            throw new Exception("Your account is pending approval");
        }

        /* Password check */
        if (password.equals(user.getPassword())
                || PasswordUtil.checkPassword(password, user.getPassword())) { // Standardized to checkPassword

            return user;
        }

        throw new Exception("Invalid email or password");
    }

    public void registerUser(UserModel user) throws Exception {

        user.setPassword(
                PasswordUtil.getHashPassword(user.getPassword())
        );

        user.setRole("USER");
        user.setStatus("pending");

        // FIX: Method name changed from registerUser() to insertUser() to match UserDAO
        userDAO.insertUser(user);
    }

    public List<UserModel> getAllUsers() throws Exception {
        return userDAO.getAllUsers();
    }

    public List<UserModel> getPendingUsers() throws Exception {
        return userDAO.getPendingUsers();
    }

    public void updateUserStatus(int userId, String status) throws Exception {
        userDAO.updateUserStatus(userId, status);
    }

    public List<UserModel> getAllTechnicians() throws Exception {
        return userDAO.getAllTechnicians();
    }

    public int getTotalUsersCount() throws Exception {
        return userDAO.getTotalUsersCount();
    }

    public int getPendingUsersCount() throws Exception {
        return userDAO.getPendingUsersCount();
    }

    public int getActiveUsersCount() throws Exception {
        return userDAO.getActiveUsersCount();
    }

    public int getTotalTechniciansCount() throws Exception {
        return userDAO.getTotalTechniciansCount();
    }
}