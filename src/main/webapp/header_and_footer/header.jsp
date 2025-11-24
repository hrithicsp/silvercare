<%@ page language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession sessionUser = request.getSession(false);
    boolean loggedIn = (sessionUser != null && sessionUser.getAttribute("sessUserID") != null);
    String role = loggedIn ? (String) sessionUser.getAttribute("sessUserRole") : "";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Header</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</head>

<body>

<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm sticky-top">
  <div class="container">

    <!-- Brand / Logo -->
    <a class="navbar-brand fw-bold text-primary"
       href="<%=request.getContextPath()%>/home.jsp"
       style="font-size: 1.4rem;">
      SilverCare
    </a>

    <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
            data-bs-target="#navbarNav" aria-controls="navbarNav"
            aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto align-items-center">

        <!-- HOME -->
        <li class="nav-item">
          <a class="nav-link fw-semibold"
             href="<%=request.getContextPath()%>/home.jsp">Home</a>
        </li>

        <!-- SERVICES (client service categories page) -->
        <li class="nav-item">
          <a class="nav-link fw-semibold"
             href="<%=request.getContextPath()%>/client/serviceCategories.jsp">Services</a>
        </li>

        <%-- ============================
             IF NOT LOGGED IN
           ============================ --%>
        <% if (!loggedIn) { %>

            <li class="nav-item">
              <a class="nav-link fw-semibold"
                 href="<%=request.getContextPath()%>/register.jsp">Register</a>
            </li>

            <li class="nav-item ms-lg-2">
              <a class="btn btn-primary btn-sm fw-semibold px-3 py-2"
                 href="<%=request.getContextPath()%>/clientLogin.jsp">Login</a>
            </li>

        <% } else { %>

            <%-- ============================
                 LOGGED IN: ADMIN
               ============================ --%>
            <% if (role.equals("ADMIN")) { %>

                <li class="nav-item">
                    <a class="nav-link fw-semibold"
                       href="<%=request.getContextPath()%>/admin/adminDashboard.jsp">Dashboard</a>
                </li>

            <% } else { %>

            <%-- ============================
                 LOGGED IN: CLIENT
               ============================ --%>
                <li class="nav-item">
                    <a class="nav-link fw-semibold"
                       href="<%=request.getContextPath()%>/client/clientDashboard.jsp">Dashboard</a>
                </li>

            <% } %>

            <!-- LOGOUT BUTTON -->
            <li class="nav-item ms-lg-2">
              <a class="btn btn-danger btn-sm fw-semibold px-3 py-2"
                 href="<%=request.getContextPath()%>/LogoutServlet">Logout</a>
            </li>

        <% } %>

      </ul>
    </div>

  </div>
</nav>

</body>
</html>
