package com.silvercare.model;

public class Caregiver {
    private int applicationId;
    private String fullName;
    private String profilePhoto;
    private String experience;
    private int yearsExperience;
    private String skills;
    private String certifications;
    private String availabilityDays;
    private String preferredShift;

    // Getters and Setters for all fields
    public int getApplicationId() { return applicationId; }
    public void setApplicationId(int applicationId) { this.applicationId = applicationId; }
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public String getProfilePhoto() { return profilePhoto; }
    public void setProfilePhoto(String profilePhoto) { this.profilePhoto = profilePhoto; }
    public String getExperience() { return experience; }
    public void setExperience(String experience) { this.experience = experience; }
    public int getYearsExperience() { return yearsExperience; }
    public void setYearsExperience(int yearsExperience) { this.yearsExperience = yearsExperience; }
    public String getSkills() { return skills; }
    public void setSkills(String skills) { this.skills = skills; }
    public String getCertifications() { return certifications; }
    public void setCertifications(String certifications) { this.certifications = certifications; }
    public String getAvailabilityDays() { return availabilityDays; }
    public void setAvailabilityDays(String availabilityDays) { this.availabilityDays = availabilityDays; }
    public String getPreferredShift() { return preferredShift; }
    public void setPreferredShift(String preferredShift) { this.preferredShift = preferredShift; }
}
