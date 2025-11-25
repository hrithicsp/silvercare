<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.sql.*" %>
<%@ include file="header_and_footer/header.jsp" %>

<%
    // ------------------------------ CLIENT SESSION GUARD ------------------------------
    HttpSession s = request.getSession(false);

    if (s == null || !"CLIENT".equals(s.getAttribute("sessUserRole"))) {
        response.sendRedirect("clientLogin.jsp");
        return;
    }

    String loggedClient = (String) s.getAttribute("sessUserName");

    String message = "";
    String messageType = "";

    // ------------------------------ PROCESS FORM SUBMISSION ------------------------------
    if ("POST".equalsIgnoreCase(request.getMethod())) {

        String serviceName = request.getParameter("service_name");
        String ratingStr = request.getParameter("rating");
        String comments = request.getParameter("comments");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost/silvercare?user=root&password=1234&serverTimezone=UTC"
            );

            String sql = "INSERT INTO feedback (client_name, service_name, rating, comments) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, loggedClient);
            ps.setString(2, serviceName);
            ps.setInt(3, Integer.parseInt(ratingStr));
            ps.setString(4, comments);

            ps.executeUpdate();
            conn.close();

            message = "Thank you! Your feedback has been submitted.";
            messageType = "success";

        } catch(Exception e) {
            message = "Error: " + e.getMessage();
            messageType = "danger";
        }
    }

    // ------------------------------ FETCH SERVICES ------------------------------
    Connection conn2 = null;
    Statement stmtCat = null;
    Statement stmtSvc = null;
    ResultSet rsCat = null;
    ResultSet rsSvc = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn2 = DriverManager.getConnection(
            "jdbc:mysql://localhost/silvercare?user=root&password=root&serverTimezone=UTC"
        );

        stmtCat = conn2.createStatement();
        stmtSvc = conn2.createStatement();

        rsCat = stmtCat.executeQuery("SELECT * FROM service_category ORDER BY category_name ASC");

    } catch(Exception e){
        out.println("<p class='text-danger'>Error loading categories: " + e.getMessage() + "</p>");
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Submit Feedback | SilverCare</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
/* Blue Theme */
body {
    background: linear-gradient(145deg,#0d6efd,#0b5ed7);
    font-family: 'Poppins', sans-serif;
}

.form-box {
    background: white;
    padding: 35px;
    border-radius: 20px;
    max-width: 750px;
    margin: auto;
    margin-top: 50px;
    box-shadow: 0 14px 38px rgba(0,0,0,0.28);
}

/* Heading */
h2.text-success {
    color: #0d6efd !important;
}

/* Star Rating (Gold Stars) */
.star-rating {
  direction: rtl;
  display: inline-flex;
  gap: 6px;
  font-size: 1.8rem;
}
.star-rating input[type="radio"] { display:none; }
.star-rating label { 
    color:#ccc; 
    cursor:pointer; 
    transition:0.2s; 
}
.star-rating input[type="radio"]:checked ~ label { 
    color:#FFD700; 
}
.star-rating label:hover,
.star-rating label:hover ~ label { 
    color:#FFD700; 
}

/* Submit Button */
.btn-submit {
    background: #0d6efd !important;
    border: none !important;
    color: white !important;
    font-weight: 600;
    border-radius: 8px;
    padding: 10px;
    display: block;
}

.btn-submit:hover {
    background: #0b5ed7 !important;
}
</style>

</head>

<body>

<div class="form-box">

    <h2 class="fw-bold text-success text-center mb-2">Share Your Experience</h2>
    <p class="text-muted text-center">Your feedback helps us serve you better.</p>

    <% if (!message.equals("")) { %>
        <div class="alert alert-<%=messageType%> text-center">
            <%= message %>
        </div>
    <% } %>

    <form action="feedback.jsp" method="post">

        <!-- NAME -->
        <div class="mb-3">
            <label class="form-label fw-semibold">Your Name</label>
            <input class="form-control" value="<%=loggedClient%>" readonly>
        </div>

        <!-- SERVICE DROPDOWN -->
        <div class="mb-3">
            <label class="form-label fw-semibold">Service Received</label>
            <select name="service_name" class="form-select" required>
                <option value="">-- Select a service --</option>

                <%
                    while (rsCat != null && rsCat.next()) {
                        int catId = rsCat.getInt("category_id");
                        String catName = rsCat.getString("category_name");
                %>

                <option disabled style="font-weight:bold; background:#e9ecef;">--- <%=catName%> ---</option>

                <%
                        rsSvc = stmtSvc.executeQuery("SELECT * FROM service WHERE category_id=" + catId + " ORDER BY service_name ASC");
                        while (rsSvc.next()) {
                %>

                    <option value="<%= rsSvc.getString("service_name") %>">
                        &nbsp;&nbsp; <%= rsSvc.getString("service_name") %>
                    </option>

                <%
                        }
                    }
                %>
            </select>
        </div>

        <!-- STAR RATING -->
        <label class="form-label fw-semibold d-block">Rating</label>
		<div class="star-rating mb-3">
		    <input type="radio" id="star5" name="rating" value="5">
		    <label for="star5">&#9733;</label>

		    <input type="radio" id="star4" name="rating" value="4">
		    <label for="star4">&#9733;</label>

		    <input type="radio" id="star3" name="rating" value="3">
		    <label for="star3">&#9733;</label>

		    <input type="radio" id="star2" name="rating" value="2">
		    <label for="star2">&#9733;</label>

		    <input type="radio" id="star1" name="rating" value="1">
		    <label for="star1">&#9733;</label>
		</div>

        <!-- COMMENT -->
        <div class="mb-3">
            <label class="form-label fw-semibold">Comments</label>
            <textarea class="form-control" name="comments" rows="4" required></textarea>
        </div>

        <button class="btn-submit w-100 fw-semibold py-2">Submit Feedback</button>
    </form>

</div>

<%
    if (conn2 != null) conn2.close();
%>

<%@ include file="header_and_footer/footer.html" %>

</body>
</html>
