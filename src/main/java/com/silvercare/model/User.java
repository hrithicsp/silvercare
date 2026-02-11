package com.silvercare.model;

import java.io.Serializable;

public class User implements Serializable {
    private int userId;
    private String fullname;
    private String gender;
    private String dob;
    private String phone;
    private String address;
    private String email;
    private String password;
    private String profilePic;
    private String preferredContact;
    private int techLevel;
    private boolean notifEnabled;
    private String interests;
    private String role;
    
    private String medicalInfo;
    private String emergencyName;
    private String emergencyPhone;
    private String areaCode; 
    private String careNeeds;

    // Default Constructor
    public User() {}

    // Getters and Setters
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getFullname() { return fullname; }
    public void setFullname(String fullname) { this.fullname = fullname; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public String getDob() { return dob; }
    public void setDob(String dob) { this.dob = dob; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getProfilePic() { return profilePic; }
    public void setProfilePic(String profilePic) { this.profilePic = profilePic; }

    public String getPreferredContact() { return preferredContact; }
    public void setPreferredContact(String preferredContact) { this.preferredContact = preferredContact; }

    public int getTechLevel() { return techLevel; }
    public void setTechLevel(int techLevel) { this.techLevel = techLevel; }

    public boolean isNotifEnabled() { return notifEnabled; }
    public void setNotifEnabled(boolean notifEnabled) { this.notifEnabled = notifEnabled; }

    public String getInterests() { return interests; }
    public void setInterests(String interests) { this.interests = interests; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    
    public String getMedicalInfo() { return medicalInfo; }
    public void setMedicalInfo(String medicalInfo) { this.medicalInfo = medicalInfo; }
    
    public String getEmergencyName() { return emergencyName; }
    public void setEmergencyName(String emergencyName) { this.emergencyName = emergencyName; }
    
    public String getEmergencyPhone() { return emergencyPhone; }
    public void setEmergencyPhone(String emergencyPhone) { this.emergencyPhone = emergencyPhone; }
    
    public String getAreaCode() { return areaCode; }
    public void setAreaCode(String areaCode) { this.areaCode = areaCode; }
    
    public String getCareNeeds() { return careNeeds; }
    public void setCareNeeds(String careNeeds) { this.careNeeds = careNeeds; }
}
