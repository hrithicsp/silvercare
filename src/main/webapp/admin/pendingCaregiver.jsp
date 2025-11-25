<%@ page import="java.sql.*, com.silvercare.util.DBConnection" %>

<%
Connection con = DBConnection.getConnection();
String sql = "SELECT * FROM caregiver_application WHERE status='PENDING'";
PreparedStatement pst = con.prepareStatement(sql);
ResultSet rs = pst.executeQuery();
%>

<div class="card shadow-sm p-4 mt-4">

    <h4 class="fw-bold text-dark mb-3">Pending Caregiver Applications</h4>

    <table class="table align-middle table-hover">
        <thead class="table-dark">
            <tr>
                <th>Name</th>
                <th>Phone</th>
                <th>Email</th>
                <th>Experience</th>
                <th class="text-center">Actions</th>
            </tr>
        </thead>

        <tbody>
        <% while(rs.next()){ %>
            <tr>
                <td class="fw-semibold"><%= rs.getString("full_name") %></td>
                <td><%= rs.getString("phone") %></td>
                <td><%= rs.getString("email") %></td>
                <td><%= rs.getString("years_experience") %> years</td>
                <td class="text-center">

                    <a href="viewApplication.jsp?id=<%=rs.getInt("application_id")%>" 
                       class="btn btn-outline-primary btn-sm me-1">
                        <i class="fa-solid fa-eye"></i> View
                    </a>

                    <a href="ApproveCaregiverServlet?id=<%=rs.getInt("application_id")%>" 
                       class="btn btn-success btn-sm me-1">
                        <i class="fa-solid fa-check"></i>
                    </a>

                    <a href="RejectCaregiverServlet?id=<%=rs.getInt("application_id")%>" 
                       class="btn btn-danger btn-sm">
                        <i class="fa-solid fa-xmark"></i>
                    </a>

                </td>
            </tr>
        <% } %>
        </tbody>
    </table>

</div>

<style>
.table-hover tbody tr:hover {
    background-color:#f0f8ff!important;
}
.btn-sm {
    padding: 4px 10px;
}
</style>
