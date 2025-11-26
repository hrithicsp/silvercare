<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*, java.util.*, jakarta.servlet.http.*" %>
<%
    HttpSession s = request.getSession(false);
    if (s == null || s.getAttribute("sessUserID") == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    int userId = (int) s.getAttribute("sessUserID");

    // If POST → process update
    if ("POST".equalsIgnoreCase(request.getMethod())) {

        String fullname = request.getParameter("fullname");
        String gender = request.getParameter("gender");
        String dob = request.getParameter("dob");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String preferred = request.getParameter("preferred_contact");
        int tech = Integer.parseInt(request.getParameter("tech_level"));
        boolean notif = request.getParameter("notif_enabled") != null;

        String[] interestsArr = request.getParameterValues("interests");
        String interests = (interestsArr != null) ? String.join(", ", interestsArr) : "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost/silvercare?user=root&password=1234&serverTimezone=UTC"
            );

            PreparedStatement ps = conn.prepareStatement(
                "UPDATE user SET fullname=?, gender=?, dob=?, phone=?, address=?, " +
                "preferred_contact=?, tech_level=?, notif_enabled=?, areas_of_interest=? " +
                "WHERE user_id=?"
            );

            ps.setString(1, fullname);
            ps.setString(2, gender);
            ps.setString(3, dob);
            ps.setString(4, phone);
            ps.setString(5, address);
            ps.setString(6, preferred);
            ps.setInt(7, tech);
            ps.setBoolean(8, notif);
            ps.setString(9, interests);
            ps.setInt(10, userId);

            ps.executeUpdate();
            conn.close();

            // Redirect back to dashboard with success message
            response.sendRedirect("clientDashboard.jsp?update=success");
            return;

        } catch (Exception e) {
%>
            <p class="text-danger text-center fw-bold">Error: <%= e.getMessage() %></p>
<%
        }
    }

    // If GET → load data
    Map<String,String> u = new HashMap<>();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://localhost/silvercare?user=root&password=1234&serverTimezone=UTC"
        );

        PreparedStatement ps = conn.prepareStatement("SELECT * FROM user WHERE user_id=?");
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            u.put("fullname", rs.getString("fullname"));
            u.put("gender", rs.getString("gender"));
            u.put("dob", rs.getString("dob"));
            u.put("phone", rs.getString("phone"));
            u.put("address", rs.getString("address"));
            u.put("preferred_contact", rs.getString("preferred_contact"));
            u.put("tech_level", rs.getString("tech_level"));
            u.put("notif_enabled", rs.getString("notif_enabled"));
            u.put("areas_of_interest", rs.getString("areas_of_interest"));
        }

        conn.close();
    } catch (Exception e) {
%>
    <p class="text-danger text-center fw-bold">Error loading profile.</p>
<%
    }
%>

<!DOCTYPE html>
<html>
<head>
<title>Edit Profile</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
    body { background:#eef5ff; font-family:'Poppins',sans-serif; }
    .edit-card {
        background:white; padding:35px;
        border-radius:18px; max-width:800px;
        margin:60px auto; box-shadow:0 10px 28px rgba(0,0,0,.18);
    }
</style>
</head>

<body>

<div class="edit-card">
<h3 class="fw-bold text-primary mb-3">Edit Profile</h3>

<form method="post">

<label class="fw-semibold">Full Name</label>
<input name="fullname" class="form-control mb-3" value="<%=u.get("fullname")%>" />

<label class="fw-semibold">Gender</label>
<select name="gender" class="form-select mb-3">
    <option <%= "Male".equals(u.get("gender"))?"selected":""%>>Male</option>
    <option <%= "Female".equals(u.get("gender"))?"selected":""%>>Female</option>
    <option <%= "Other".equals(u.get("gender"))?"selected":""%>>Other</option>
</select>

<label class="fw-semibold">DOB</label>
<input type="date" name="dob" class="form-control mb-3" value="<%=u.get("dob")%>" />

<label class="fw-semibold">Phone</label>
<input name="phone" class="form-control mb-3" value="<%=u.get("phone")%>" />

<label class="fw-semibold">Address</label>
<textarea name="address" class="form-control mb-3"><%=u.get("address")%></textarea>



<label class="fw-semibold">Areas of Interest</label>
<%
    String savedInterests = u.get("areas_of_interest") != null ? u.get("areas_of_interest") : "";
%>

<div class="d-flex flex-wrap gap-3 mb-3">

    <div class="form-check">
        <input class="form-check-input" type="checkbox" name="interests" value="Healthcare"
               <%= savedInterests.contains("Healthcare") ? "checked" : "" %>>
        <label class="form-check-label">Healthcare</label>
    </div>

    <div class="form-check">
        <input class="form-check-input" type="checkbox" name="interests" value="Meal Delivery"
               <%= savedInterests.contains("Meal Delivery") ? "checked" : "" %>>
        <label class="form-check-label">Meal Delivery</label>
    </div>

    <div class="form-check">
        <input class="form-check-input" type="checkbox" name="interests" value="Rehabilitation"
               <%= savedInterests.contains("Rehabilitation") ? "checked" : "" %>>
        <label class="form-check-label">Rehabilitation</label>
    </div>

</div>


<label class="fw-semibold">Preferred Contact</label>
<select name="preferred_contact" class="form-select mb-3">
    <option <%= "Phone".equals(u.get("preferred_contact"))?"selected":"" %>>Phone</option>
    <option <%= "SMS".equals(u.get("preferred_contact"))?"selected":"" %>>SMS</option>
    <option <%= "Email".equals(u.get("preferred_contact"))?"selected":"" %>>Email</option>
</select>

<label class="fw-semibold">Tech Level</label>
<input type="range" min="1" max="5" name="tech_level" class="form-range mb-3"
value="<%=u.get("tech_level")%>">

<label><input type="checkbox" name="notif_enabled"
<%= "1".equals(u.get("notif_enabled"))?"checked":"" %>> Enable Notifications</label>

<br><br>

<button class="btn btn-primary w-100">Save Changes</button>

</form>
</div>

</body>
</html>
