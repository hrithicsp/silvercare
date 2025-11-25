<%@ page language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession sessionUser = request.getSession(false);
    boolean loggedIn = (sessionUser != null && sessionUser.getAttribute("sessUserID") != null);
    String role = loggedIn ? (String) sessionUser.getAttribute("sessUserRole") : "";
%>

<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm sticky-top">
  <div class="container">

    <a class="navbar-brand fw-bold text-primary"
       href="<%=request.getContextPath()%>/home.jsp"
       style="font-size: 1.4rem;">
      SilverCare
    </a>

    <button class="navbar-toggler" type="button" 
            data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto align-items-center">

        <% if (!loggedIn) { %>

            <!-- Visible to NOT LOGGED IN users -->
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
                   href="<%=request.getContextPath()%>/clientLogin.jsp">Login</a>
            </li>

        <% } else { %>

            <% if (role.equals("ADMIN")) { %>
                <!-- ADMIN sees ONLY Dashboard + Logout -->
                <li class="nav-item">
                    <a class="nav-link fw-semibold"
                       href="<%=request.getContextPath()%>/admin/adminDashboard.jsp">Dashboard</a>
                </li>

            <% } else { %>
                <!-- CLIENT sees normal menu -->
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
            <% } %>

            <!-- Logout for ALL logged-in users -->
            <li class="nav-item ms-lg-2">
                <a class="btn btn-danger btn-sm fw-semibold px-3 py-2"
                   href="<%=request.getContextPath()%>/LogoutServlet">Logout</a>
            </li>

        <% } %>

      </ul>
    </div>
  </div>
</nav>
