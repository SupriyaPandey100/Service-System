package com.HomeService.model;

import java.io.Serializable;

public class UserModel implements Serializable {
    private int id;
    private String fullName;
    private String email;
    private String phone; // Make sure this is here
    private String password;
    private String role;
    private String status;

    // 1. Default Constructor (Required for JavaBeans)
    public UserModel() {}

    // 2. Data Retrieval Constructor (Match this to your UserDAO line 80)
    public UserModel(int id, String fullName, String email, String phone, String role, String status) {
        this.id = id;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.role = role;
        this.status = status;
    }

    // --- GETTERS AND SETTERS ---
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

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
}