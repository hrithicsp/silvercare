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
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Admin Dashboard | SilverCare</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">

<style>
    body {
        font-family: 'Poppins', sans-serif;
        background-color: #f8f9fa;
    }

    .dashboard-container {
        max-width: 900px;
        margin-top: 60px;
    }

    .dash-card {
        border-radius: 14px;
        transition: all 0.25s ease;
        cursor: pointer;
    }

    .dash-card:hover {
        transform: translateY(-6px);
        box-shadow: 0 12px 28px rgba(0,0,0,0.15);
    }

    .dash-icon {
        font-size: 2.4rem;
    }
</style>
</head>

<body>

<%@ include file="../header_and_footer/header.jsp" %>

<div class="container dashboard-container">

    <h2 class="fw-bold text-primary mb-2">Admin Dashboard</h2>
    <p class="text-muted mb-4">Welcome, <%= session.getAttribute("sessUserName") %>!</p>

    <div class="row g-4">

        <!-- Manage Services -->
        <div class="col-md-6">
            <a href="manageServices.jsp" class="text-decoration-none text-dark">
                <div class="card dash-card shadow-sm p-4">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="fw-bold mb-1">Manage Services</h5>
                            <p class="text-muted mb-0">Create, edit, and remove care services.</p>
                        </div>
                        <i class="fa-solid fa-list-check dash-icon text-primary"></i>
                    </div>
                </div>
            </a>
        </div>

        <!-- Caregiver Applications -->
        <div class="col-md-6">
            <a href="caregiverApplications.jsp" class="text-decoration-none text-dark">
                <div class="card dash-card shadow-sm p-4">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="fw-bold mb-1">Caregiver Applications</h5>
                            <p class="text-muted mb-0">Approve or reject caregiver applicants.</p>
                        </div>
                        <i class="fa-solid fa-user-check dash-icon text-success"></i>
                    </div>
                </div>
            </a>
        </div>

        <!-- Feedback -->
        <div class="col-md-6">
            <a href="viewFeedback.jsp" class="text-decoration-none text-dark">
                <div class="card dash-card shadow-sm p-4">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="fw-bold mb-1">Client Feedback</h5>
                            <p class="text-muted mb-0">View all feedback submissions.</p>
                        </div>
                        <i class="fa-solid fa-comments dash-icon text-warning"></i>
                    </div>
                </div>
            </a>
        </div>

        <!-- (Logout card removed) -->

    </div>
</div>

<%@ include file="../header_and_footer/footer.html" %>

</body>
</html>