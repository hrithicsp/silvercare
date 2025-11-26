<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.sql.*" %>

<%
    // Session Guard (to check if admin or not)
    HttpSession s = request.getSession(false);
    if(s == null || !"ADMIN".equals(s.getAttribute("sessUserRole"))){
        response.sendRedirect("../login.jsp");
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
    background:#e7f0ff; 
    font-family:'Poppins',sans-serif;
    min-height:100vh;
}

.form-container{
    background:white;
    padding:40px;
    border-radius:20px;
    max-width:750px;
    margin:auto;
    margin-top:55px;
    box-shadow:0 12px 30px rgba(0,0,0,.12);
}

.page-title{
    color:#0d6efd;
    font-weight:700;
}

.btn-primary{
    background:#0d6efd;
    border:none;
    font-weight:600;
}
.btn-primary:hover{
    background:#0b5ed7;
}

.btn-secondary{
    font-weight:600;
}

</style>
</head>

<body>

<%@ include file="../header_and_footer/header.jsp" %>

<div class="form-container">

    <h2 class="page-title mb-4">Add New Service</h2>

    <form action="insertService.jsp" method="post">

        <!-- Service Name -->
        <div class="mb-3">
            <label class="form-label fw-semibold">Service Name</label>
            <input type="text" name="service_name" class="form-control" required>
        </div>

        <!-- Category Dropdown -->
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
                        <option disabled>Error loading categories</option>
                <%
                    }
                %>

            </select>
        </div>

        <!-- Price -->
        <div class="mb-3">
            <label class="form-label fw-semibold">Price (SGD)</label>
            <input type="number" name="price" step="0.01" min="0" class="form-control" required>
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
            <a href="manageServices.jsp" class="btn btn-secondary">Back</a>
            <button type="submit" class="btn btn-primary">Add Service</button>
        </div>

    </form>

</div>

<%@ include file="../header_and_footer/footer.html" %>

</body>
</html>
