<%@ page language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession s = request.getSession(false);
    if(s == null || s.getAttribute("sessUserID") == null){
        response.sendRedirect("../clientLogin.jsp");
        return;
    }

    String fullName = (String) s.getAttribute("sessUserName");
%>

<!DOCTYPE html>
<html>
<head>

<title>Client Dashboard - SilverCare</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">

<style>

body{
    background: linear-gradient(135deg,#00796B,#43A047);
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
    background:#E0F3EC;
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
    color:#00796B;
}
</style>
</head>

<body>

<%@ include file="../header_and_footer/header.jsp" %>

<div class="dashboard-container">

    <div class="welcome-box text-center mb-4">
        <h2 class="fw-bold mb-0">Welcome Back, <span style="color:#00796B"><%= fullName %></span></h2>
        <p class="mt-2 text-muted">Manage your services, profile & applications</p>
    </div>


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

        <!-- Apply As Caregiver -->
        <div class="col-md-4">
            <a href="../caregiver_application/applyCaregiver.jsp" class="text-decoration-none text-dark">
                <div class="feature-card text-center">
                    <i class="fa-solid fa-hand-holding-heart"></i>
                    <h5>Apply as Caregiver</h5>
                </div>
            </a>
        </div>

        <!-- Logout -->
        <div class="col-md-4">
            <a href="<%=request.getContextPath()%>/LogoutServlet" class="text-decoration-none text-dark">
                <div class="feature-card text-center">
                    <i class="fa-solid fa-door-open"></i>
                    <h5>Logout</h5>
                </div>
            </a>
        </div>

    </div>

</div>

<%@ include file="../header_and_footer/footer.html" %>

</body>
</html>

