<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Register - SilverCare</title>

  <!-- Bootstrap + icons + font -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">

  <style>
    html,body { height: 100%; }
    body {
      font-family: 'Poppins', sans-serif;
      background: linear-gradient(120deg, #6a11cb, #2575fc);
      margin: 0;
      display: block;
      -webkit-font-smoothing:antialiased;
      -moz-osx-font-smoothing:grayscale;
    }

    .register-container {
      background: #ffffff;
      border-radius: 18px;
      box-shadow: 0 12px 35px rgba(0,0,0,0.12);
      width: 95%;
      max-width: 760px;
      padding: 3rem 3.5rem;
      margin: 2rem auto 4rem;       /* centered with margin auto */
    }

    @media (max-width: 576px) {
      .register-container { padding: 1.5rem; }
    }

    .form-section-title {
      font-weight: 600;
      font-size: 1.08rem;
      margin-top: 1.6rem;
      margin-bottom: 0.6rem;
      color: #333;
      border-left: 4px solid #6a11cb;
      padding-left: 10px;
    }

    .btn-gradient {
      background: linear-gradient(90deg, #6a11cb, #2575fc);
      color: white;
      font-weight: 600;
      transition: transform .18s ease, opacity .18s ease;
    }
    .btn-gradient:hover { transform: translateY(-2px); opacity: 0.95; }

    .form-control:focus, .form-select:focus {
      border-color: #6a11cb;
      box-shadow: 0 0 0 0.15rem rgba(106,17,203,0.14);
    }
  </style>
</head>
<body>
  <%@ include file="header_and_footer/header.html" %>

  <main>
    <div class="register-container">
      <h3 class="text-center mb-3 fw-bold text-primary">Create Your SilverCare Account</h3>

      <form action="RegisterServlet" method="post" enctype="multipart/form-data" novalidate>
        <!-- Personal Info -->
        <h6 class="form-section-title">Personal Information</h6>
        <div class="row g-3">
          <div class="col-md-6">
            <label class="form-label">Full Name</label>
            <input type="text" name="fullname" class="form-control" placeholder="John Tan" required>
          </div>
          <div class="col-md-6">
            <label class="form-label">Gender</label>
            <select name="gender" class="form-select" required>
              <option value="">Select...</option><option>Male</option><option>Female</option><option>Other</option>
            </select>
          </div>
          <div class="col-md-6">
            <label class="form-label">Date of Birth</label>
            <input type="date" name="dob" class="form-control" required>
          </div>
          <div class="col-md-6">
            <label class="form-label">Phone Number</label>
            <input type="tel" name="phone" class="form-control" placeholder="81234567" pattern="[0-9]{8,}" required>
          </div>
          <div class="col-md-12">
            <label class="form-label">Upload Profile Photo</label>
            <input type="file" name="profilePic" class="form-control" accept=".jpg,.jpeg,.png">
          </div>
        </div>

        <!-- Account -->
        <h6 class="form-section-title">Account Details</h6>
        <div class="row g-3">
          <div class="col-12">
            <label class="form-label">Email</label>
            <input type="email" name="email" class="form-control" placeholder="example@mail.com" required>
          </div>
          <div class="col-md-6">
            <label class="form-label">Password</label>
            <input type="password" id="password" name="password" class="form-control" minlength="6" required>
          </div>
          <div class="col-md-6">
            <label class="form-label">Confirm Password</label>
            <input type="password" id="confirmPassword" class="form-control" required>
          </div>
          <div class="col-12">
            <label class="form-label">Preferred Contact Method</label>
            <select name="preferredContact" class="form-select">
              <option value="">Select...</option><option>Email</option><option>Phone</option><option>SMS</option>
            </select>
          </div>
        </div>

        <!-- Contact -->
        <h6 class="form-section-title">Contact Information</h6>
        <div class="mb-3">
          <label class="form-label">Address</label>
          <textarea name="address" class="form-control" rows="2" placeholder="123 Orchard Road, #05-10, Singapore" required></textarea>
        </div>

        <div class="mb-3">
          <label class="form-label">Areas of Interest</label>
          <div class="d-flex flex-wrap gap-3 mt-2">
            <div class="form-check"><input class="form-check-input" type="checkbox" name="interests" value="Healthcare"><label class="form-check-label">Healthcare</label></div>
            <div class="form-check"><input class="form-check-input" type="checkbox" name="interests" value="Meal Delivery"><label class="form-check-label">Meal Delivery</label></div>
            <div class="form-check"><input class="form-check-input" type="checkbox" name="interests" value="Rehabilitation"><label class="form-check-label">Rehabilitation</label></div>
          </div>
        </div>

        <h6 class="form-section-title">Additional Preferences</h6>
        <div class="mb-3">
          <label class="form-label">How tech-savvy are you?</label>
          <input type="range" name="techLevel" min="1" max="5" class="form-range">
        </div>

        <div class="form-check form-switch mb-3">
          <input class="form-check-input" type="checkbox" name="notif" id="notifSwitch">
          <label class="form-check-label" for="notifSwitch">Enable Notifications</label>
        </div>

        <div class="form-check mb-4">
          <input class="form-check-input" type="checkbox" required id="termsCheck">
          <label class="form-check-label" for="termsCheck">I agree to the Terms &amp; Conditions.</label>
        </div>

        <div class="d-grid">
          <button class="btn btn-gradient btn-lg" type="submit">Create Account</button>
        </div>

        <p class="text-center mt-3">Already have an account? <a href="clientLogin.jsp" class="text-primary">Login here</a>.</p>
      </form>
    </div>
  </main>

  <%@ include file="header_and_footer/footer.html" %>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    // simple password match check
    document.querySelector('form').addEventListener('submit', function(e){
      const p = document.getElementById('password').value;
      const c = document.getElementById('confirmPassword').value;
      if (p !== c) { e.preventDefault(); alert('Passwords do not match'); }
    });
  </script>
</body>
</html>

