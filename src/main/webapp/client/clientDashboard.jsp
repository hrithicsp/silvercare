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

<style>
body{
    background:#E8F7F3;
    font-family: 'Poppins', sans-serif;
}
.dashboard-box{
    background:white;
    padding:40px;
    border-radius:18px;
    box-shadow:0 10px 30px rgba(0,0,0,0.12);
    max-width:900px;
    margin:auto;
    margin-top:40px;
}
h2 span{
    color:#00796B;
}
.card{
    border-radius:14px;
}
</style>

</head>

<body>

<%@ include file="../header_and_footer/header.html" %>

<div class="dashboard-box">
    
    <h2 class="fw-bold mb-3">Welcome back, <span><%= fullName %></span></h2>

    <div class="row g-4 mt-2">

        <div class="col-md-4">
            <a href="editProfile.jsp" class="text-decoration-none">
                <div class="card p-4 text-center">
                    <h5>Edit Profile</h5>
                </div>
            </a>
        </div>

        <div class="col-md-4">
            <a href="caregiverApply.jsp" class="text-decoration-none">
                <div class="card p-4 text-center">
                    <h5>Apply As Caregiver</h5>
                </div>
            </a>
        </div>

        <div class="col-md-4">
            <a href="LogoutServlet" class="text-decoration-none">
                <div class="card p-4 text-center">
                    <h5>Logout</h5>
                </div>
            </a>
        </div>
    </div>


</div>

<%@ include file="../header_and_footer/footer.html" %>

</body>
</html>