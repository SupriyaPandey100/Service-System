package com.HomeService.model;

import java.sql.Date;
import java.sql.Timestamp;

public class BookingModel {
    private int id;
    private int userId;
    private String serviceName;
    private Date serviceDate;
    private String serviceTime;
    private double price;
    private String status;
    private Timestamp createdAt;

    // --- The missing fields added back! ---
    private String address;
    private String instructions;

    // Getters
    public int getId() { return id; }
    public int getUserId() { return userId; }
    public String getServiceName() { return serviceName; }
    public Date getServiceDate() { return serviceDate; }
    public String getServiceTime() { return serviceTime; }
    public double getPrice() { return price; }
    public String getStatus() { return status; }
    public Timestamp getCreatedAt() { return createdAt; }
    public String getAddress() { return address; }
    public String getInstructions() { return instructions; }

    // Setters
    public void setId(int id) { this.id = id; }
    public void setUserId(int userId) { this.userId = userId; }
    public void setServiceName(String serviceName) { this.serviceName = serviceName; }
    public void setServiceDate(Date serviceDate) { this.serviceDate = serviceDate; }
    public void setServiceTime(String serviceTime) { this.serviceTime = serviceTime; }
    public void setPrice(double price) { this.price = price; }
    public void setStatus(String status) { this.status = status; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    public void setAddress(String address) { this.address = address; }
    public void setInstructions(String instructions) { this.instructions = instructions; }
}