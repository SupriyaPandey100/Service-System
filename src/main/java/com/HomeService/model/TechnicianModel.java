package com.HomeService.model;

public class TechnicianModel {
    private int technicianId;
    private String fullName;
    private String email;
    private String phone;
    private String services;
    private double rating;
    private int completedJobs;
    private String status;
    
    // Getters and Setters
    public int getTechnicianId() { return technicianId; }
    public void setTechnicianId(int technicianId) { this.technicianId = technicianId; }
    
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    
    public String getServices() { return services; }
    public void setServices(String services) { this.services = services; }
    
    public double getRating() { return rating; }
    public void setRating(double rating) { this.rating = rating; }
    
    public int getCompletedJobs() { return completedJobs; }
    public void setCompletedJobs(int completedJobs) { this.completedJobs = completedJobs; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}