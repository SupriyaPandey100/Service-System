package com.HomeService.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.HomeService.model.WishlistModel;
import com.HomeService.utils.DBconfig;

public class WishlistDAO {

    // Fetch all wishlist items for a specific user
    public List<WishlistModel> getUserWishlist(int userId) {
        List<WishlistModel> list = new ArrayList<>();

        // FIXED: Using 's.name' and 's.service_id' to perfectly match your database
        String sql = "SELECT w.wishlist_id, w.service_id, s.name, s.description, s.category, s.price, s.image_url " +
                     "FROM wishlists w " +
                     "INNER JOIN services s ON w.service_id = s.service_id " +
                     "WHERE w.user_id = ? ORDER BY w.created_at DESC";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    WishlistModel item = new WishlistModel();
                    item.setWishlistId(rs.getInt("wishlist_id"));
                    item.setServiceId(rs.getInt("service_id"));

                    // FIXED: Pulling from the 'name' column
                    item.setServiceName(rs.getString("name"));

                    item.setDescription(rs.getString("description"));
                    item.setCategory(rs.getString("category"));
                    item.setPrice(rs.getDouble("price"));
                    item.setImageUrl(rs.getString("image_url"));
                    list.add(item);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching wishlist:");
            e.printStackTrace();
        }
        return list;
    }

    // Add an item to the wishlist
    public boolean addItem(int userId, int serviceId) {
        // INSERT IGNORE prevents SQL crashes if the user clicks the heart twice on the same service
        String sql = "INSERT IGNORE INTO wishlists (user_id, service_id) VALUES (?, ?)";

        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setInt(2, serviceId);

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Error adding to wishlist:");
            e.printStackTrace();
            return false;
        }
    }

    // Remove an item from the wishlist
    public boolean removeItem(int wishlistId) {
        String sql = "DELETE FROM wishlists WHERE wishlist_id = ?";
        try (Connection conn = DBconfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, wishlistId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}