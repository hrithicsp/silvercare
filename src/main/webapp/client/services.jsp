<%@ page import="java.util.List, com.silvercare.model.Service" %>
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

  <h2 class="text-center fw-bold mb-5">Available Services</h2>

  <div class="row g-4">

    <%
      // Fetch the list of services passed by the Servlet Controller
      List<Service> serviceList = (List<Service>) request.getAttribute("serviceList");
      
      if (serviceList != null && !serviceList.isEmpty()) {
          for (Service s : serviceList) {
    %>

    <div class="col-md-4">
      <div class="service-card">

        <img src="<%= s.getImagePath() %>" class="service-img" alt="">

        <div class="card-body">
          <h5 class="service-title"><%= s.getServiceName() %></h5>
          <p class="text-muted"><%= s.getDescription() %></p>
          <p class="fw-bold text-dark mb-3">Price: $<%= String.format("%.2f", s.getPrice()) %></p>

          <!-- Show booking button only if user logged in -->
          <% if (session.getAttribute("sessUserID") != null) { %>
            <a href="<%=request.getContextPath()%>/client/serviceBooking.jsp?service_id=<%= s.getServiceId() %>" class="btn btn-primary w-100">Book Now</a>
          <% } else { %>
            <a href="<%=request.getContextPath()%>/login.jsp" class="btn btn-secondary w-100">Login to Book</a>
          <% } %>


        </div>
      </div>
    </div>

    <%
          }
      } else {
    %>
        <div class="col-12 text-center">
            <h4 class="text-muted">No services found for this category.</h4>
            <a href="<%=request.getContextPath()%>/ServiceController?action=loadCategories" class="btn btn-outline-primary mt-3">Back to Categories</a>
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

<%@ include file="../header_and_footer/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
