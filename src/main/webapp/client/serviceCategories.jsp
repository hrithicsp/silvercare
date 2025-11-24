<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Service Categories</title>

  <!-- Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

  <!-- Icons -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

  <!-- Google Font -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">

  <style>
    :root {
      --primary-color: #00796B;
      --secondary-color: #FBC02D;
      --light-gray-bg: #f9fafb;
      --text-dark: #343a40;
    }

    body {
      font-family: 'Poppins', sans-serif;
      background-color: var(--light-gray-bg);
      color: var(--text-dark);
    }

    /* CATEGORY CARD DESIGN (matching home.jsp service cards) */
    .category-card {
      border: none;
      border-radius: 12px;
      padding: 20px;
      background: white;
      box-shadow: 0 4px 12px rgba(0,0,0,0.05);
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      text-align: center;
      height: 100%;
    }

    .category-card:hover {
      transform: translateY(-8px);
      box-shadow: 0 10px 25px rgba(0,0,0,0.12);
    }

    .icon-circle {
      width: 70px;
      height: 70px;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      background-color: #e0f2f1;
      color: var(--primary-color);
      margin: 0 auto 15px auto;
    }

    .category-title {
      font-weight: 700;
      color: var(--primary-color);
    }
  </style>
</head>

<body>

<!-- HEADER -->
<%@ include file="../header_and_footer/header.jsp" %>

<div class="container py-5">
  <h2 class="text-center fw-bold mb-5">Our Service Categories</h2>

  <div class="row g-4">

    <%  
      try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String connURL = "jdbc:mysql://localhost/silvercare?user=root&password=Pass2231&serverTimezone=UTC";
        Connection conn = DriverManager.getConnection(connURL);

        Statement stmt = conn.createStatement();
        String sqlStr = "SELECT * FROM service_category";
        ResultSet rs = stmt.executeQuery(sqlStr);

        // Icon list (rotate icons for fun)
        String[] icons = {"bi-heart-pulse-fill", "bi-people-fill", "bi-bandaid-fill", "bi-house-heart-fill"};
        int iconIndex = 0;

        while (rs.next()) {
            int id = rs.getInt("category_id");
            String name = rs.getString("category_name");

            String icon = icons[iconIndex % icons.length];
            iconIndex++;
    %>

    <!-- CATEGORY CARD -->
    <div class="col-md-4">
      <a href="services.jsp?category_id=<%= id %>" style="text-decoration:none; color:inherit;">
        <div class="category-card">
          <div class="icon-circle">
            <i class="bi <%= icon %> fs-2"></i>
          </div>
          <h5 class="category-title"><%= name %></h5>
          <p class="text-muted">Explore all services under this category.</p>
        </div>
      </a>
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

<!-- FOOTER -->
<%@ include file="../header_and_footer/footer.html" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
