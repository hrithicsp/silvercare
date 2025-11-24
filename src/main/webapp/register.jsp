<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Register - SilverCare</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">

  <style>
    /* --- 1. Brand Color Palette --- */
    :root {
      --primary-color: #00796B; /* The deep teal from homepage */
      --primary-color-light: rgba(0, 121, 107, 0.2); /* For focus glow */
      --light-gray-bg: #f9fafb;
      --text-dark: #343a40;
      --text-light: #6c757d;
    }

    /* --- 2. Body & Layout --- */
    html,body { height: 100%; }
    body {
      font-family: 'Poppins', sans-serif;
      background-color: var(--light-gray-bg); /* CHANGED: Consistent with homepage */
      margin: 0;
      -webkit-font-smoothing:antialiased;
      -moz-osx-font-smoothing:grayscale;
    }

    /* --- 3. Registration Form Container --- */
    .register-container {
      background: #ffffff;
      border-radius: 18px;
      box-shadow: 0 12px 35px rgba(0,0,0,0.08); /* Softened shadow */
      width: 95%;
      max-width: 760px;
      padding: 3rem 3.5rem;
      margin: 2rem auto 4rem;
    }

    @media (max-width: 576px) {
      .register-container { padding: 1.5rem; }
    }

    /* --- 4. Form Styling --- */
    .register-container .h3 {
      color: var(--primary-color); /* CHANGED: Brand color title */
    }
    
    .form-section-title {
      font-weight: 600;
      font-size: 1.08rem;
      margin-top: 1.6rem;
      margin-bottom: 0.8rem;
      color: var(--text-dark);
      border-left: 4px solid var(--primary-color); /* CHANGED: Brand color accent */
      padding-left: 10px;
    }

    /* --- 5. Button Styles --- */
    .btn-gradient {
      background: var(--primary-color); /* CHANGED: Solid brand color */
      border-color: var(--primary-color);
      color: white;
      font-weight: 600;
      transition: transform .18s ease, background-color .18s ease;
    }
    .btn-gradient:hover { 
      transform: translateY(-2px); 
      background-color: #005a4d; /* Darker teal for hover */
    }

    /* --- 6. Form Input & Icon Styles --- */
    .input-group-text {
      background-color: #f8f9fa;
      width: 42px; /* Fixed width for icon alignment */
      justify-content: center;
      color: var(--text-light);
      border-right: 0;
    }
    .input-group .form-control,
    .input-group .form-select {
      border-left: 0;
      padding-left: 0.5rem;
    }
    .input-group:focus-within .input-group-text {
      color: var(--primary-color);
      border-color: var(--primary-color);
    }
    .form-control:focus, .form-select:focus {
      border-color: var(--primary-color); /* CHANGED: Brand focus color */
      box-shadow: 0 0 0 0.15rem var(--primary-color-light); /* CHANGED: Brand focus glow */
      z-index: 3; /* Ensure input is on top */
    }

    /* --- 7. Links & Checkboxes --- */
    a {
      color: var(--primary-color);
      text-decoration: none;
      font-weight: 500;
    }
    a:hover {
      color: #005a4d;
      text-decoration: underline;
    }
    .form-check-input:checked {
        background-color: var(--primary-color);
        border-color: var(--primary-color);
    }
  </style>
</head>
<body>
  <%@ include file="header_and_footer/header.jsp" %>

  <main>
    <div class="register-container">
      <h3 class="text-center mb-3 fw-bold h3">Create Your SilverCare Account</h3>

      <form action="<%=request.getContextPath()%>/RegisterServlet" method="post" enctype="multipart/form-data" novalidate>
        <h6 class="form-section-title">Personal Information</h6>
        <div class="row g-3">
          <div class="col-md-6">
            <label class="form-label">Full Name</label>
            <div class="input-group">
              <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
              <input type="text" name="fullname" class="form-control" placeholder="John Tan" required>
            </div>
          </div>
          <div class="col-md-6">
            <label class="form-label">Gender</label>
            <div class="input-group">
              <span class="input-group-text"><i class="fa-solid fa-venus-mars"></i></span>
              <select name="gender" class="form-select" required>
                <option value="">Select...</option><option>Male</option><option>Female</option><option>Other</option>
              </select>
            </div>
          </div>
          <div class="col-md-6">
            <label class="form-label">Date of Birth</label>
            <div class="input-group">
              <span class="input-group-text"><i class="fa-solid fa-calendar-days"></i></span>
              <input type="date" name="dob" class="form-control" required>
            </div>
          </div>
          <div class="col-md-6">
            <label class="form-label">Phone Number</label>
            <div class="input-group">
              <span class="input-group-text"><i class="fa-solid fa-phone"></i></span>
              <input type="tel" name="phone" class="form-control" placeholder="81234567" pattern="[0-9]{8,}" required>
            </div>
          </div>
          <div class="col-md-12">
            <label class="form-label">Upload Profile Photo (Optional)</label>
            <div class="input-group">
                <span class="input-group-text"><i class="fa-solid fa-image"></i></span>
                <input type="file" name="profilePic" class="form-control" accept=".jpg,.jpeg,.png">
            </div>
          </div>
        </div>

        <h6 class="form-section-title">Account Details</h6>
        <div class="row g-3">
          <div class="col-12">
            <label class="form-label">Email</label>
            <div class="input-group">
              <span class="input-group-text"><i class="fa-solid fa-envelope"></i></span>
              <input type="email" name="email" class="form-control" placeholder="example@mail.com" required>
            </div>
          </div>
          <div class="col-md-6">
            <label class="form-label">Password</label>
            <div class="input-group">
              <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
              <input type="password" id="password" name="password" class="form-control" minlength="6" required>
            </div>
          </div>
          <div class="col-md-6">
            <label class="form-label">Confirm Password</label>
            <div class="input-group">
              <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
              <input type="password" id="confirmPassword" class="form-control" required>
            </div>
          </div>
          <div class="col-12">
            <label class="form-label">Preferred Contact Method</label>
            <div class="input-group">
              <span class="input-group-text"><i class="fa-solid fa-comments"></i></span>
              <select name="preferredContact" class="form-select">
                <option value="">Select...</option><option>Email</option><option>Phone</option><option>SMS</option>
              </select>
            </div>
          </div>
        </div>

        <h6 class="form-section-title">Contact Information</h6>
        <div class="mb-3">
          <label class="form-label">Address</label>
          <div class="input-group">
            <span class="input-group-text"><i class="fa-solid fa-location-dot"></i></span>
            <textarea name="address" class="form-control" rows="2" placeholder="123 Orchard Road, #05-10, Singapore" required></textarea>
          </div>
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
		
		  <div class="d-flex align-items-center gap-3">
		    <input type="range" name="techLevel" id="techRange" min="1" max="5" class="form-range" value="3" oninput="updateTechLabel(this.value)">
		
		    <span id="techValue" class="fw-bold" style="font-size:1.1rem;">3</span>
		  </div>
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
        
        <p class="text-center mt-3">Already have an account? <a href="clientLogin.jsp">Login here</a>.</p>
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
      if (p !== c) { 
        e.preventDefault(); 
        alert('Passwords do not match. Please re-enter.'); 
        document.getElementById('password').focus();
      }
    });
  </script>
  <script>
  	// To display slider value
	  function updateTechLabel(val){
	    document.getElementById("techValue").innerText = val;
	  }
  </script>
  
</body>
</html>