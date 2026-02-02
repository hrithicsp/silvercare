<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Services</title>

  <!-- Bootstrap + Icons -->
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

    /* Service card UI */
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

<!-- Shared header -->
<%@ include file="../header_and_footer/header.jsp" %>

<div class="container py-5">

  <%
    String catIdParam = request.getParameter("category_id");
    if (catIdParam == null || catIdParam.trim().isEmpty()) {
      response.sendRedirect(request.getContextPath() + "/client/serviceCategories.jsp");
      return;
    }
    int categoryId;
    try {
      categoryId = Integer.parseInt(catIdParam);
    } catch (NumberFormatException nfe) {
      response.sendRedirect(request.getContextPath() + "/client/serviceCategories.jsp");
      return;
    }
  %>

  <p class="mb-3">
    <a href="<%=request.getContextPath()%>/client/serviceCategories.jsp" class="text-primary text-decoration-none">
      <i class="bi bi-arrow-left me-1"></i> Back to Categories
    </a>
  </p>

  <h2 class="text-center fw-bold mb-5">Available Services</h2>

  <div class="row g-4">

    <%
      try {
        // DB connection setup
        Class.forName("com.mysql.cj.jdbc.Driver");
        String connURL = "jdbc:mysql://localhost/silvercare?user=root&password=1234&serverTimezone=UTC";
        Connection conn = DriverManager.getConnection(connURL);

        // Get services for selected category
        Statement stmt = conn.createStatement();
        String sqlStr = "SELECT * FROM service WHERE category_id=" + categoryId;
        ResultSet rs = stmt.executeQuery(sqlStr);

        // Loop through each service found
        while (rs.next()) {

          int serviceId = rs.getInt("service_id");
          String name = rs.getString("service_name");
          String desc = rs.getString("description");
          double price = rs.getDouble("price");
          String img = rs.getString("image_path");
    %>

    <!-- Individual service card -->
    <div class="col-md-4">
      <div class="service-card">

        <!-- Service image -->
        <img src="<%= img %>" class="service-img">

        <div class="card-body">
          <h5 class="service-title"><%= name %></h5>
          <p class="text-muted"><%= desc %></p>
          <p class="fw-bold text-dark mb-3">Price: $<%= price %></p>

          <!-- Show booking button only if user logged in -->
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

        // Cleanup
        conn.close();
      } catch (Exception e) {
        // Show DB errors if any
        out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
      }
    %>

  </div>
</div>

<!-- Shared footer -->
<%@ include file="../header_and_footer/footer.html" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
