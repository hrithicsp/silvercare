<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*, java.util.*, jakarta.servlet.http.HttpSession" %>

<%
    HttpSession s = request.getSession(false);
    if(s == null || !"ADMIN".equals(s.getAttribute("sessUserRole"))){
        response.sendRedirect("../login.jsp");
        return;
    }

    String adminName = (String) s.getAttribute("sessUserName");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Client Records | SilverCare</title>

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
}

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

<%@ include file="../header_and_footer/header.jsp" %>

<div class="dashboard-container">

    <!-- HEADER BOX -->
    <div class="header-box">
        <h2 class="fw-bold m-0">
            <i class="fa-solid fa-users me-2"></i> Client Records
        </h2>
        <p class="text-muted mt-2">List of all registered SilverCare clients</p>
    </div>

<%
    List<Map<String,String>> list = new ArrayList<>();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://localhost/silvercare?user=root&password=1234&serverTimezone=UTC"
        );

        String sql = "SELECT user_id, fullname, email, phone, gender FROM user WHERE role = 'CLIENT'";
        PreparedStatement pst = conn.prepareStatement(sql);
        ResultSet rs = pst.executeQuery();

        while (rs.next()) {
            Map<String,String> c = new HashMap<>();
            c.put("id", rs.getString("user_id"));
            c.put("name", rs.getString("fullname"));
            c.put("email", rs.getString("email"));
            c.put("phone", rs.getString("phone"));
            c.put("gender", rs.getString("gender"));
            list.add(c);
        }

        conn.close();

    } catch (Exception e) {
%>
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
                <tr>
                    <td colspan="6" class="text-center text-muted fst-italic py-3">
                        No client records found.
                    </td>
                </tr>
            <% } else { %>

                <% for(Map<String,String> c : list){ %>
                <tr>
                    <td><%= c.get("id") %></td>
                    <td><%= c.get("name") %></td>
                    <td><%= c.get("email") %></td>
                    <td><%= c.get("phone") %></td>
                    <td><%= c.get("gender") %></td>

				<td>
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

<%@ include file="../header_and_footer/footer.html" %>

</body>
</html>
