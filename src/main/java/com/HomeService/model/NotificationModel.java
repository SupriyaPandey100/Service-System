package com.HomeService.model;

import java.sql.Timestamp;

/* ==============================================================================
   Model Component: Notification Data Model Entity (NotificationModel.java)

   Description:
   Acts as a standard Plain Old Java Object (POJO) representing a relational
   notification record from the database. It handles the structural data variables
   for system alerts, booking updates, and warning messages.
   ============================================================================== */
public class NotificationModel {

    private int id;                 /* Unique primary key identifier for the notification */
    private int userId;             /* Foreign key connecting the alert to a specific registered user record */
    private String message;         /* Text body explaining the account or booking event update */
    private String type;            /* Categorized flags: 'SUCCESS', 'INFO', or 'WARNING' for style processing */
    private boolean isRead;         /* Conditional state flag tracker for unseen vs read system alerts */
    private Timestamp createdAt;    /* Chronological database timestamp logging when the alert occurred */

    /* ==============================================================================
       Constructors Layer
       ============================================================================== */

    /* Default no-argument constructor required for JavaBean serialization guidelines */
    public NotificationModel() {}

    /* Parameterized constructor utilized by the NotificationDAO to map database tables into data collections */
    public NotificationModel(int id, int userId, String message, String type, boolean isRead, Timestamp createdAt) {
        this.id = id;
        this.userId = userId;
        this.message = message;
        this.type = type;
        this.isRead = isRead;
        this.createdAt = createdAt;
    }

    /* ==============================================================================
       Encapsulation Layer (Getters & Setters)
       Allows JSTL tags like <c:forEach> and EL loops (${notif.message}) to securely read
       the data values out of individual row entities.
       ============================================================================== */

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