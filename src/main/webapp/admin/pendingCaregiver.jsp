<%@ page import="java.sql.*, com.silvercare.util.DBConnection" %>

<%
Connection con = DBConnection.getConnection();
String sql = "SELECT * FROM caregiver_application WHERE status='PENDING'";
PreparedStatement pst = con.prepareStatement(sql);
ResultSet rs = pst.executeQuery();
%>

<!-- OUTER WRAPPER -->
<div class="container my-5">

    <!-- SECTION HEADER CARD -->
    <div class="card border-0 shadow-sm rounded-4 p-4 mb-4"
         style="background: linear-gradient(135deg, #00796B, #009688); color:white;">
        <h3 class="fw-bold mb-0">
            <i class="fa-solid fa-user-nurse me-2"></i> Pending Caregiver Applications
        </h3>
        <p class="mb-0 small opacity-75">Review and approve caregiver submissions</p>
    </div>

    <!-- MAIN DATA CARD -->
    <div class="card shadow-lg border-0 rounded-4 p-4">

        <div class="table-responsive">
        <table class="table table-borderless align-middle">

            <thead>
                <tr class="text-secondary fw-semibold" style="font-size: 0.9rem;">
                    <th>Name</th>
                    <th>Contact</th>
                    <th>Experience</th>
                    <th>Status</th>
                    <th class="text-center">Actions</th>
                </tr>
            </thead>

            <tbody class="table-group-divider">

            <%
            boolean hasData = false;
            while(rs.next()){
                hasData = true;
            %>

            <tr class="bg-light rounded-3 shadow-sm" style="--bs-table-bg: white;">
                <td class="py-3">
                    <div class="fw-bold"><%= rs.getString("full_name") %></div>
                    <div class="small text-muted"><%= rs.getString("email") %></div>
                </td>

                <td class="py-3">
                    <span class="badge rounded-pill text-bg-success px-3 py-2">
                        <i class="fa-solid fa-phone me-1"></i> <%= rs.getString("phone") %>
                    </span>
                </td>

                <td class="py-3">
                    <span class="badge bg-info text-dark rounded-pill px-3 py-2">
                        <%= rs.getInt("years_experience") %> yrs
                    </span>
                </td>

                <td class="py-3">
                    <span class="badge bg-warning text-dark rounded-pill px-3 py-2">
                        Pending Review
                    </span>
                </td>

                <td class="text-center py-3">

                    <!-- VIEW -->
                    <a href="viewApplication.jsp?id=<%=rs.getInt("application_id")%>"
                       class="btn btn-outline-primary btn-sm rounded-pill px-3 me-1">
                        <i class="fa-solid fa-eye me-1"></i> View
                    </a>

                    <!-- APPROVE -->
                    <a href="ApproveCaregiverServlet?id=<%=rs.getInt("application_id")%>"
                       class="btn btn-success btn-sm rounded-pill px-3 me-1"
                       onclick="return confirm('Approve this caregiver?');">
                        <i class="fa-solid fa-check"></i>
                    </a>

                    <!-- REJECT -->
                    <a href="RejectCaregiverServlet?id=<%=rs.getInt("application_id")%>"
                       class="btn btn-danger btn-sm rounded-pill px-3"
                       onclick="return confirm('Reject this caregiver?');">
                        <i class="fa-solid fa-xmark"></i>
                    </a>

                </td>
            </tr>

            <% } %>

            <% if(!hasData) { %>
                <tr>
                    <td colspan="5" class="text-center py-5">
                        <img src="https://cdn-icons-png.flaticon.com/512/4076/4076508.png"
                             width="80" class="mb-3" />
                        <h5 class="fw-bold text-muted">No Pending Applications</h5>
                        <p class="text-muted small">New applications will appear here.</p>
                    </td>
                </tr>
            <% } %>

            </tbody>

        </table>
        </div>

    </div>
</div>

<style>
.table-group-divider > tr {
    border-top: 12px solid #f5f5f5 !important;
}
.table-hover tbody tr:hover {
    background-color: #f0f8ff !important;
    transition: 0.25s ease;
}
</style>
