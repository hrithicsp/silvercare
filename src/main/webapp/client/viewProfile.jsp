<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*, java.util.*, jakarta.servlet.http.*" %>

<%
    HttpSession s = request.getSession(false);
    if (s == null || s.getAttribute("sessUserID") == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    int userId = (int) s.getAttribute("sessUserID");

    Map<String,String> u = new HashMap<>();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://localhost/silvercare?user=root&password=1234&serverTimezone=UTC"
        );

        PreparedStatement ps = conn.prepareStatement("SELECT * FROM user WHERE user_id=?");
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            u.put("fullname", rs.getString("fullname"));
            u.put("gender", rs.getString("gender"));
            u.put("dob", rs.getString("dob"));
            u.put("phone", rs.getString("phone"));
            u.put("email", rs.getString("email"));
            u.put("address", rs.getString("address"));
            u.put("preferred_contact", rs.getString("preferred_contact"));
            u.put("tech_level", rs.getString("tech_level"));
            u.put("notif_enabled", rs.getString("notif_enabled"));
            u.put("areas_of_interest", rs.getString("areas_of_interest"));
            u.put("created_at", rs.getString("created_at"));
        }

        conn.close();

    } catch (Exception e) {
%>
        <p class="text-danger text-center fw-bold mt-4">Error: <%= e.getMessage() %></p>
<%
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>My Profile | SilverCare</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">

<style>
    body {
        background:#eef5ff;
        font-family:'Poppins',sans-serif;
        min-height:100vh;
    }

    .profile-container {
        background:white;
        max-width:900px;
        margin:70px auto;
        padding:40px 50px;
        border-radius:24px;
        box-shadow:0 12px 35px rgba(0,0,0,0.15);
    }

    .profile-header {
        text-align:center;
        margin-bottom:30px;
    }

    .profile-header h2 {
        font-weight:700;
        color:#0d6efd;
    }

    .profile-row p {
        margin:8px 0;
        font-size:1rem;
    }

    .label {
        font-weight:600;
        color:#0d6efd;
        width:180px;
        display:inline-block;
    }

    .btn-edit {
        background:#0d6efd;
        color:white;
        padding:10px 18px;
        border-radius:10px;
        text-decoration:none;
        font-weight:600;
        transition:0.25s;
    }

    .btn-edit:hover {
        background:#0b5ed7;
        color:white;
        transform:translateY(-3px);
    }
</style>
</head>

<body>

<%@ include file="../header_and_footer/header.jsp" %>

<div class="profile-container">

    <div class="profile-header">
        <h2><i class="fa-solid fa-user-circle me-2"></i> My Profile</h2>
        <p class="text-muted">Your account information</p>
    </div>

    <div class="profile-row">
        <p><span class="label">Full Name:</span> <%=u.get("fullname")%></p>
        <p><span class="label">Email:</span> <%=u.get("email")%></p>
        <p><span class="label">Phone:</span> <%=u.get("phone")%></p>
        <p><span class="label">Gender:</span> <%=u.get("gender")%></p>
        <p><span class="label">Date of Birth:</span> <%=u.get("dob")%></p>
        <p><span class="label">Address:</span> <%=u.get("address")%></p>
        <p><span class="label">Preferred Contact:</span> <%=u.get("preferred_contact")%></p>
        <p><span class="label">Tech Level:</span> <%=u.get("tech_level")%></p>
        <p><span class="label">Notifications:</span> <%= "1".equals(u.get("notif_enabled")) ? "Enabled" : "Disabled" %></p>
        <p><span class="label">Interests:</span> <%=u.get("areas_of_interest")%></p>
        <p><span class="label">Joined On:</span> <%=u.get("created_at")%></p>
    </div>

    <div class="mt-4 text-center">
        <a href="editProfile.jsp" class="btn-edit">
            <i class="fa-solid fa-pen-to-square me-1"></i> Edit Profile
        </a>
    </div>

</div>

<%@ include file="../header_and_footer/footer.html" %>

</body>
</html>
