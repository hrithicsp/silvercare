package com.silvercare.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.silvercare.model.Service;
import com.silvercare.model.Category;
import com.silvercare.model.Caregiver;
import com.silvercare.util.DBConnection;

public class ServiceDAO {

    // 1. Get Services by Category (For Client View)
    public List<Service> getServicesByCategory(int categoryId) throws SQLException {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT * FROM service WHERE category_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                services.add(mapRowToService(rs));
            }
        }
        return services;
    }

    // 2. Get All Services (For Admin Manage View)
    public List<Service> getAllServices() throws SQLException {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT * FROM service ORDER BY category_id ASC, service_id DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                services.add(mapRowToService(rs));
            }
        }
        return services;
    }

    // 3. Get All Categories (For the Service Categories Page)
    public List<Category> getAllCategories() throws SQLException {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT * FROM service_category";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Category cat = new Category();
                cat.setCategoryId(rs.getInt("category_id"));
                cat.setCategoryName(rs.getString("category_name"));
                categories.add(cat);
            }
        }
        return categories;
    }

    // 4. Get a Single Service by ID (For the Edit Page)
    public Service getServiceById(int id) throws SQLException {
        Service s = null;
        String sql = "SELECT * FROM service WHERE service_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                s = mapRowToService(rs);
            }
        }
        return s;
    }

    // 5. Add New Service (Admin)
    public boolean addService(Service s) throws SQLException {
        String sql = "INSERT INTO service (category_id, service_name, description, price, image_path) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, s.getCategoryId());
            ps.setString(2, s.getServiceName());
            ps.setString(3, s.getDescription());
            ps.setDouble(4, s.getPrice());
            ps.setString(5, s.getImagePath());
            return ps.executeUpdate() > 0;
        }
    }

    // 6. Update Existing Service (Admin)
    public boolean updateService(Service s) throws SQLException {
        String sql = "UPDATE service SET category_id=?, service_name=?, description=?, price=?, image_path=? WHERE service_id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, s.getCategoryId());
            ps.setString(2, s.getServiceName());
            ps.setString(3, s.getDescription());
            ps.setDouble(4, s.getPrice());
            ps.setString(5, s.getImagePath());
            ps.setInt(6, s.getServiceId());
            return ps.executeUpdate() > 0;
        }
    }

    // 7. Delete Service (Admin)
    public boolean deleteService(int id) throws SQLException {
        String sql = "DELETE FROM service WHERE service_id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    // Helper Method to map database rows to the Service object
    private Service mapRowToService(ResultSet rs) throws SQLException {
        Service s = new Service();
        s.setServiceId(rs.getInt("service_id"));
        s.setServiceName(rs.getString("service_name"));
        s.setDescription(rs.getString("description"));
        s.setPrice(rs.getDouble("price"));
        s.setImagePath(rs.getString("image_path"));
        s.setCategoryId(rs.getInt("category_id"));
        return s;
    }
    
 // Add to ServiceDAO.java

    public List<Caregiver> getApprovedCaregiversByCategory(String categoryName) throws SQLException {
        List<Caregiver> caregivers = new ArrayList<>();
        String sql = "SELECT * FROM caregiver_application WHERE status='APPROVED' AND interest_service=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, categoryName);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Caregiver c = new Caregiver();
                c.setApplicationId(rs.getInt("application_id"));
                c.setFullName(rs.getString("full_name"));
                c.setProfilePhoto(rs.getString("profile_photo"));
                c.setExperience(rs.getString("experience"));
                c.setYearsExperience(rs.getInt("years_experience"));
                c.setSkills(rs.getString("skills"));
                c.setCertifications(rs.getString("certifications"));
                c.setAvailabilityDays(rs.getString("availability_days"));
                c.setPreferredShift(rs.getString("preferred_shift"));
                caregivers.add(c);
            }
        }
        return caregivers;
    }

    public void saveBooking(int userId, int serviceId, int caregiverId, String date, String time, String notes) throws SQLException {
        String sql = "INSERT INTO service_booking (user_id, service_id, caregiver_id, booking_date, booking_time, notes, status) VALUES (?, ?, ?, ?, ?, ?, 'PENDING')";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, serviceId);
            ps.setInt(3, caregiverId);
            ps.setString(4, date);
            ps.setString(5, time);
            ps.setString(6, notes);
            ps.executeUpdate();
        }
    }
}