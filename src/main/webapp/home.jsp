<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>SilverCare - Home</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
  <style>
	 body {
	  font-family: 'Poppins', sans-serif;
	  background-color: #f9fafb;
  	 }
    .hero {
      background: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url('images/elderly-care.jpg') center/cover no-repeat;
      height: 90vh;
      color: white;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      text-align: center;
    }
    .hero h1 {
      font-size: 3rem;
      font-weight: 700;
      animation: fadeInDown 1s ease;
    }
    .hero p {
      font-size: 1.25rem;
      max-width: 600px;
      animation: fadeInUp 1.2s ease;
    }
    @keyframes fadeInDown { from {opacity: 0; transform: translateY(-30px);} to {opacity:1; transform:translateY(0);} }
    @keyframes fadeInUp { from {opacity: 0; transform: translateY(30px);} to {opacity:1; transform:translateY(0);} }
    .service-card {
      transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    .service-card:hover {
      transform: translateY(-8px);
      box-shadow: 0 10px 20px rgba(0,0,0,0.15);
    }
  </style>
</head>
<body>
<%@ include file="header_and_footer/header.html" %>

<!-- Hero Banner -->
<section class="hero">
  <h1>Compassionate Elderly Care, Anytime.</h1>
  <p>Connecting families with trusted caregivers and wellness services.</p>
  <a href="services.jsp" class="btn btn-warning btn-lg mt-3 fw-semibold">Explore Our Services</a>
</section>

<!-- Featured Services -->
<div class="container py-5">
  <h2 class="text-center fw-bold mb-5">Popular Services</h2>
  <div class="row g-4">
    <div class="col-md-4">
      <div class="card service-card border-0 shadow-sm">
        <img src="images/homecare.jpg" class="card-img-top" alt="Home Care">
        <div class="card-body">
          <h5 class="card-title fw-bold">Home Nursing</h5>
          <p class="card-text text-muted">Professional nurses providing care at home.</p>
          <a href="service_detail.jsp?id=1" class="btn btn-outline-primary btn-sm">Learn More</a>
        </div>
      </div>
    </div>
    <div class="col-md-4">
      <div class="card service-card border-0 shadow-sm">
        <img src="images/physio.jpg" class="card-img-top" alt="Physiotherapy">
        <div class="card-body">
          <h5 class="card-title fw-bold">Physiotherapy</h5>
          <p class="card-text text-muted">Rehabilitation sessions to improve mobility and health.</p>
          <a href="service_detail.jsp?id=2" class="btn btn-outline-primary btn-sm">Learn More</a>
        </div>
      </div>
    </div>
    <div class="col-md-4">
      <div class="card service-card border-0 shadow-sm">
        <img src="images/meal.jpg" class="card-img-top" alt="Meal Delivery">
        <div class="card-body">
          <h5 class="card-title fw-bold">Healthy Meal Delivery</h5>
          <p class="card-text text-muted">Nutritious meals tailored for elderly dietary needs.</p>
          <a href="service_detail.jsp?id=3" class="btn btn-outline-primary btn-sm">Learn More</a>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Call-to-Action -->
<div class="text-center bg-light py-5">
  <h3>Ready to make caregiving easier?</h3>
  <p>Join SilverCare and access trusted homecare services today.</p>
  <a href="register.jsp" class="btn btn-primary btn-lg mt-2">Get Started</a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<%@ include file="header_and_footer/footer.html" %>
</body>
</html>
