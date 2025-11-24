<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
    // Detect login state
    String client = (String) session.getAttribute("client");
    String admin = (String) session.getAttribute("admin");
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

    <!-- Logo -->
    <a class="navbar-brand fw-bold text-primary" href="${pageContext.request.contextPath}/home.jsp" style="font-size: 1.4rem;">
      SilverCare
    </a>

    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" 
            data-bs-target="#navbarNav" aria-controls="navbarNav"
            aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto align-items-center">

        <%-- --------------------------------------------------------
             SHOW FOR CLIENT OR PUBLIC (NOT ADMIN)
             Home + Services Only Visible If Admin Is NOT Logged In
           -------------------------------------------------------- --%>
        <% if(admin == null) { %>
            <li class="nav-item">
            	<a class="navbar-brand fw-bold text-primary" href="home.jsp">Home</a>
            </li>

            <li class="nav-item">
              <a class="nav-link fw-semibold" href="serviceCategories.jsp">Services</a>
            </li>
        <% } %>


        <%-- --------------------------------------------------------
             PUBLIC USER (NO LOGIN)
             Show Register, Client Login, Admin Login
           -------------------------------------------------------- --%>
        <% if(client == null && admin == null) { %>

            <li class="nav-item">
                <a class="nav-link fw-semibold" href="register.jsp">Register</a>
            </li>

            <li class="nav-item">
                <a class="nav-link fw-semibold" href="clientLogin.jsp">Client Login</a>
            </li>

            <li class="nav-item ms-lg-2">
                <a class="btn btn-primary btn-sm fw-semibold px-3 py-2" href="admin/adminLogin.jsp">Admin Login</a>
            </li>


        <%-- --------------------------------------------------------
             CLIENT LOGGED IN
           -------------------------------------------------------- --%>
        <% } else if(client != null) { %>

            <li class="nav-item">
                <a class="nav-link fw-semibold" href="clientProfile.jsp">My Account</a>
            </li>

            <li class="nav-item ms-lg-2">
                <a class="btn btn-danger btn-sm fw-semibold px-3 py-2" href="logout.jsp">Logout</a>
            </li>


        <%-- --------------------------------------------------------
             ADMIN LOGGED IN
           -------------------------------------------------------- --%>
        <% } else if(admin != null) { %>

            <li class="nav-item">
                <a class="nav-link fw-semibold" href="${pageContext.request.contextPath}/admin/adminDashboard.jsp">Dashboard</a>
            </li>

            <li class="nav-item ms-lg-2">
                <a class="btn btn-danger btn-sm fw-semibold px-3 py-2" href="admin/logout.jsp">Logout</a>
            </li>

        <% } %>

      </ul>
    </div>
  </div>
</nav>
</body>
</html>