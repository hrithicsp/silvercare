<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.sql.*" %>

<%
    // Admin Session Guard
    HttpSession s = request.getSession(false);
    if (s == null || !"ADMIN".equals(s.getAttribute("sessUserRole"))) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Client Feedback | Admin</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">

<style>

body {
    background: #e7f0ff;
    font-family: 'Poppins', sans-serif;
    min-height: 100vh;
}

.feedback-container {
    background: white;
    max-width: 1150px;
    padding: 40px;
    border-radius: 24px;
    margin: auto;
    margin-top: 50px;
    box-shadow: 0 12px 30px rgba(0,0,0,.15);
}

.feedback-card {
    border-radius: 18px;
    padding: 20px;
    transition: .25s ease;
    min-height: 240px;
    box-shadow: 0 6px 18px rgba(0,0,0,.10);
}
.feedback-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 12px 28px rgba(0,0,0,.15);
}

.star {
    color: #fbc02d;
    font-size: 1.1rem;
}

.page-title {
    color: #0d6efd;
    font-weight: 700;
}

</style>
</head>

<body>

<%@ include file="../header_and_footer/header.jsp" %>

<div class="feedback-container">

    <p class="mb-3">
        <a href="<%=request.getContextPath()%>/admin/adminDashboard.jsp" class="text-primary text-decoration-none">
            <i class="fa-solid fa-arrow-left me-1"></i> Back to Dashboard
        </a>
    </p>

    <h2 class="page-title mb-2">Client Feedback</h2>
    <p class="text-muted mb-4">View all feedback submitted by clients.</p>

    <div class="row g-4">
    <%
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    String feedbackError = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(
            "jdbc:mysql://localhost/silvercare?user=root&password=1234&serverTimezone=UTC"
        );
        stmt = conn.createStatement();
        rs = stmt.executeQuery("SELECT * FROM feedback ORDER BY feedback_id DESC");
        while (rs.next()) {
            int rating = rs.getInt("rating");
    %>
        <div class="col-md-4">
            <div class="feedback-card">
                <h5 class="fw-bold mb-1"><%= rs.getString("client_name") %></h5>
                <p class="fw-semibold text-primary mb-1">
                    <i class="fa-solid fa-hand-holding-medical me-1"></i>
                    <%= rs.getString("service_name") %>
                </p>
                <div class="mb-2">
                    <% for (int i = 1; i <= rating; i++) { %><i class="fa-solid fa-star star"></i><% } %>
                    <% for (int i = rating + 1; i <= 5; i++) { %><i class="fa-regular fa-star star"></i><% } %>
                </div>
                <p class="text-muted mb-2" style="min-height:60px;"><%= rs.getString("comments") %></p>
                <p class="text-secondary" style="font-size: .85rem;">
                    <i class="fa-regular fa-clock me-1"></i><%= rs.getTimestamp("submitted_at") %>
                </p>
            </div>
        </div>
    <%
        }
    } catch (Exception e) {
        feedbackError = e.getMessage();
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e2) {}
        try { if (stmt != null) stmt.close(); } catch (Exception e2) {}
        try { if (conn != null) conn.close(); } catch (Exception e2) {}
    }
    if (feedbackError != null) {
    %>
        <div class="col-12 text-center">
            <p class="text-danger fw-bold">Error: <%= feedbackError %></p>
        </div>
    <%
    }
    %>
    </div>
</div>

<%@ include file="../header_and_footer/footer.html" %>

</body>
</html>
