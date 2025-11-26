<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession sessionUser = request.getSession(false);
    boolean loggedIn = (sessionUser != null && sessionUser.getAttribute("sessUserID") != null);
    String role = loggedIn ? (String) sessionUser.getAttribute("sessUserRole") : "";
%>

<style>
    /* Font resize buttons */
    .font-btn {
        border: none;
        background: #f1f1f1;
        padding: 4px 10px;
        margin-left: 6px;
        border-radius: 6px;
        font-weight: 600;
        cursor: pointer;
        transition: 0.2s;
    }
    .font-btn:hover {
        background: #e2e2e2;
    }
</style>

<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm sticky-top">
  <div class="container d-flex align-items-center">

    <!-- Logo -->
    <a class="navbar-brand fw-bold text-primary"
       href="<%=request.getContextPath()%>/home.jsp"
       style="font-size: 1.4rem;">
      SilverCare
    </a>

    <!-- Accessibility Buttons -->
    <div class="d-flex align-items-center ms-3">
        <button class="font-btn" id="decreaseFont">A−</button>
        <button class="font-btn" id="increaseFont">A+</button>
    </div>

    <!-- Mobile Nav Toggle -->
    <button class="navbar-toggler ms-auto" type="button" 
            data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto align-items-center">

        <% if (!loggedIn) { %>

            <!-- NOT LOGGED IN -->
            <li class="nav-item">
              <a class="nav-link fw-semibold"
                 href="<%=request.getContextPath()%>/home.jsp">Home</a>
            </li>
            <li class="nav-item">
              <a class="nav-link fw-semibold"
                 href="<%=request.getContextPath()%>/client/serviceCategories.jsp">Services</a>
            </li>

            <li class="nav-item">
                <a class="nav-link fw-semibold" 
                   href="<%=request.getContextPath()%>/register.jsp">Register</a>
            </li>

            <li class="nav-item ms-lg-2">
                <a class="btn btn-primary btn-sm fw-semibold px-3 py-2"
                   href="<%=request.getContextPath()%>/login.jsp">Login</a>
            </li>

        <% } else { %>

            <% if (role.equals("ADMIN") || role.equals("admin")) { %>

                <!-- ADMIN -->
                <li class="nav-item">
                    <a class="nav-link fw-semibold"
                       href="<%=request.getContextPath()%>/admin/adminDashboard.jsp">Dashboard</a>
                </li>

            <% } else { %>

                <!-- CLIENT -->
                <li class="nav-item">
                  <a class="nav-link fw-semibold"
                     href="<%=request.getContextPath()%>/home.jsp">Home</a>
                </li>

                <li class="nav-item">
                  <a class="nav-link fw-semibold"
                     href="<%=request.getContextPath()%>/client/serviceCategories.jsp">Services</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link fw-semibold"
                       href="<%=request.getContextPath()%>/client/clientDashboard.jsp">Dashboard</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link fw-semibold"
                       href="<%=request.getContextPath()%>/client/viewProfile.jsp">Profile</a>
                </li>

            <% } %>

            <!-- LOGOUT (ALL LOGGED USERS) -->
            <li class="nav-item ms-lg-2">
                <a class="btn btn-danger btn-sm fw-semibold px-3 py-2"
                   href="<%=request.getContextPath()%>/LogoutServlet">Logout</a>
            </li>

        <% } %>

      </ul>
    </div>
  </div>
</nav>

<!-- Font Size Script -->
<script>
    let currentSize = localStorage.getItem("fontSize")
        ? parseInt(localStorage.getItem("fontSize"))
        : 100;

    document.body.style.fontSize = currentSize + "%";

    document.getElementById("increaseFont").onclick = function() {
        if (currentSize < 150) {
            currentSize += 10;
            document.body.style.fontSize = currentSize + "%";
            localStorage.setItem("fontSize", currentSize);
        }
    };

    document.getElementById("decreaseFont").onclick = function() {
        if (currentSize > 70) {
            currentSize -= 10;
            document.body.style.fontSize = currentSize + "%";
            localStorage.setItem("fontSize", currentSize);
        }
    };
</script>

