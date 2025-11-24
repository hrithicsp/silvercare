<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ include file="../header_and_footer/header.jsp" %>

<%
    // Admin guard
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
<title>Feedback Records | Admin</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">

<style>

body{
    background: linear-gradient(145deg,#00796B,#2E7D32);
    font-family:'Poppins',sans-serif;
    min-height:100vh;
}

/* Main container */
.feedback-container {
    background:white;
    padding:40px;
    border-radius:24px;
    max-width:1200px;
    margin:auto;
    margin-top:45px;
    margin-bottom:45px;
    box-shadow:0 14px 38px rgba(0,0,0,.25);
}

/* Page Header */
.page-title{
    color:#00796B;
    font-weight:700;
}

/* Feedback Card */
.feedback-card {
    border-radius:18px;
    padding:25px;
    min-height:230px;
    transition:all .25s ease;
    box-shadow:0 5px 14px rgba(0,0,0,.12);
    background:white;
}
.feedback-card:hover {
    transform:translateY(-6px);
    box-shadow:0 12px 32px rgba(0,0,0,.18);
}

/* Stars */
.feedback-rating i {
    color:#FFCA28;
    margin-right:2px;
    font-size:1.1rem;
}

/* Text formatting */
.client-name {
    font-size:1.2rem;
    font-weight:700;
}

.service-name {
    color:#00796B;
    font-weight:600;
    margin-bottom:5px;
}

.feedback-comment {
    color:#444;
    font-size:0.95rem;
    min-height:60px;
}

.feedback-time {
    font-size:0.85rem;
    color:#6c757d;
}
</style>

</head>

<body>

<div class="feedback-container">

    <!-- Page Title -->
    <div class="text-center mb-5">
        <h2 class="page-title">Client Feedback</h2>
        <p class="text-muted">Insights from clients and families</p>
    </div>

    <div class="row g-4">

<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://localhost/silvercare?user=root&password=1234&serverTimezone=UTC"
        );

        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM feedback ORDER BY feedback_id DESC");

        while(rs.next()){
            int rating = rs.getInt("rating");
%>

        <!-- Feedback Card -->
        <div class="col-md-4">
            <div class="feedback-card">

                <div class="client-name"><%= rs.getString("client_name") %></div>
                <div class="service-name"><%= rs.getString("service_name") %></div>

                <!-- Star Rating -->
                <div class="feedback-rating mb-2">
                    <% for(int i=1; i<=rating; i++) { %>
                        <i class="fa-solid fa-star"></i>
                    <% } %>
                    <% for(int i=rating+1; i<=5; i++) { %>
                        <i class="fa-regular fa-star"></i>
                    <% } %>
                </div>

                <!-- Comments -->
                <p class="feedback-comment">
                    <%= rs.getString("comments") %>
                </p>

                <!-- Date -->
                <p class="feedback-time">
                    <i class="fa-regular fa-clock me-1"></i>
                    <%= rs.getTimestamp("submitted_at") %>
                </p>

            </div>
        </div>

<%
        }

        conn.close();

    } catch(Exception e){
%>

        <div class="col-12 text-center">
            <p class="text-danger fw-bold">Error: <%= e.getMessage() %></p>
        </div>

<%
    }
%>

    </div> <!-- row end -->

</div> <!-- container end -->

<%@ include file="../header_and_footer/footer.html" %>

</body>
</html>
