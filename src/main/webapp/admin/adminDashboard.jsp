<%@ page language="java"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession s = request.getSession(false);
    if(s == null || !"ADMIN".equals(s.getAttribute("sessUserRole"))){
        response.sendRedirect("../clientLogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>

<title>Admin Dashboard - SilverCare</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
    background:#FFF2D8;
    font-family:Poppins,sans-serif;
}
.dashboard-box{
    background:white;
    padding:40px;
    border-radius:18px;
    box-shadow:0 10px 30px rgba(0,0,0,0.18);
    max-width:1000px;
    margin:auto;
    margin-top:40px;
}
h2 span{
    color:#B87333;
}
.card{
    border-radius:14px;
}
</style>

</head>

<body>

<%@ include file="../header_and_footer/header.jsp" %>

<div class="dashboard-box">

    <h2 class="fw-bold mb-4">Admin Control Panel</h2>

    <div class="row g-4">

        <div class="col-md-4">
            <a href="viewClients.jsp" class="text-decoration-none">
                <div class="card p-4 text-center">
                    <h5>View All Clients</h5>
                </div>
            </a>
        </div>

        <div class="col-md-4">
            <a href="pendingCaregiver.jsp" class="text-decoration-none">
                <div class="card p-4 text-center">
                    <h5>Pending Caregiver Applications</h5>
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
