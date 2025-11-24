<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%

	// Admin session guard
	HttpSession s = request.getSession(false);
	if(s == null || !"ADMIN".equals(s.getAttribute("sessUserRole"))){
	    response.sendRedirect("../clientLogin.jsp");
	    return;
	}


    String serviceId = request.getParameter("id");

    if(serviceId == null){
        out.println("<h3 class='text-danger text-center mt-5'>Invalid service ID</h3>");
        return;
    }

    String message = "";
    String type = "success";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/silvercare?user=root&password=1234&serverTimezone=UTC"
        );

        String sql = "DELETE FROM service WHERE service_id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, Integer.parseInt(serviceId));

        int rows = ps.executeUpdate();
        conn.close();

        if(rows > 0){
            message = "Service has been deleted successfully.";
        } else {
            message = "Service not found or could not be deleted.";
            type = "danger";
        }

    } catch(Exception e) {
        message = "Error: " + e.getMessage();
        type = "danger";
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Service</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5" style="max-width:650px;">
    <div class="alert alert-<%=type%> text-center fw-semibold">
        <%= message %>
    </div>
    <div class="text-center mt-3">
        <a href="manageServices.jsp" class="btn btn-primary">Back to Manage Services</a>
    </div>
</div>

</body>
</html>
