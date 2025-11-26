<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
	// Admin Session Guard
	HttpSession s = request.getSession(false);
	if(s == null || !"ADMIN".equals(s.getAttribute("sessUserRole"))){
	    response.sendRedirect("../login.jsp");
	    return;
	}


    request.setCharacterEncoding("UTF-8");

    // Retrieve form data
    String id = request.getParameter("service_id");
    String serviceName = request.getParameter("service_name");
    String categoryId = request.getParameter("category_id");
    String price = request.getParameter("price");
    String description = request.getParameter("description");
    String imagePath = request.getParameter("image_path");

    String message = "";
    String type = "success";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/silvercare?user=root&password=1234&serverTimezone=UTC"
        );

        String sql = "UPDATE service SET category_id=?, service_name=?, description=?, price=?, image_path=? WHERE service_id=?";
        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setInt(1, Integer.parseInt(categoryId));
        ps.setString(2, serviceName);
        ps.setString(3, description);
        ps.setDouble(4, Double.parseDouble(price));
        ps.setString(5, imagePath);
        ps.setInt(6, Integer.parseInt(id));

        int rows = ps.executeUpdate();
        conn.close();

        if(rows > 0){
            message = "Service updated successfully!";
            type = "success";
        } else {
            message = "Update failed. No rows affected.";
            type = "danger";
        }

    } catch(Exception e){
        message = "Error: " + e.getMessage();
        type = "danger";
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Service</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5" style="max-width: 650px;">

    <div class="alert alert-<%=type%> text-center fw-semibold">
        <%= message %>
    </div>

    <div class="text-center mt-3">
        <a href="manageServices.jsp" class="btn btn-primary">Back to Manage Services</a>
    </div>

</div>

</body>
</html>
