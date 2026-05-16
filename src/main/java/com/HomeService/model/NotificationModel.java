package com.HomeService.model;

import java.sql.Timestamp;

public class NotificationModel {
    private int id;
    private int userId;
    private String message;
    private String type; // 'SUCCESS', 'INFO', 'WARNING'
    private boolean isRead;
    private Timestamp createdAt;

    // Default Constructor
    public NotificationModel() {}

    // Parameterized Constructor
    public NotificationModel(int id, int userId, String message, String type, boolean isRead, Timestamp createdAt) {
        this.id = id;
        this.userId = userId;
        this.message = message;
        this.type = type;
        this.isRead = isRead;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public boolean isRead() { return isRead; }
    public void setRead(boolean isRead) { this.isRead = isRead; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}