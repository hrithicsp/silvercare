<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.sql.*" %>

<%
    // ADMIN GUARD
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
<title>Manage Services | Admin</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">

<style>

body{
    background:#e7f0ff; /* Soft blue theme */
    font-family:'Poppins',sans-serif;
    min-height:100vh;
}

/* main box */
.services-container{
    background:white;
    padding:40px;
    border-radius:20px;
    max-width:1150px;
    margin:auto;
    margin-top:50px;
    box-shadow:0 12px 30px rgba(0,0,0,.12);
}

/* header */
h2.fw-bold{
    color:#0d6efd !important;
}

/* add button */
.btn-add{
    background:#0d6efd !important;   /* bright blue */
    color:white !important;          /* force white text */
    border:2px solid #0a58ca !important;
    font-weight:600;
    padding:10px 22px;
    border-radius:10px;
    position:relative;
    z-index:9999; /* makes sure nothing hides it */
}
.btn-add:hover{
    background:#0b5ed7 !important;
}
/* category styling */
.category-header{
    margin-top:40px;
}
.category-title{
    font-size:1.6rem;
    font-weight:700;
    color:#0d6efd;
}
.category-line{
    width:120px;
    height:4px;
    border-radius:10px;
    background:#0d6efd;
    margin-top:6px;
}

/* service card */
.service-card{
    background:white;
    border-radius:18px;
    overflow:hidden;
    transition:.25s ease;
    box-shadow:0 6px 18px rgba(0,0,0,.12);
}
.service-card:hover{
    transform:translateY(-6px);
    box-shadow:0 14px 28px rgba(0,0,0,.18);
}
.service-card img{
    width:100%;
    height:180px;
    object-fit:cover;
}
.service-desc{
    height:60px;
    overflow:hidden;
    color:#6c757d;
    font-size:.95rem;
}

/* edit + delete buttons */
.btn-warning{
    font-size:.85rem;
    font-weight:600;
    border-radius:6px;
}
.btn-danger{
    font-size:.85rem;
    font-weight:600;
    border-radius:6px;
}

</style>
</head>

<body>

<%@ include file="../header_and_footer/header.jsp" %>

<div class="services-container">

    <!-- HEADER -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold">Manage Services</h2>

		<a href="addService.jsp" class="btn btn-add text-white">
		    <i class="fa-solid fa-plus me-1"></i> Add New Service
		</a>

    </div>

<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/silvercare?user=root&password=root&serverTimezone=UTC"
        );

        String catSQL = "SELECT * FROM service_category ORDER BY category_id ASC";
        Statement catStmt = conn.createStatement();
        ResultSet catRS = catStmt.executeQuery(catSQL);

        while(catRS.next()){
            int categoryId = catRS.getInt("category_id");
            String categoryName = catRS.getString("category_name");
%>

    <!-- CATEGORY SECTION -->
    <div class="category-header">
        <div class="category-title"><%= categoryName %></div>
        <div class="category-line"></div>
    </div>

    <div class="row g-4 mt-1 mb-4">

<%
            String svcSQL = "SELECT * FROM service WHERE category_id=" + categoryId + " ORDER BY service_id DESC";
            Statement svcStmt = conn.createStatement();
            ResultSet svcRS = svcStmt.executeQuery(svcSQL);

            boolean hasServices = false;

            while(svcRS.next()){
                hasServices = true;
%>

        <!-- SERVICE CARD -->
        <div class="col-md-4">
            <div class="service-card">

                <img src="<%= svcRS.getString("image_path") %>" alt="service">

                <div class="p-3">

                    <h5 class="fw-bold mb-1"><%= svcRS.getString("service_name") %></h5>

                    <p class="service-desc mb-2"><%= svcRS.getString("description") %></p>

                    <p class="fw-bold text-primary mb-3">
                        $<%= svcRS.getDouble("price") %>
                    </p>

                    <div class="d-flex justify-content-between">
                        <a href="editService.jsp?id=<%= svcRS.getInt("service_id") %>" class="btn btn-warning btn-sm">
                            Edit
                        </a>

                        <a href="deleteService.jsp?id=<%= svcRS.getInt("service_id") %>"
                           class="btn btn-danger btn-sm"
                           onclick="return confirm('Are you sure you want to delete this service?');">
                            Delete
                        </a>
                    </div>

                </div>
            </div>
        </div>

<%
            } // end services loop

            if(!hasServices){
%>
        <div class="col-12">
            <p class="text-muted fst-italic">No services available in this category.</p>
        </div>
<%
            }

            svcRS.close();
            svcStmt.close();
%>

    </div> <!-- row -->

<%
        } // end category loop

        conn.close();

    } catch(Exception e){
%>
        <p class="text-danger text-center fw-bold mt-3">Error: <%= e.getMessage() %></p>
<%
    }
%>

</div>

<%@ include file="../header_and_footer/footer.html" %>

</body>
</html>
