package com.HomeService.model;
import java.sql.Date;
import java.sql.Timestamp;

public class BookingModel {
    private int id;
    private int userId;
    private String serviceName;
    private Date serviceDate;
    private String serviceTime;
    private String address;         // <-- Added Address
    private String instructions;    // <-- Added Instructions
    private String status;
    private double price;
    private Timestamp createdAt;

    // Default constructor
    public BookingModel() {}

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public String getServiceName() { return serviceName; }
    public void setServiceName(String serviceName) { this.serviceName = serviceName; }
    
    public Date getServiceDate() { return serviceDate; }
    public void setServiceDate(Date serviceDate) { this.serviceDate = serviceDate; }
    
    public String getServiceTime() { return serviceTime; }
    public void setServiceTime(String serviceTime) { this.serviceTime = serviceTime; }
    
    // --- NEW GETTERS AND SETTERS ---
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    
    public String getInstructions() { return instructions; }
    public void setInstructions(String instructions) { this.instructions = instructions; }
    // -------------------------------

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}