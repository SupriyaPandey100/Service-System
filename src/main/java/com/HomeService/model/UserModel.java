package com.HomeService.model;

import java.io.Serializable;

public class UserModel implements Serializable {

    private int userId;
    private String fullName;
    private String email;
    private String phone;
    private String address;
    private String password;
    private String role;
    private String status;
    private String specialization;

    public UserModel() {
    }

    /* Constructor for fetching user data */
    public UserModel(int userId, String fullName, String email,
                     String phone, String role, String status) {

        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.role = role;
        this.status = status;
    }

    /* GETTERS AND SETTERS */

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    /* IMPORTANT */
    /* This supports leader old code using getId() */
    public int getId() {
        return userId;
    }

    public void setId(int id) {
        this.userId = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getSpecialization() {
        return specialization;
    }

    public void setSpecialization(String specialization) {
        this.specialization = specialization;
    }
}