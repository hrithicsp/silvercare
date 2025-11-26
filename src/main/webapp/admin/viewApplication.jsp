<%@ page import="java.sql.*, com.silvercare.util.DBConnection" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%
    String id = request.getParameter("id");

    if (id == null) {
        out.println("<h3 class='text-danger text-center mt-5'>Invalid application ID.</h3>");
        return;
    }

    Connection con = DBConnection.getConnection();
    PreparedStatement pst = con.prepareStatement(
        "SELECT * FROM caregiver_application WHERE application_id=?"
    );
    pst.setInt(1, Integer.parseInt(id));
    ResultSet rs = pst.executeQuery();

    if (!rs.next()) {
        out.println("<h3 class='text-danger text-center mt-5'>Application not found.</h3>");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Caregiver Application Details</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">

<style>
    body {
        background: #E8F7F3;
        font-family: 'Poppins', sans-serif;
    }
    .app-card {
        background: white;
        padding: 35px;
        border-radius: 18px;
        box-shadow: 0 10px 28px rgba(0,0,0,0.12);
        max-width: 900px;
        margin: 40px auto;
    }
    .profile-photo {
        width: 120px;
        height:120px;
        border-radius: 50%;
        object-fit: cover;
        border: 3px solid #00796B;
    }
    .info-label {
        font-weight: 600;
        color: #00796B;
    }
    .divider {
        border-bottom: 2px solid #e0e0e0;
        margin: 20px 0;
    }
    .btn-approve {
        background:#28a745;
        color:white;
        font-weight:600;
        border-radius: 10px;
    }
    .btn-reject {
        background:#dc3545;
        color:white;
        font-weight:600;
        border-radius: 10px;
    }
</style>
</head>

<body>

<div class="app-card">

    <h2 class="fw-bold text-primary mb-3">
        <i class="fa-solid fa-user-check me-2"></i>
        Caregiver Application Details
    </h2>

    <div class="text-center mb-4">
        <% if(rs.getString("profile_photo") != null) { %>
            <img src="<%=request.getContextPath()%>/uploads/caregiver/<%=rs.getString("profile_photo")%>"
                 class="profile-photo">
        <% } else { %>
            <img src="https://cdn-icons-png.flaticon.com/512/847/847969.png" class="profile-photo">
        <% } %>
        <h4 class="fw-bold mt-3"><%= rs.getString("full_name") %></h4>
    </div>

    <!-- Personal Information -->
    <div class="divider"></div>
    <h5 class="fw-bold text-dark">Personal Information</h5>

    <p><span class="info-label">Phone:</span> <%= rs.getString("phone") %></p>
    <p><span class="info-label">Email:</span> <%= rs.getString("email") %></p>
    <p><span class="info-label">Date of Birth:</span> <%= rs.getString("dob") %></p>
    <p><span class="info-label">Address:</span> <%= rs.getString("address") %></p>

    <!-- Experience -->
    <div class="divider"></div>
    <h5 class="fw-bold text-dark">Experience</h5>

    <p><span class="info-label">Years of Experience:</span> <%= rs.getInt("years_experience") %> years</p>
    <p><span class="info-label">Experience Description:</span><br> <%= rs.getString("experience") %></p>

    <!-- Skills -->
    <div class="divider"></div>
    <h5 class="fw-bold text-dark">Skills & Certifications</h5>

    <p><span class="info-label">Skills:</span> <%= rs.getString("skills") %></p>
    <p><span class="info-label">Certifications:</span> <%= rs.getString("certifications") %></p>

    <% if(rs.getString("cv_file") != null) { %>
        <p><span class="info-label">CV:</span> 
            <a href="<%=request.getContextPath()%>/uploads/caregiver/<%=rs.getString("cv_file")%>" target="_blank">
                View CV (PDF)
            </a>
        </p>
    <% } %>

    <!-- Availability -->
    <div class="divider"></div>
    <h5 class="fw-bold text-dark">Availability</h5>

    <p><span class="info-label">Days:</span> <%= rs.getString("availability_days") %></p>
    <p><span class="info-label">Preferred Shift:</span> <%= rs.getString("preferred_shift") %></p>

    <!-- Interest Service -->
    <div class="divider"></div>
    <h5 class="fw-bold text-dark">Service Interests</h5>

    <p><span class="info-label">Interested Service:</span> <%= rs.getString("interest_service") %></p>

    <!-- Action Buttons -->
    <div class="divider"></div>

    <div class="d-flex justify-content-center gap-3 mt-4">

        <a href="<%=request.getContextPath()%>/ApproveCaregiverServlet?id=<%= rs.getInt("application_id") %>"
           class="btn btn-approve px-4 py-2"
           onclick="return confirm('Approve this caregiver?');">
           <i class="fa-solid fa-check me-1"></i> Approve
        </a>

        <a href="<%=request.getContextPath()%>/RejectCaregiverServlet?id=<%= rs.getInt("application_id") %>"
           class="btn btn-reject px-4 py-2"
           onclick="return confirm('Reject this caregiver?');">
           <i class="fa-solid fa-xmark me-1"></i> Reject
        </a>

    </div>
</div>

</body>
</html>
