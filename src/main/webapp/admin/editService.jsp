<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.sql.*" %>

<%
    // Admin session guard
    HttpSession s = request.getSession(false);
    if(s == null || !"ADMIN".equals(s.getAttribute("sessUserRole"))){
        response.sendRedirect("../clientLogin.jsp");
        return;
    }

    // Retrieve service ID
    String serviceId = request.getParameter("id");
    if(serviceId == null){
        out.println("<h3 class='text-danger'>Invalid service ID.</h3>");
        return;
    }

    String service_name = "";
    String description = "";
    String price = "";
    String image_path = "";
    int category_id = 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/silvercare?user=root&password=1234&serverTimezone=UTC"
        );

        String sql = "SELECT * FROM service WHERE service_id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, Integer.parseInt(serviceId));
        ResultSet rs = ps.executeQuery();

        if(rs.next()){
            service_name = rs.getString("service_name");
            description = rs.getString("description");
            price = rs.getString("price");
            image_path = rs.getString("image_path");
            category_id = rs.getInt("category_id");
        } else {
            out.println("<h3 class='text-danger'>Service not found.</h3>");
            return;
        }

        conn.close();

    } catch(Exception e){
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Edit Service | Admin</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">

<style>
body{
    background: linear-gradient(145deg,#00796B,#2E7D32);
    font-family:'Poppins',sans-serif;
    min-height:100vh;
}

/* Main Card */
.edit-container{
    background:white;
    padding:40px;
    border-radius:24px;
    max-width:850px;
    margin:auto;
    margin-top:50px;
    box-shadow:0 14px 38px rgba(0,0,0,.28);
}

/* Page Title */
.page-title{
    color:#00796B;
    font-weight:700;
}

/* Buttons */
.btn-update{
    background:#2E7D32;
    color:white;
    font-weight:600;
    padding:10px 22px;
    border:none;
    border-radius:10px;
}
.btn-update:hover{
    background:#1b5e20;
}

.btn-cancel{
    border-radius:10px;
    font-weight:600;
}
</style>
</head>

<body>

<%@ include file="../header_and_footer/header.jsp" %>

<div class="edit-container">

    <h2 class="page-title mb-4">
        <i class="fa-solid fa-pen-to-square me-2"></i> Edit Service
    </h2>

    <form method="post" action="updateService.jsp">
        <input type="hidden" name="service_id" value="<%= serviceId %>">

        <!-- Service Name -->
        <div class="mb-3">
            <label class="form-label fw-semibold">Service Name</label>
            <input type="text" name="service_name" class="form-control" value="<%= service_name %>" required>
        </div>

        <!-- Category Dropdown -->
        <div class="mb-3">
            <label class="form-label fw-semibold">Category</label>
            <select name="category_id" class="form-select" required>
                <option value="1" <%= (category_id==1?"selected":"") %>>Home Nursing</option>
                <option value="2" <%= (category_id==2?"selected":"") %>>Physiotherapy</option>
                <option value="3" <%= (category_id==3?"selected":"") %>>Meal Delivery</option>
            </select>
        </div>

        <!-- Price -->
        <div class="mb-3">
            <label class="form-label fw-semibold">Price ($)</label>
            <input type="number" name="price" step="0.01" min="0" class="form-control" value="<%= price %>" required>
        </div>

        <!-- Image URL -->
        <div class="mb-3">
            <label class="form-label fw-semibold">Image URL</label>
            <input type="text" name="image_path" class="form-control" value="<%= image_path %>">
        </div>

        <!-- Description -->
        <div class="mb-3">
            <label class="form-label fw-semibold">Description</label>
            <textarea name="description" class="form-control" rows="4" required><%= description %></textarea>
        </div>

        <!-- Buttons -->
        <div class="d-flex justify-content-between mt-4">
            <a href="manageServices.jsp" class="btn btn-secondary btn-cancel px-4">Cancel</a>
            <button type="submit" class="btn btn-update px-4">
                <i class="fa-solid fa-save me-2"></i> Update Service
            </button>
        </div>

    </form>

</div>

<%@ include file="../header_and_footer/footer.html" %>

</body>
</html>
