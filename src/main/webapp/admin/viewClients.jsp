<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*, java.util.*, jakarta.servlet.http.HttpSession" %>

<%
    // Retrieve current session; ensure the user is logged in as ADMIN
    HttpSession s = request.getSession(false);

    // If no session or the role is not ADMIN → redirect to login
    if(s == null || !"ADMIN".equals(s.getAttribute("sessUserRole"))){
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    // Get the admin's display name (used if needed in header)
    String adminName = (String) s.getAttribute("sessUserName");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Client Records | SilverCare</title>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Icons -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">

<style>

/* Page background and general styling */
body{
    background: linear-gradient(145deg,#0d6efd,#1849b8);
    font-family:'Poppins',sans-serif;
    min-height:100vh;
}

/* White dashboard container */
.dashboard-container{
    background:white;
    box-shadow:0 14px 38px rgba(0,0,0,.28);
    border-radius:24px;
    max-width:1150px;
    margin:auto;
    margin-top:50px;
    padding:3rem;
}

/* Header box styling */
.header-box{
    background:#e7f0ff;
    padding:28px;
    border-radius:20px;
    margin-bottom:35px;
    text-align:center;
}

/* Table header styling */
.table thead{
    background:#0d6efd !important;
    color:white !important;
}

/* Hover effect on table rows */
.table tbody tr:hover{
    background:#eef4ff;
}

/* Custom info button styling */
.btn-info{
    background:#0d6efd;
    border:none;
}
.btn-info:hover{
    background:#0b5ed7;
}

</style>
</head>

<body>

<!-- Include global header -->
<%@ include file="../header_and_footer/header.jsp" %>

<div class="dashboard-container">

    <p class="mb-3">
        <a href="<%=request.getContextPath()%>/admin/adminDashboard.jsp" class="text-primary text-decoration-none">
            <i class="fa-solid fa-arrow-left me-1"></i> Back to Dashboard
        </a>
    </p>

    <div class="header-box">
        <h2 class="fw-bold m-0">
            <i class="fa-solid fa-users me-2"></i> Client Records
        </h2>
        <p class="text-muted mt-2">List of all registered SilverCare clients</p>
    </div>

<%
    // List to store all client records
    List<Map<String,String>> list = new ArrayList<>();

    try {
        // Load MySQL driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Connect to the database
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://localhost/silvercare?user=root&password=1234&serverTimezone=UTC"
        );

        // SQL query to retrieve all CLIENT users
        String sql = "SELECT user_id, fullname, email, phone, gender FROM user WHERE role = 'CLIENT'";
        PreparedStatement pst = conn.prepareStatement(sql);
        ResultSet rs = pst.executeQuery();

        // Loop through result set and store each client into a map
        while (rs.next()) {
            Map<String,String> c = new HashMap<>();
            c.put("id", rs.getString("user_id"));
            c.put("name", rs.getString("fullname"));
            c.put("email", rs.getString("email"));
            c.put("phone", rs.getString("phone"));
            c.put("gender", rs.getString("gender"));
            list.add(c);
        }

        // Close the DB connection
        conn.close();

    } catch (Exception e) {
%>
        <!-- Display error if database loading fails -->
        <p class="text-danger fw-bold text-center">Error loading users: <%= e.getMessage() %></p>
<%
    }
%>

    <!-- CLIENT TABLE -->
    <table class="table table-bordered table-hover align-middle shadow-sm">
        <thead>
            <tr>
                <th width="60">ID</th>
                <th>Full Name</th>
                <th>Email</th>
                <th width="150">Phone</th>
                <th width="100">Gender</th>
                <th width="130">Action</th>
            </tr>
        </thead>

        <tbody>

            <% if(list.size() == 0){ %>

                <!-- Show message when no client records exist -->
                <tr>
                    <td colspan="6" class="text-center text-muted fst-italic py-3">
                        No client records found.
                    </td>
                </tr>

            <% } else { %>

                <!-- Loop through each client and display as a table row -->
                <% for(Map<String,String> c : list){ %>

                <tr>
                    <td><%= c.get("id") %></td>
                    <td><%= c.get("name") %></td>
                    <td><%= c.get("email") %></td>
                    <td><%= c.get("phone") %></td>
                    <td><%= c.get("gender") %></td>

                    <td>
                        <!-- Link to full details page -->
                        <a href="<%=request.getContextPath()%>/admin/clientDetails.jsp?id=<%= c.get("id") %>" 
                           class="btn btn-info btn-sm w-100">
                           More Info
                        </a>
                    </td>
                </tr>

                <% } %>
            <% } %>

        </tbody>
    </table>

</div>

<!-- Include global footer -->
<%@ include file="../header_and_footer/footer.html" %>

</body>
</html>

