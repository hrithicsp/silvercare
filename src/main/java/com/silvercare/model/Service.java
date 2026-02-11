package com.silvercare.model;

import java.io.Serializable;

public class Service implements Serializable {
    private int serviceId;
    private String serviceName;
    private String description;
    private double price;
    
    // These are the new fields matching your database and DAO
    private String imagePath;
    private int categoryId;

    public Service() {}

    // --- GETTERS AND SETTERS ---
    
    public int getServiceId() { 
        return serviceId; 
    }
    public void setServiceId(int serviceId) { 
        this.serviceId = serviceId; 
    }
    
    public String getServiceName() { 
        return serviceName; 
    }
    public void setServiceName(String serviceName) { 
        this.serviceName = serviceName; 
    }
    
    public String getDescription() { 
        return description; 
    }
    public void setDescription(String description) { 
        this.description = description; 
    }
    
    public double getPrice() { 
        return price; 
    }
    public void setPrice(double price) { 
        this.price = price; 
    }
    
    // Here are the missing methods causing your errors!
    public String getImagePath() { 
        return imagePath; 
    }
    public void setImagePath(String imagePath) { 
        this.imagePath = imagePath; 
    }
    
    public int getCategoryId() { 
        return categoryId; 
    }
    public void setCategoryId(int categoryId) { 
        this.categoryId = categoryId; 
    }
}