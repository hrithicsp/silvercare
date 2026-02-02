<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>SilverCare - Home</title>
  
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">

  <style>
	:root {
	  --primary-color: #0d6efd;
	  --primary-hover: #0b5ed7;
	  --secondary-color: #FBC02D;
	  --text-dark: #343a40;
	  --text-light: #6c757d;
	}

	body {
	  font-family: 'Poppins', sans-serif;
	  background:
	    radial-gradient(circle at top left, rgba(13,110,253,0.12), transparent 70%),
	    #ffffff;
	  color: var(--text-dark);
	}

	/* --- Hero Section --- */
	.hero {
	  height: 80vh;
	  background: linear-gradient(135deg, #0d6efd, #3a8ffd);
	  color: white;
	  display: flex;
	  flex-direction: column;
	  justify-content: center;
	  align-items: center;
	  text-align: center;
	  padding: 0 20px;
	  position: relative;
	}

	.hero::after {
	  content: "";
	  position: absolute;
	  bottom: -1px;
	  left: 0;
	  width: 100%;
	  height: 120px;
	  background: linear-gradient(to bottom, rgba(255,255,255,0), #f9fafb);
	}

	.hero h1 {
	  font-size: 3rem;
	  font-weight: 700;
	  margin-bottom: 10px;
	  animation: fadeDown 0.8s ease;
	}

	.hero p {
	  font-size: 1.2rem;
	  max-width: 600px;
	  opacity: 0.95;
	  animation: fadeUp 1s ease;
	}

	/* Animations */
	@keyframes fadeDown {
	  from {opacity: 0; transform: translateY(-25px);}
	  to   {opacity: 1; transform: translateY(0);}
	}

	@keyframes fadeUp {
	  from {opacity: 0; transform: translateY(25px);}
	  to   {opacity: 1; transform: translateY(0);}
	}

	/* --- Service Cards --- */
	.service-card {
	  border: none;
	  border-radius: 10px;
	  box-shadow: 0 4px 12px rgba(0,0,0,0.05);
	  transition: transform 0.3s ease, box-shadow 0.3s ease;
	  height: 100%;
	}
	.service-card:hover {
	  transform: translateY(-8px);
	  box-shadow: 0 10px 25px rgba(0,0,0,0.1);
	}
	.service-card .card-title {
	  color: var(--primary-color);
	}

	/* --- Icon Circle --- */
	.icon-circle {
	  display: inline-flex;
	  align-items: center;
	  justify-content: center;
	  width: 60px;
	  height: 60px;
	  border-radius: 50%;
	}
	.bg-primary-subtle {
	  background-color: #e6edff;
	}

	/* --- CTA Section --- */
	.cta-section {
	  background-color: var(--primary-color);
	  color: white;
	}
	.cta-section .btn-light-outline {
	  background-color: transparent;
	  border: 2px solid white;
	  color: white;
	  font-weight: 500;
	  transition: all 0.3s ease;
	}
	.cta-section .btn-light-outline:hover {
	  background-color: white;
	  color: var(--primary-color);
	}

	/* --- Floating Feedback Button --- */
	.floating-suggestion-btn {
	  position: fixed;
	  bottom: 28px;
	  right: 28px;
	  background: var(--primary-color);
	  color: white;
	  width: 58px;
	  height: 58px;
	  border-radius: 50%;
	  display: flex;
	  align-items: center;
	  justify-content: center;
	  font-size: 1.7rem;
	  box-shadow: 0 10px 25px rgba(0,0,0,0.2);
	  transition: all 0.25s ease;
	  z-index: 999;
	}
	.floating-suggestion-btn:hover {
	  background: var(--primary-hover);
	  transform: translateY(-5px);
	  box-shadow: 0 14px 30px rgba(0,0,0,0.28);
	}

  </style>
</head>
<body>

<%@ include file="header_and_footer/header.jsp" %>

<!-- HERO SECTION -->
<section class="hero">
  <h1>Compassionate Elderly Care, Anytime.</h1>
  <p>Connecting families with trusted caregivers and wellness services.</p>
  <a href="<%=request.getContextPath()%>/client/serviceCategories.jsp" class="btn btn-secondary btn-lg mt-3 fw-semibold">Explore Our Services</a>
</section>

<!-- ========================= -->
<!--  DYNAMIC POPULAR SERVICES -->
<!-- ========================= -->

<%
Class.forName("com.mysql.cj.jdbc.Driver");
String connURL = "jdbc:mysql://localhost/silvercare?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC&user=root&password=1234";
Connection conn = DriverManager.getConnection(connURL);

String sql = "SELECT service_id, service_name, description FROM service LIMIT 3";
PreparedStatement pst = conn.prepareStatement(sql);
ResultSet rs = pst.executeQuery();
%>

<div class="container py-5">
  <h2 class="text-center fw-bold mb-5">Popular Services</h2>

  <div class="row g-4">
    
    <% while(rs.next()) { %>

    <div class="col-md-4">
      <div class="card service-card text-center p-3">
        <div class="icon-circle bg-primary-subtle text-primary mx-auto mb-3">
          <i class="bi bi-heart-pulse-fill fs-1"></i>
        </div>

        <div class="card-body p-0">
          <h5 class="card-title fw-bold"><%= rs.getString("service_name") %></h5>
          <p class="card-text text-muted"><%= rs.getString("description") %></p>
        </div>
      </div>
    </div>

    <% } conn.close(); %>

  </div>
</div>

<!-- HOW IT WORKS -->
<div class="container py-5">
  <h2 class="text-center fw-bold mb-5">How SilverCare Works</h2>
  <div class="row text-center g-4">
    <div class="col-md-4">
      <div class="icon-circle bg-secondary-subtle text-secondary-emphasis mx-auto mb-3">
        <i class="bi bi-search fs-1"></i>
      </div>
      <h5 class="fw-bold">1. Find a Service</h5>
      <p class="text-muted px-3">Browse our curated list of professional care services.</p>
    </div>
    <div class="col-md-4">
      <div class="icon-circle bg-secondary-subtle text-secondary-emphasis mx-auto mb-3">
        <i class="bi bi-calendar-check fs-1"></i>
      </div>
      <h5 class="fw-bold">2. Book & Confirm</h5>
      <p class="text-muted px-3">Schedule a time that works for you and your family.</p>
    </div>
    <div class="col-md-4">
      <div class="icon-circle bg-secondary-subtle text-secondary-emphasis mx-auto mb-3">
        <i class="bi bi-shield-check fs-1"></i>
      </div>
      <h5 class="fw-bold">3. Receive Care</h5>
      <p class="text-muted px-3">A trusted and vetted professional provides the service.</p>
    </div>
  </div>
</div>

<!-- CTA -->
<div class="text-center cta-section py-5">
  <h3>Ready to make caregiving easier?</h3>
  <p>Join SilverCare and access trusted homecare services today.</p>
  <a href="<%=request.getContextPath()%>/register.jsp" class="btn btn-light-outline btn-lg mt-2">Get Started</a>
</div>

<!-- Floating Feedback Button -->
<a href="<%=request.getContextPath()%>/feedback.jsp" class="floating-suggestion-btn">
   <i class="bi bi-chat-dots-fill"></i>
</a>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<%@ include file="header_and_footer/footer.html" %>

</body>
</html>
