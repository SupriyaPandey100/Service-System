package com.HomeService.model;

import java.io.Serializable;

/**
 * UserModel stores user information for ServiceHub.
 * It is used by JSP, Servlet, and DAO layers.
 */
public class UserModel implements Serializable {

    /**
     * Serial version for serialization support.
     */
    private static final long serialVersionUID = 1L;

    private int id;
    private String fullName;
    private String username;
    private String email;
    private String phone;
    private String password;
    private String role;
    private String status;

    /**
     * Stores uploaded profile image path.
     */
    private String profileImage;

    /**
     * Default constructor required for JavaBeans.
     */
    public UserModel() {
    }

    /**
     * Constructor for existing usage without username.
     *
     * @param id user id
     * @param fullName full name
     * @param email email address
     * @param phone phone number
     * @param role user role
     * @param status account status
     */
    public UserModel(int id, String fullName, String email, String phone, String role, String status) {
        this.id = id;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.role = role;
        this.status = status;
    }

    /**
     * Constructor with username included.
     *
     * @param id user id
     * @param fullName full name
     * @param username username
     * @param email email address
     * @param phone phone number
     * @param role user role
     * @param status account status
     */
    public UserModel(int id, String fullName, String username, String email, String phone, String role, String status) {
        this.id = id;
        this.fullName = fullName;
        this.username = username;
        this.email = email;
        this.phone = phone;
        this.role = role;
        this.status = status;
    }

    /**
     * Returns the user id.
     *
     * @return user id
     */
    public int getId() {
        return id;
    }

    /**
     * Sets the user id.
     *
     * @param id user id
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * Returns the user id.
     *
     * @return user id
     */
    public int getUserId() {
        return id;
    }

    /**
     * Sets the user id.
     *
     * @param userId user id
     */
    public void setUserId(int userId) {
        this.id = userId;
    }

    /**
     * Returns the full name.
     *
     * @return full name
     */
    public String getFullName() {
        return fullName;
    }

    /**
     * Sets the full name.
     *
     * @param fullName full name
     */
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    /**
     * Returns the username.
     *
     * @return username
     */
    public String getUsername() {
        return username;
    }

    /**
     * Sets the username.
     *
     * @param username username
     */
    public void setUsername(String username) {
        this.username = username;
    }

    /**
     * Returns the email.
     *
     * @return email address
     */
    public String getEmail() {
        return email;
    }

    /**
     * Sets the email.
     *
     * @param email email address
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * Returns the phone number.
     *
     * @return phone number
     */
    public String getPhone() {
        return phone;
    }

    /**
     * Sets the phone number.
     *
     * @param phone phone number
     */
    public void setPhone(String phone) {
        this.phone = phone;
    }

    /**
     * Returns the password.
     *
     * @return password
     */
    public String getPassword() {
        return password;
    }

    /**
     * Sets the password.
     *
     * @param password password
     */
    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * Returns the role.
     *
     * @return role
     */
    public String getRole() {
        return role;
    }

    /**
     * Sets the role.
     *
     * @param role role
     */
    public void setRole(String role) {
        this.role = role;
    }

    /**
     * Returns the account status.
     *
     * @return status
     */
    public String getStatus() {
        return status;
    }

    /**
     * Sets the account status.
     *
     * @param status account status
     */
    public void setStatus(String status) {
        this.status = status;
    }

    /**
     * Returns the profile image path.
     *
     * @return profile image path
     */
    public String getProfileImage() {
        return profileImage;
    }

    /**
     * Sets the profile image path.
     *
     * @param profileImage profile image path
     */
    public void setProfileImage(String profileImage) {
        this.profileImage = profileImage;
    }
}