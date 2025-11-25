<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Client Details | SilverCare Admin</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">

<style>
    body {
        background: #f4f6fa;
        font-family: 'Poppins', sans-serif;
        min-height: 100vh;
    }

    .details-container {
        background: white;
        max-width: 850px;
        margin: 80px auto;
        padding: 45px 50px;
        border-radius: 20px;
        box-shadow: 0 8px 22px rgba(0,0,0,0.08);
        animation: fadeIn .4s ease;
    }

    h2 {
        font-weight: 700;
        color: #0d6efd;
        margin-bottom: 25px;
    }

    .details-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 18px 30px;
        margin-top: 10px;
    }

    .detail-item {
        background: #f9fafc;
        border: 1px solid #e5e8ec;
        padding: 14px 18px;
        border-radius: 10px;
    }

    .label {
        font-size: 0.85rem;
        font-weight: 600;
        color: #333;
        margin-bottom: 3px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .value {
        font-size: 1rem;
        color: #555;
    }

    .btn-back {
        display: inline-block;
        margin-top: 28px;
        padding: 10px 20px;
        border-radius: 10px;
        border: 2px solid #0d6efd;
        background: transparent;
        color: #0d6efd;
        font-weight: 600;
        transition: 0.25s ease;
        text-decoration: none;
    }

    .btn-back:hover {
        background: #0d6efd;
        color: white;
        transform: translateY(-2px);
    }

    @keyframes fadeIn {
        from { opacity:0; transform: translateY(20px); }
        to { opacity:1; transform: translateY(0); }
    }
</style>

</head>

<body>

<%@ include file="../header_and_footer/header.jsp" %>

<%
    String id = request.getParameter("id");
    Map<String,String> u = new HashMap<>();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://localhost/silvercare?user=root&password=1234&serverTimezone=UTC"
        );

        PreparedStatement ps = conn.prepareStatement("SELECT * FROM user WHERE user_id=?");
        ps.setString(1, id);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            u.put("name", rs.getString("fullname"));
            u.put("email", rs.getString("email"));
            u.put("phone", rs.getString("phone"));
            u.put("gender", rs.getString("gender"));
            u.put("dob", rs.getString("dob"));
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

<div class="details-container">

    <h2>
        <i class="fa-solid fa-user me-2"></i> <%= u.get("name") %>
    </h2>

    <div class="details-grid">

        <div class="detail-item">
            <div class="label">Email</div>
            <div class="value"><%= u.get("email") %></div>
        </div>

        <div class="detail-item">
            <div class="label">Phone</div>
            <div class="value"><%= u.get("phone") %></div>
        </div>

        <div class="detail-item">
            <div class="label">Gender</div>
            <div class="value"><%= u.get("gender") %></div>
        </div>

        <div class="detail-item">
            <div class="label">Date of Birth</div>
            <div class="value"><%= u.get("dob") %></div>
        </div>

        <div class="detail-item">
            <div class="label">Address</div>
            <div class="value"><%= u.get("address") %></div>
        </div>

        <div class="detail-item">
            <div class="label">Preferred Contact</div>
            <div class="value"><%= u.get("preferred_contact") %></div>
        </div>

        <div class="detail-item">
            <div class="label">Tech Level</div>
            <div class="value"><%= u.get("tech_level") %></div>
        </div>

        <div class="detail-item">
            <div class="label">Notifications</div>
            <div class="value"><%= u.get("notif_enabled") %></div>
        </div>

        <div class="detail-item" style="grid-column: span 2;">
            <div class="label">Areas of Interest</div>
            <div class="value"><%= u.get("areas_of_interest") %></div>
        </div>

        <div class="detail-item" style="grid-column: span 2;">
            <div class="label">Account Created</div>
            <div class="value"><%= u.get("created_at") %></div>
        </div>

    </div>

    <a href="<%=request.getContextPath()%>/admin/viewClients.jsp" class="btn-back">← Back to Clients</a>

</div>


<%@ include file="../header_and_footer/footer.html" %>

</body>
</html>
