<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>SilverCare - Home</title>
  
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
  
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
  
  <style>
    /* --- 1. Custom Color Palette & Global Styles --- */
    :root {
      --primary-color: #00796B; /* A deep, trustworthy teal */
      --secondary-color: #FBC02D; /* A warm, friendly yellow */
      --light-gray-bg: #f9fafb;
      --text-dark: #343a40;
      --text-light: #6c757d;
    }
  
    body {
      font-family: 'Poppins', sans-serif;
      background-color: var(--light-gray-bg);
      color: var(--text-dark); /* Set a standard dark color */
    }

    /* --- 2. Hero Section Styles --- */
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
      font-size: 3.2rem; /* Slightly larger */
      font-weight: 700;
      animation: fadeInDown 1s ease;
    }
    .hero p {
      font-size: 1.25rem;
      max-width: 600px;
      animation: fadeInUp 1.2s ease;
    }
    
    /* --- 3. Custom Button Styles (Replaces Bootstrap defaults) --- */
    .btn-primary {
      background-color: var(--primary-color);
      border-color: var(--primary-color);
      font-weight: 500;
    }
    .btn-primary:hover {
      background-color: #005a4d; /* A darker shade for hover */
      border-color: #005a4d;
    }
    
    .btn-secondary {
      background-color: var(--secondary-color);
      border-color: var(--secondary-color);
      color: #333; /* Dark text on yellow for readability */
      font-weight: 500;
    }
    .btn-secondary:hover {
      background-color: #f9a825;
      border-color: #f9a825;
      color: #333;
    }

    /* --- 4. Service Card & Icon Styles --- */
    .service-card {
      border: none; /* Remove the default border */
      border-radius: 10px; /* Softer corners */
      box-shadow: 0 4px 12px rgba(0,0,0,0.05); /* Softer, more modern shadow */
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      height: 100%; /* Make cards in a row equal height */
    }
    .service-card:hover {
      transform: translateY(-8px);
      box-shadow: 0 10px 25px rgba(0,0,0,0.1); /* A more pronounced hover */
    }
    .service-card .card-title {
      color: var(--primary-color); /* Tie the card title to your brand color */
    }

    .icon-circle {
      display: inline-flex;
      align-items: center;
      justify-content: center;
      width: 60px;
      height: 60px;
      border-radius: 50%;
    }
    .bg-primary-subtle {
      background-color: #e0f2f1; /* A very light teal */
    }
    .bg-secondary-subtle {
      background-color: #fffde7; /* A very light yellow */
    }
    .text-secondary-emphasis {
      color: #f9a825;
    }

    /* --- 5. Call-to-Action (CTA) Section --- */
    .cta-section {
      background-color: var(--primary-color);
      color: white;
    }
    .cta-section h3 {
      font-weight: 700;
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
    
    /* --- 6. Animations --- */
    @keyframes fadeInDown { from {opacity: 0; transform: translateY(-30px);} to {opacity:1; transform:translateY(0);} }
    @keyframes fadeInUp { from {opacity: 0; transform: translateY(30px);} to {opacity:1; transform:translateY(0);} }
  </style>
</head>
<body>

<%@ include file="header_and_footer/header.jsp" %>

<section class="hero">
  <h1>Compassionate Elderly Care, Anytime.</h1>
  <p>Connecting families with trusted caregivers and wellness services.</p>
  <a href="<%=request.getContextPath()%>/client/serviceCategories.jsp" class="btn btn-secondary btn-lg mt-3 fw-semibold">Explore Our Services</a>
</section>

<div class="container py-5">
  <h2 class="text-center fw-bold mb-5">Popular Services</h2>
  <div class="row g-4">
    
    <div class="col-md-4">
      <div class="card service-card text-center p-3">
        <div class="icon-circle bg-primary-subtle text-primary mx-auto mb-3">
          <i class="bi bi-house-heart-fill fs-1"></i>
        </div>
        <div class="card-body p-0">
          <h5 class="card-title fw-bold">Home Nursing</h5>
          <p class="card-text text-muted">Professional nurses providing care at home.</p>
          <a href="service_detail.jsp?id=1" class="btn btn-primary btn-sm mt-2">Learn More</a>
        </div>
      </div>
    </div>
    
    <div class="col-md-4">
      <div class="card service-card text-center p-3">
        <div class="icon-circle bg-primary-subtle text-primary mx-auto mb-3">
          <i class="bi bi-bandaid-fill fs-1"></i> </div>
        <div class="card-body p-0">
          <h5 class="card-title fw-bold">Physiotherapy</h5>
          <p class="card-text text-muted">Rehabilitation sessions to improve mobility and health.</p>
          <a href="service_detail.jsp?id=2" class="btn btn-primary btn-sm mt-2">Learn More</a>
        </div>
      </div>
    </div>
    
    <div class="col-md-4">
      <div class="card service-card text-center p-3">
        <div class="icon-circle bg-primary-subtle text-primary mx-auto mb-3">
          <i class="bi bi-basket-fill fs-1"></i> </div>
        <div class="card-body p-0">
          <h5 class="card-title fw-bold">Healthy Meal Delivery</h5>
          <p class="card-text text-muted">Nutritious meals tailored for elderly dietary needs.</p>
          <a href="service_detail.jsp?id=3" class="btn btn-primary btn-sm mt-2">Learn More</a>
        </div>
      </div>
    </div>
  </div>
</div>

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

<div class="text-center cta-section py-5">
  <h3>Ready to make caregiving easier?</h3>
  <p>Join SilverCare and access trusted homecare services today.</p>
  <a href="register.jsp" class="btn btn-light-outline btn-lg mt-2">Get Started</a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<%@ include file="header_and_footer/footer.html" %>

</body>
</html>