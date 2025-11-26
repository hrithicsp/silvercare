<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*, com.silvercare.util.DBConnection, jakarta.servlet.http.HttpSession" %>

<%
    HttpSession s = request.getSession(false);
    if(s == null || !"ADMIN".equals(s.getAttribute("sessUserRole"))){
        response.sendRedirect("../login.jsp");
        return;
    }

    Connection con = DBConnection.getConnection();
    String sql = "SELECT * FROM caregiver_application WHERE status='PENDING'";
    PreparedStatement pst = con.prepareStatement(sql);
    ResultSet rs = pst.executeQuery();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Caregiver Applications | SilverCare</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">

<style>

body{
    background: linear-gradient(145deg,#0d6efd,#1849b8);
    font-family:'Poppins',sans-serif;
    min-height:100vh;
}

.dashboard-container{
    background:white;
    box-shadow:0 14px 38px rgba(0,0,0,.28);
    border-radius:24px;
    max-width:1150px;
    margin:auto;
    margin-top:50px;
    padding:3rem;
}

.header-box{
    background:#e7f0ff;
    padding:28px;
    border-radius:20px;
    margin-bottom:35px;
    text-align:center;
}

.table thead{
    background:#0d6efd !important;
    color:white !important;
}
.table tbody tr:hover{
    background:#eef4ff;
    transition:0.25s ease;
}

.btn-approve{
    background:#198754;
    border:none;
}
.btn-approve:hover{
    background:#157347;
}

.btn-reject{
    background:#dc3545;
    border:none;
}
.btn-reject:hover{
    background:#bb2d3b;
}

</style>
</head>

<body>

<%@ include file="../header_and_footer/header.jsp" %>

<div class="dashboard-container">

    <!-- HEADER SECTION -->
    <div class="header-box">
        <h2 class="fw-bold m-0">
            <i class="fa-solid fa-user-nurse me-2"></i> Caregiver Applications
        </h2>
        <p class="text-muted mt-2">Review, approve or reject caregiver submissions</p>
    </div>

    <!-- APPLICATIONS TABLE -->
    <table class="table table-bordered table-hover align-middle shadow-sm">
        <thead>
            <tr>
                <th>Full Name</th>
                <th>Email</th>
                <th width="140">Phone</th>
                <th width="120">Experience</th>
                <th width="170" class="text-center">Action</th>
            </tr>
        </thead>

        <tbody>
            <%
            boolean hasData = false;
            while(rs.next()){
                hasData = true;
            %>

            <tr>
                <td><%= rs.getString("full_name") %></td>
                <td><%= rs.getString("email") %></td>
                <td><%= rs.getString("phone") %></td>

                <td>
                    <span class="badge bg-info text-dark px-3 py-2">
                        <%= rs.getInt("years_experience") %> years
                    </span>
                </td>

                <td class="text-center">
                    <!-- VIEW -->
                    <a href="viewApplication.jsp?id=<%=rs.getInt("application_id")%>"
                       class="btn btn-info btn-sm me-1">
                        <i class="fa-solid fa-eye me-1"></i> View
                    </a>
                </td>
            </tr>

            <% } %>

            <% if(!hasData){ %>
            <tr>
                <td colspan="5" class="text-center py-5">
                    <img src="https://cdn-icons-png.flaticon.com/512/4076/4076508.png"
                         width="80" class="mb-3" />
                    <h5 class="fw-bold text-muted">No Pending Applications</h5>
                    <p class="text-muted small">New caregiver applications will appear here.</p>
                </td>
            </tr>
            <% } %>

        </tbody>
    </table>

</div>

<%@ include file="../header_and_footer/footer.html" %>

</body>
</html>


