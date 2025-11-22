<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Application Submitted - SilverCare</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
  <style>
    body { font-family: 'Poppins', sans-serif; background: linear-gradient(120deg,#6a11cb,#2575fc); margin:0; padding-top:80px; }
    .card-success { max-width:720px; margin: 3rem auto; border-radius:14px; box-shadow:0 12px 30px rgba(0,0,0,0.12); }
    .check-circle { width:84px; height:84px; border-radius:50%; background:#e9f8f0; display:flex; align-items:center; justify-content:center; margin: -42px auto 10px; border: 3px solid #27ae60; }
  </style>
</head>
<body>
  <%@ include file="../header_and_footer/header.html" %>

  <div class="card card-success p-4">
    <div class="card-body text-center">
      <div class="check-circle">
        <i class="fa-solid fa-check fa-2x" style="color:#27ae60"></i>
      </div>
      <h3 class="fw-bold">Application Submitted</h3>
      <p class="text-muted">Thank you for applying to be a caregiver at SilverCare. Your application has been received and is under review by our admin team.</p>

      <p class="small text-muted">What happens next:</p>
      <ul class="list-unstyled small text-muted">
        <li>- Admin will review your profile and documents.</li>
        <li>- You will receive an email if your application is accepted or if more information is required.</li>
      </ul>

      <a href="home.jsp" class="btn btn-primary mt-3">Return to Home</a>
      <a href="applyCaregiver.jsp" class="btn btn-link mt-3">Submit another application</a>
    </div>
  </div>

  <%@ include file="../header_and_footer/footer.html" %>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
