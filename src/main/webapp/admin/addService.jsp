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
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Add New Service | Admin</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">

<style>

body{
    background: linear-gradient(145deg,#00796B,#2E7D32);
    font-family:'Poppins',sans-serif;
    min-height:100vh;
}

/* Main card */
.add-container{
    background:white;
    padding:40px;
    border-radius:24px;
    max-width:850px;
    margin:auto;
    margin-top:50px;
    box-shadow:0 14px 38px rgba(0,0,0,.28);
}

/* Title */
.page-title{
    font-weight:700;
    color:#00796B;
}

/* Buttons */
.btn-submit{
    background:#2E7D32;
    color:white;
    font-weight:600;
    padding:10px 22px;
    border:none;
    border-radius:10px;
}
.btn-submit:hover{
    background:#1b5e20;
}

.btn-back{
    font-weight:600;
    border-radius:10px;
}

</style>
</head>

<body>

<%@ include file="../header_and_footer/header.jsp" %>

<div class="add-container">

    <h2 class="page-title mb-4">
        <i class="fa-solid fa-plus-circle me-2"></i> Add New Service
    </h2>

    <form action="insertService.jsp" method="post">

        <!-- Service Name -->
        <div class="mb-3">
            <label class="form-label fw-semibold">Service Name</label>
            <input type="text" name="service_name" class="form-control" required>
        </div>

        <!-- Category -->
        <div class="mb-3">
            <label class="form-label fw-semibold">Service Category</label>
            <select name="category_id" class="form-select" required>
                <option value="">-- Select Category --</option>

<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/silvercare?user=root&password=1234&serverTimezone=UTC"
        );

        String sql = "SELECT * FROM service_category ORDER BY category_name ASC";
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);

        while(rs.next()) {
%>

                <option value="<%= rs.getInt("category_id") %>">
                    <%= rs.getString("category_name") %>
                </option>

<%
        }
        conn.close();

    } catch(Exception e){
%>
                <option>Error loading categories</option>
<%
    }
%>

            </select>
        </div>

        <!-- Price -->
        <div class="mb-3">
            <label class="form-label fw-semibold">Price (SGD)</label>
            <input type="number" name="price" step="0.01" class="form-control" required>
        </div>

        <!-- Image URL -->
        <div class="mb-3">
            <label class="form-label fw-semibold">Image URL</label>
            <input type="text" name="image_path" class="form-control" placeholder="https://example.com/image.jpg">
        </div>

        <!-- Description -->
        <div class="mb-3">
            <label class="form-label fw-semibold">Description</label>
            <textarea name="description" class="form-control" rows="4" required></textarea>
        </div>

        <!-- Buttons -->
        <div class="d-flex justify-content-between mt-4">
            <a href="manageServices.jsp" class="btn btn-secondary btn-back px-4">Back</a>
            <button type="submit" class="btn btn-submit px-4">
                <i class="fa-solid fa-check me-2"></i> Add Service
            </button>
        </div>

    </form>

</div>

<%@ include file="../header_and_footer/footer.html" %>

</body>
</html>
