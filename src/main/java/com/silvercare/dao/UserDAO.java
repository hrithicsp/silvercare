package com.silvercare.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.silvercare.model.User;
import com.silvercare.util.DBConnection;

public class UserDAO {
    
    public int registerUser(User user) throws SQLException {
        int generatedId = 0;
        String sql = "INSERT INTO user (fullname, gender, dob, phone, address, email, password, "
                   + "profile_pic, preferred_contact, tech_level, notif_enabled, areas_of_interest, role) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'CLIENT')";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            pst.setString(1, user.getFullname());
            pst.setString(2, user.getGender());
            pst.setString(3, user.getDob());
            pst.setString(4, user.getPhone());
            pst.setString(5, user.getAddress());
            pst.setString(6, user.getEmail());
            pst.setString(7, user.getPassword());
            pst.setString(8, user.getProfilePic());
            pst.setString(9, user.getPreferredContact());
            pst.setInt(10, user.getTechLevel());
            pst.setBoolean(11, user.isNotifEnabled());
            pst.setString(12, user.getInterests());

            pst.executeUpdate();

            // Retrieve the AUTO_INCREMENT ID
            ResultSet rs = pst.getGeneratedKeys();
            if (rs.next()) {
                generatedId = rs.getInt(1);
            }
        }
        return generatedId;
    }
    
    public User validateUser(String email, String password) throws SQLException {
        User user = null;
        String sql = "SELECT * FROM user WHERE email = ? AND password = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {
            
            pst.setString(1, email);
            pst.setString(2, password);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setFullname(rs.getString("fullname"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                // Add other fields if you need them in the session
            }
        }
        return user;
    }
    
    public List<User> getClientsReport(String area, String need) throws SQLException {
        List<User> list = new ArrayList<>();
        // Query filters by area code OR care needs
        String sql = "SELECT * FROM user WHERE role = 'CLIENT' " +
                     "AND (area_code LIKE ? OR ? = '') " +
                     "AND (areas_of_interest LIKE ? OR ? = '')";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {
            
            pst.setString(1, "%" + area + "%");
            pst.setString(2, area);
            pst.setString(3, "%" + need + "%");
            pst.setString(4, need);

            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                User u = new User();
                u.setUserId(rs.getInt("user_id"));
                u.setFullname(rs.getString("fullname"));
                u.setEmail(rs.getString("email"));
                u.setPhone(rs.getString("phone"));
                u.setAreaCode(rs.getString("area_code"));
                u.setMedicalInfo(rs.getString("medical_info"));
                u.setEmergencyName(rs.getString("emergency_name"));
                u.setEmergencyPhone(rs.getString("emergency_phone"));
                u.setCareNeeds(rs.getString("areas_of_interest"));
                list.add(u);
            }
        }
        return list;
    }
}