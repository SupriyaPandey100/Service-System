package com.HomeService.model;

import java.io.Serializable;

public class UserModel implements Serializable {
    private static final long serialVersionUID = 1L;

    private int userId; // Aligned with the database column name 'user_id'
    private String fullName;
    private String email;
    private String phone;
    private String password;
    private String role;
    private String status;

    // 1. Default Constructor (Required for JavaBeans specification layout guidelines)
    public UserModel() {}

    // 2. Parameterized Constructor
    public UserModel(int userId, String fullName, String email, String phone, String role, String status) {
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.role = role;
        this.status = status;
    }

    // --- GETTERS AND SETTERS ---
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
 // Add these variables near the top of UserModel.java with your other variables
    private String username;
    private String profileImage;

    // Add these Getters and Setters at the bottom of UserModel.java
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getProfileImage() { return profileImage; }
    public void setProfileImage(String profileImage) { this.profileImage = profileImage; }
}