package com.HomeService.model;
import java.sql.Date;
import java.sql.Timestamp;

public class BookingModel {

    private int bookingId;
    private int userId;
    private int serviceId;
    private int technicianId;
    private String customerName;
    private String customerPhone;
    private String serviceName;
    private String technicianName;
    private String technicianPhone;
    private Date scheduledDate;
    private String scheduledTime;
    private String address;
    private String status;
    private String notes;
    private Timestamp createdAt;
    private double price;

    /* Default Constructor*/
    public BookingModel() {
    }
    public int getBookingId() {
        return bookingId;}

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;}

    public int getUserId() {
        return userId;}

    public void setUserId(int userId) {
        this.userId = userId;}

    public int getServiceId() {
        return serviceId;}

    public void setServiceId(int serviceId) {
        this.serviceId = serviceId;}

    public int getTechnicianId() {
        return technicianId;}

    public void setTechnicianId(int technicianId) {
        this.technicianId = technicianId;}

    public String getCustomerName() {
        return customerName;}

    public void setCustomerName(String customerName) {
        this.customerName = customerName;}

    public String getCustomerPhone() {
        return customerPhone;}

    public void setCustomerPhone(String customerPhone) {
        this.customerPhone = customerPhone;}

    public String getServiceName() {
        return serviceName;}

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;}

    public String getTechnicianName() {
        return technicianName;}

    public void setTechnicianName(String technicianName) {
        this.technicianName = technicianName;}

    public String getTechnicianPhone() {
        return technicianPhone;}

    public void setTechnicianPhone(String technicianPhone) {
        this.technicianPhone = technicianPhone;}

    public Date getScheduledDate() {
        return scheduledDate;}

    public void setScheduledDate(Date scheduledDate) {
        this.scheduledDate = scheduledDate;}

    public String getScheduledTime() {
        return scheduledTime;}

    public void setScheduledTime(String scheduledTime) {
        this.scheduledTime = scheduledTime;}

    public String getAddress() {
        return address;}

    public void setAddress(String address) {
        this.address = address;}

    public String getStatus() {
        return status;}

    public void setStatus(String status) {
        this.status = status;}

    public String getNotes() {
        return notes;}

    public void setNotes(String notes) {
        this.notes = notes;}

    public Timestamp getCreatedAt() {
        return createdAt;}

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;}

    public double getPrice() {
        return price;}

    public void setPrice(double price) {
        this.price = price;}
}