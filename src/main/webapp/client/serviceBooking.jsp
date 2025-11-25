<%@ page import="java.sql.*" %>

<%
    if (session.getAttribute("sessUserID") == null) {
        response.sendRedirect("clientLogin.jsp");
        return;
    }

    int serviceId = Integer.parseInt(request.getParameter("service_id"));

    Class.forName("com.mysql.cj.jdbc.Driver");
    String connURL = "jdbc:mysql://localhost/silvercare?user=root&password=1234&serverTimezone=UTC";
    Connection conn = DriverManager.getConnection(connURL);

    String sql = "SELECT * FROM service WHERE service_id=?";
    PreparedStatement pst = conn.prepareStatement(sql);
    pst.setInt(1, serviceId);

    ResultSet rs = pst.executeQuery();
    rs.next();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Service</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<%@ include file="../header_and_footer/header.jsp" %>

<div class="container py-5">
    <h2 class="fw-bold mb-4">Book: <%= rs.getString("service_name") %></h2>

<form action="<%=request.getContextPath()%>/ServiceBookingServlet" method="post" class="p-4 bg-white shadow rounded">

    <!-- MUST HAVE BOTH HIDDEN FIELDS -->
    <input type="hidden" name="service_id" value="<%= serviceId %>">
    <input type="hidden" name="user_id" value="<%= session.getAttribute("sessUserID") %>">

    <div class="mb-3">
        <label class="form-label">Select Date</label>
        <input type="date" name="date" class="form-control" required>
    </div>

    <div class="mb-3">
        <label class="form-label">Select Time</label>
        <input type="time" name="time" class="form-control" required>
    </div>

    <div class="mb-3">
        <label class="form-label">Notes (optional)</label>
        <textarea class="form-control" name="notes" rows="3"></textarea>
    </div>

    <button type="submit" class="btn btn-primary w-100">Confirm Booking</button>
</form>

</div>

<%@ include file="../header_and_footer/footer.html" %>

</body>
</html>
