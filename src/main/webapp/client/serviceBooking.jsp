<%@ page import="java.sql.*" %>

<%
    // Must be logged in
    if (session.getAttribute("sessUserID") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int serviceId = Integer.parseInt(request.getParameter("service_id"));

    Class.forName("com.mysql.cj.jdbc.Driver");
    String connURL = "jdbc:mysql://localhost/silvercare?user=root&password=1234&serverTimezone=UTC";
    Connection conn = DriverManager.getConnection(connURL);

    // Get the service details
    String sqlService = "SELECT * FROM service WHERE service_id=?";
    PreparedStatement pstService = conn.prepareStatement(sqlService);
    pstService.setInt(1, serviceId);
    ResultSet rsService = pstService.executeQuery();
    rsService.next();

    String serviceName = rsService.getString("service_name");
    int categoryId = rsService.getInt("category_id");

    // Get category name
    String sqlCat = "SELECT category_name FROM service_category WHERE category_id=?";
    PreparedStatement pstCat = conn.prepareStatement(sqlCat);
    pstCat.setInt(1, categoryId);
    ResultSet rsCat = pstCat.executeQuery();
    rsCat.next();
    String categoryName = rsCat.getString("category_name");

    // Get APPROVED caregivers linked to this category
    String sqlCare = "SELECT * FROM caregiver_application WHERE status='APPROVED' AND interest_service=?";
    PreparedStatement pstCare = conn.prepareStatement(sqlCare);
    pstCare.setString(1, categoryName);
    ResultSet rsCare = pstCare.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Service</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
    .caregiver-img {
        width: 100%;
        max-height: 180px;
        object-fit: cover;
        border-radius: 10px;
    }
</style>

</head>

<body>

<%@ include file="../header_and_footer/header.jsp" %>

<div class="container py-5">
    <h2 class="fw-bold mb-4 text-primary">Book: <%= serviceName %></h2>

<form action="<%=request.getContextPath()%>/ServiceBookingServlet" method="post" class="p-4 bg-white shadow rounded">

    <!-- Hidden Fields -->
    <input type="hidden" name="service_id" value="<%= serviceId %>">
    <input type="hidden" name="user_id" value="<%= session.getAttribute("sessUserID") %>">

    <div class="mb-3">
        <label class="form-label fw-semibold">Select Date</label>
        <input type="date" name="date" class="form-control" required>
    </div>

    <div class="mb-3">
        <label class="form-label fw-semibold">Select Time</label>
        <input type="time" name="time" class="form-control" required>
    </div>

    <!-- Caregiver selection -->
    <div class="mb-3">
        <label class="form-label fw-bold">Choose a Caregiver</label>

        <div class="input-group">
            <select id="caregiverSelect" name="caregiver_id" class="form-select" required>
                <option value="">-- Select Caregiver --</option>

                <%
                    boolean has = false;
                    while (rsCare.next()) {
                        has = true;
                %>
                    <option 
                        value="<%= rsCare.getInt("application_id") %>"
                        data-fullname="<%= rsCare.getString("full_name") %>"
                        data-profile="<%= rsCare.getString("profile_photo") %>"
                        data-experience="<%= rsCare.getString("experience") %>"
                        data-years="<%= rsCare.getInt("years_experience") %>"
                        data-skills="<%= rsCare.getString("skills") %>"
                        data-cert="<%= rsCare.getString("certifications") %>"
                        data-availability="<%= rsCare.getString("availability_days") %>"
                        data-shift="<%= rsCare.getString("preferred_shift") %>"
                    >
                        <%= rsCare.getString("full_name") %> — <%= rsCare.getInt("years_experience") %> yrs
                    </option>
                <% 
                    }
                    if (!has) {
                %>
                    <option disabled>No caregivers available for this service category.</option>
                <% } %>
            </select>

            <button type="button" class="btn btn-outline-primary" id="viewDetailsBtn">
                View Details
            </button>
        </div>
    </div>

    <div class="mb-3">
        <label class="form-label fw-semibold">Notes (optional)</label>
        <textarea class="form-control" name="notes" rows="3"></textarea>
    </div>

    <button type="submit" class="btn btn-primary w-100">Confirm Booking</button>
</form>

</div>

<!-- MODAL -->
<div class="modal fade" id="caregiverModal" tabindex="-1">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">

      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title">Caregiver Details</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <div class="modal-body">

        <div class="row">
            <div class="col-md-4">
                <img id="cgPhoto" class="caregiver-img">
            </div>

            <div class="col-md-8">
                <h4 id="cgName" class="fw-bold text-primary"></h4>

                <p><strong>Experience:</strong> <span id="cgYears"></span> years</p>
                <p><strong>About:</strong> <span id="cgExp"></span></p>
                <p><strong>Skills:</strong> <span id="cgSkills"></span></p>
                <p><strong>Certifications:</strong> <span id="cgCert"></span></p>
                <p><strong>Availability:</strong> <span id="cgAvail"></span></p>
                <p><strong>Preferred Shift:</strong> <span id="cgShift"></span></p>
            </div>
        </div>

      </div>

    </div>
  </div>
</div>

<!-- SCRIPTS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
document.getElementById("viewDetailsBtn").addEventListener("click", function () {
    let select = document.getElementById("caregiverSelect");
    let opt = select.options[select.selectedIndex];

    if (select.value === "") {
        alert("Please select a caregiver first.");
        return;
    }

    // Fill modal data
    document.getElementById("cgName").innerText = opt.dataset.fullname;
    document.getElementById("cgYears").innerText = opt.dataset.years;
    document.getElementById("cgExp").innerText = opt.dataset.experience;
    document.getElementById("cgSkills").innerText = opt.dataset.skills;
    document.getElementById("cgCert").innerText = opt.dataset.cert;
    document.getElementById("cgAvail").innerText = opt.dataset.availability;
    document.getElementById("cgShift").innerText = opt.dataset.shift;

    let photo = opt.dataset.profile;
    document.getElementById("cgPhoto").src = (photo && photo !== "null")
        ? "../uploads/caregiver/" + photo
        : "https://via.placeholder.com/300x200";

    // Show modal
    let modal = new bootstrap.Modal(document.getElementById("caregiverModal"));
    modal.show();
});
</script>

<%@ include file="../header_and_footer/footer.html" %>

</body>
</html>
