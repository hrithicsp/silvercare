<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
    // Admin session guard
    HttpSession s = request.getSession(false);
    if(s == null || !"ADMIN".equals(s.getAttribute("sessUserRole"))){
        response.sendRedirect("../clientLogin.jsp");
        return;
    }
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert Service</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container" style="max-width: 750px;">

<%
    request.setCharacterEncoding("UTF-8");

    String serviceName = request.getParameter("service_name");
    String categoryId = request.getParameter("category_id");
    String price = request.getParameter("price");
    String description = request.getParameter("description");
    String imagePath = request.getParameter("image_path");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/silvercare?user=root&password=root&serverTimezone=UTC"
        );

        String sql = "INSERT INTO service (category_id, service_name, description, price, image_path) " +
                     "VALUES (?, ?, ?, ?, ?)";

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, Integer.parseInt(categoryId));
        ps.setString(2, serviceName);
        ps.setString(3, description);
        ps.setDouble(4, Double.parseDouble(price));

        // If no image provided, set default
        if (imagePath == null || imagePath.trim().equals("")) {
            imagePath = "https://via.placeholder.com/300x200?text=No+Image";
        }
        
        ps.setString(5, imagePath);

        int rowsInserted = ps.executeUpdate();
        conn.close();

        if (rowsInserted > 0) {
%>
            <div class="alert alert-success mt-5 text-center fw-semibold">
                Service added successfully!
            </div>

            <div class="text-center mt-3">
                <a href="manageServices.jsp" class="btn btn-primary">Back to Manage Services</a>
            </div>
<%
        } else {
%>
            <div class="alert alert-danger mt-5 text-center fw-semibold">
                Failed to add service.
            </div>

            <div class="text-center mt-3">
                <a href="addService.jsp" class="btn btn-secondary">Try Again</a>
            </div>
<%
        }

    } catch(Exception e){
%>
        <div class="alert alert-danger mt-5 text-center fw-semibold">
            Error: <%= e.getMessage() %>
        </div>

        <div class="text-center mt-3">
            <a href="addService.jsp" class="btn btn-secondary">Back</a>
        </div>
<%
    }
%>

</div>
</body>
</html>
