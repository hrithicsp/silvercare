<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*, jakarta.servlet.http.*" %>

<%
    HttpSession s = request.getSession(false);
    if (s == null || s.getAttribute("sessUserID") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    int userId = (int) s.getAttribute("sessUserID");

    String fullname="", gender="", dob="", phone="", email="", address="",
           preferredContact="", techLevel="", notifEnabled="", interest="", createdAt="";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://localhost/silvercare?user=root&password=1234&serverTimezone=UTC"
        );

        PreparedStatement ps = conn.prepareStatement(
            "SELECT fullname, gender, dob, phone, email, address, preferred_contact, tech_level, notif_enabled, areas_of_interest, created_at FROM user WHERE user_id=?"
        );
        ps.setInt(1, userId);

        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            fullname = rs.getString("fullname");
            gender = rs.getString("gender");
            dob = rs.getString("dob");
            phone = rs.getString("phone");
            email = rs.getString("email");
            address = rs.getString("address");
            preferredContact = rs.getString("preferred_contact");
            techLevel = rs.getString("tech_level");
            notifEnabled = rs.getString("notif_enabled");
            interest = rs.getString("areas_of_interest");
            createdAt = rs.getString("created_at");
        }

        rs.close();
        ps.close();
        conn.close();

    } catch (Exception e) {
%>
        <p class="text-danger text-center fw-bold mt-4">Unable to load profile.</p>
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

    .profile-header h2 {
        font-weight:700;
        color:#0d6efd;
    }

    .label {
        font-weight:600;
        color:#0d6efd;
        width:200px;
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

    <div class="profile-header text-center mb-4">
        <h2><i class="fa-solid fa-user-circle me-2"></i> My Profile</h2>
        <p class="text-muted">Your account details</p>
    </div>

    <div>
        <p><span class="label">Full Name:</span> <%= fullname %></p>
        <p><span class="label">Email:</span> <%= email %></p>
        <p><span class="label">Phone:</span> <%= phone %></p>
        <p><span class="label">Gender:</span> <%= gender %></p>
        <p><span class="label">Date of Birth:</span> <%= dob %></p>
        <p><span class="label">Address:</span> <%= address %></p>
        <p><span class="label">Preferred Contact:</span> <%= preferredContact %></p>
        <p><span class="label">Tech Level:</span> <%= techLevel %></p>
        <p><span class="label">Notifications:</span> 
            <%= "1".equals(notifEnabled) ? "Enabled" : "Disabled" %>
        </p>
        <p><span class="label">Interests:</span> <%= interest %></p>
        <p><span class="label">Joined On:</span> <%= createdAt %></p>
    </div>

    <div class="mt-4 text-center">
        <a href="<%=request.getContextPath()%>/client/editProfile.jsp" class="btn-edit">
            <i class="fa-solid fa-pen-to-square me-1"></i> Edit Profile
        </a>
    </div>

</div>

<%@ include file="../header_and_footer/footer.html" %>

</body>
</html>
