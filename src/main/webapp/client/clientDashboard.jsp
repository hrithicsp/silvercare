<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.sql.*, com.silvercare.util.DBConnection" %>

<%
    HttpSession s = request.getSession(false);
    if(s == null || !"CLIENT".equals(s.getAttribute("sessUserRole"))){
        response.sendRedirect("../clientLogin.jsp");
        return;
    }

    String fullName = (String) s.getAttribute("sessUserName");

    // fetch application status
    int uid = (int) s.getAttribute("sessUserID");

    Connection con2 = DBConnection.getConnection();
    PreparedStatement pst2 = con2.prepareStatement(
        "SELECT status, submitted_at FROM caregiver_application WHERE user_id=? ORDER BY submitted_at DESC LIMIT 1"
    );
    pst2.setInt(1, uid);
    ResultSet rs2 = pst2.executeQuery();

    boolean hasApp = false;
    String appStatus = "";
    String submittedAt = "";

    if(rs2.next()){
        hasApp = true;
        appStatus = rs2.getString("status");
        submittedAt = rs2.getString("submitted_at");
    }
%>

<!DOCTYPE html>
<html>
<head>

<title>Client Dashboard - SilverCare</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">

<style>

body{
    background: linear-gradient(145deg,#0d6efd,#1849b8);
    font-family:'Poppins',sans-serif;
    min-height:100vh;
}

/* MAIN DASHBOARD CARD */
.dashboard-container{
    background:white;
    border-radius:24px;
    box-shadow:0 12px 38px rgba(0,0,0,0.22);
    max-width:1100px;
    margin:auto;
    padding:3rem;
    margin-top:3rem;
}

/* Top title box */
.welcome-box{
    background:#e7f0ff;
    padding:30px;
    border-radius:20px;
    margin-bottom:35px;
}

/* Dashboard buttons */
.feature-card{
    padding:28px;
    border-radius:18px;
    background:white;
    box-shadow:0 4px 14px rgba(0,0,0,0.1);
    transition:all .25s ease;
    height:100%;
}
.feature-card:hover{
    transform:translateY(-6px);
    box-shadow:0 7px 22px rgba(0,0,0,0.18);
}

/* icons */
.feature-card i{
    font-size:38px;
    margin-bottom:12px;
    color:#0d6efd;
}

.logout-card i{
    color:#E53935 !important;
}
</style>
</head>

<body>

<%@ include file="../header_and_footer/header.jsp" %>

<div class="dashboard-container">

    <div class="welcome-box text-center mb-4">
        <h2 class="fw-bold mb-0">Welcome Back, <span style="color:#0d6efd;"><%= fullName %></span></h2>
        <p class="mt-2 text-muted">Manage your services, profile & applications</p>
    </div>

<!-- BEGIN STATUS AREA -->
<% 
    if(hasApp){ 
        String statusClass = "";

        if("APPROVED".equalsIgnoreCase(appStatus)){
            statusClass = "alert-success";   // green
        } 
        else if("PENDING".equalsIgnoreCase(appStatus)){
            statusClass = "alert-warning";   // yellow
        } 
        else if("REJECTED".equalsIgnoreCase(appStatus)){
            statusClass = "alert-danger";    // red
        }
%>

    <div class="alert <%= statusClass %> p-4 text-center rounded-4 shadow-sm mb-4">
        <h4 class="fw-bold mb-2">
            <i class="fa-solid fa-clipboard-check"></i> Caregiver Application Status
        </h4>

        <h5 class="mb-2">
            <%= appStatus %>
        </h5>

        <small class="text-muted">
            Submitted: <%= submittedAt %>
        </small>
    </div>

<% } %>
<!-- END STATUS AREA -->



    <div class="row g-4">

        <!-- Edit Profile -->
        <div class="col-md-4">
            <a href="editProfile.jsp" class="text-decoration-none text-dark">
                <div class="feature-card text-center">
                    <i class="fa-solid fa-user-gear"></i>
                    <h5>Edit Profile</h5>
                </div>
            </a>
        </div>


        <!-- APPLY OR DISABLE -->
        <div class="col-md-4">
            <% if(!hasApp || "REJECTED".equalsIgnoreCase(appStatus)){ %>

                <a href="../caregiver_application/applyCaregiver.jsp" class="text-decoration-none text-dark">
                    <div class="feature-card text-center">
                        <i class="fa-solid fa-hand-holding-heart"></i>
                        <h5>Apply as Caregiver</h5>
                    </div>
                </a>

            <% } else { %>

                <a href="#" class="text-decoration-none text-dark" style="pointer-events:none;opacity:0.65;">
                    <div class="feature-card text-center">
                        <i class="fa-solid fa-ban"></i>
                        <h5>Application Submitted</h5>
                    </div>
                </a>

            <% } %>
        </div>


        <!-- Logout -->
        <div class="col-md-4">
            <a href="<%=request.getContextPath()%>/LogoutServlet" class="text-decoration-none text-dark">
                <div class="feature-card logout-card text-center">
                    <i class="fa-solid fa-power-off"></i>
                    <h5>Logout</h5>
                </div>
            </a>
        </div>

    </div>

</div>

<%@ include file="../header_and_footer/footer.html" %>

</body>
</html>


