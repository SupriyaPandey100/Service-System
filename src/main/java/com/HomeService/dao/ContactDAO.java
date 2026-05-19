package com.HomeService.dao;

import com.HomeService.model.ContactMessage;
import com.HomeService.utils.DBconfig;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * ContactDAO handles database operations for contact messages.
 * It stores messages submitted from the Contact Us page.
 */
public class ContactDAO {

    /**
     * Saves a new contact message into the database.
     *
     * @param contactMessage the contact form data
     * @return true if the insert was successful, false otherwise
     * @throws SQLException if a database error occurs
     */
    public boolean saveContactMessage(ContactMessage contactMessage) throws SQLException {
        String sql = "INSERT INTO contact_messages (full_name, email, phone, subject, message, status) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, contactMessage.getFullName());
            ps.setString(2, contactMessage.getEmail());
            ps.setString(3, contactMessage.getPhone());
            ps.setString(4, contactMessage.getSubject());
            ps.setString(5, contactMessage.getMessage());
            ps.setString(6, contactMessage.getStatus());

            return ps.executeUpdate() > 0;
        }
    }
}