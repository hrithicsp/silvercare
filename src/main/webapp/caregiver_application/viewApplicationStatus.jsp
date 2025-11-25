<%@ page import="java.sql.*, com.silvercare.util.DBConnection" %>

<%
int uid = (int) session.getAttribute("sessUserID");

Connection con = DBConnection.getConnection();
PreparedStatement pst = con.prepareStatement(
   "SELECT * FROM caregiver_application WHERE user_id=? ORDER BY submitted_at DESC LIMIT 1"
);
pst.setInt(1,uid);

ResultSet rs = pst.executeQuery();
%>

<% if(rs.next()){ %>

<h2>Status: <%= rs.getString("status") %></h2>

<% } else { %>

<h3>You have not submitted an application.</h3>

<% } %>