<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Services</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">

 <style>
    :root {
      --primary-color: #0d6efd;
      --secondary-color: #FBC02D;
      --light-gray-bg: #f9fafb;
      --text-dark: #343a40;
    }

    body {
      font-family: 'Poppins', sans-serif;
      background-color: var(--light-gray-bg);
      color: var(--text-dark);
    }

    .service-card {
      border: none;
      border-radius: 12px;
      background-color: white;
      box-shadow: 0 4px 12px rgba(0,0,0,0.05);
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      height: 100%;
    }

    .service-card:hover {
      transform: translateY(-8px);
      box-shadow: 0 10px 25px rgba(0,0,0,0.12);
    }

    .service-img {
      border-radius: 12px 12px 0 0;
      height: 220px;
      width: 100%;
      object-fit: cover;
    }

    .service-title {
      font-weight: 700;
      color: var(--primary-color);
    }

    .btn-primary {
      background-color: var(--primary-color);
      border: none;
    }
    
    .btn-primary:hover {
      background-color: #0b5ed7;
    }
</style>

</head>

<body>

<!-- Header -->
<%@ include file="../header_and_footer/header.jsp" %>

<div class="container py-5">

  <h2 class="text-center fw-bold mb-5">Available Services</h2>

  <div class="row g-4">

    <%
      int categoryId = Integer.parseInt(request.getParameter("category_id"));

      try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String connURL = "jdbc:mysql://localhost/silvercare?user=root&password=1234&serverTimezone=UTC";
        Connection conn = DriverManager.getConnection(connURL);

        Statement stmt = conn.createStatement();
        String sqlStr = "SELECT * FROM service WHERE category_id=" + categoryId;
        ResultSet rs = stmt.executeQuery(sqlStr);

        while (rs.next()) {
          int serviceId = rs.getInt("service_id");
          String name = rs.getString("service_name");
          String desc = rs.getString("description");
          double price = rs.getDouble("price");
          String img = rs.getString("image_path");
    %>

    <!-- Service Card -->
    <div class="col-md-4">
      <div class="service-card">
        <img src="<%= img %>" class="service-img">

        <div class="card-body">
          <h5 class="service-title"><%= name %></h5>
          <p class="text-muted"><%= desc %></p>
          <p class="fw-bold text-dark mb-3">Price: $<%= price %></p>

          <% if (session.getAttribute("sessUserID") != null) { %>
            <a href="serviceBooking.jsp?service_id=<%= serviceId %>" class="btn btn-primary w-100">Book Now</a>
          <% } else { %>
            <a href="<%=request.getContextPath()%>/login.jsp" class="btn btn-secondary w-100">Login to Book</a>
          <% } %>
        </div>
      </div>
    </div>

    <%
        }
        conn.close();
      } catch (Exception e) {
        out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
      }
    %>

  </div>
</div>

<!-- Footer -->
<%@ include file="../header_and_footer/footer.html" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
