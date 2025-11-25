<%@ page language="java"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession s = request.getSession(false);
    if(s == null || !"ADMIN".equals(s.getAttribute("sessUserRole"))){
        response.sendRedirect("../clientLogin.jsp");
        return;
    }

    String adminName = (String) s.getAttribute("sessUserName");

%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Admin Dashboard | SilverCare</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">

<style>

body{
    background: linear-gradient(145deg,#0d6efd,#1849b8);
    font-family:'Poppins',sans-serif;
    min-height:100vh;
}

/* Main card */
.dashboard-container{
    background:white;
    box-shadow:0 14px 38px rgba(0,0,0,.28);
    border-radius:24px;
    max-width:1150px;
    margin:auto;
    margin-top:50px;
    padding:3.2rem;
}

/* welcome message */
.welcome-box{
    background:#e7f0ff;
    padding:32px;
    border-radius:20px;
    margin-bottom:40px;
    text-align:center;
}

/* dashboard tiles */
.dash-card{
    background:white;
    border-radius:18px;
    padding:32px;
    text-align:center;
    transition:all .25s ease;
    box-shadow:0 5px 14px rgba(0,0,0,.12);
    height:100%;
}
.dash-card:hover{
    transform:translateY(-8px);
    box-shadow:0 10px 30px rgba(0,0,0,.16);
}

/* icons - BLUE THEME */
.dash-card i{
    font-size:40px;
    margin-bottom:15px;
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

    <div class="welcome-box">
        <h2 class="fw-bold m-0">Welcome, Admin <span style="color:#0d6efd;"><%= adminName %></span></h2>
        <p class="text-muted mt-2">Manage SilverCare system operations</p>
    </div>

    <div class="row g-4">

        <!-- View Clients -->
        <div class="col-md-4">
            <a href="viewClients.jsp" class="text-decoration-none text-dark">
                <div class="dash-card">
                    <i class="fa-solid fa-users"></i>
                    <h5 class="fw-bold mt-2">View Clients</h5>
                </div>
            </a>
        </div>

        <!-- Pending caregiver applications -->
        <div class="col-md-4">
            <a href="pendingCaregiver.jsp" class="text-decoration-none text-dark">
                <div class="dash-card">
                    <i class="fa-solid fa-user-clock"></i>
                    <h5 class="fw-bold mt-2">Pending Caregivers</h5>
                </div>
            </a>
        </div>

        <!-- Manage Services -->
        <div class="col-md-4">
            <a href="manageServices.jsp" class="text-decoration-none text-dark">
                <div class="dash-card">
                    <i class="fa-solid fa-list-check"></i>
                    <h5 class="fw-bold mt-2">Manage Services</h5>
                </div>
            </a>
        </div>

        <!-- Feedback -->
        <div class="col-md-4">
            <a href="viewFeedback.jsp" class="text-decoration-none text-dark">
                <div class="dash-card">
                    <i class="fa-solid fa-comments"></i>
                    <h5 class="fw-bold mt-2">Client Feedback</h5>
                </div>
            </a>
        </div>

        <!-- Logout -->
        <div class="col-md-4">
            <a href="<%=request.getContextPath()%>/LogoutServlet" class="text-decoration-none text-dark">
                <div class="dash-card logout-card">
                    <i class="fa-solid fa-power-off"></i>
                    <h5 class="fw-bold mt-2">Logout</h5>
                </div>
            </a>
        </div>

    </div>

</div>


<%@ include file="../header_and_footer/footer.html" %>

</body>
</html>
