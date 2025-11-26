<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.sql.*, com.silvercare.util.DBConnection" %>

<%
    // SESSION CHECK
    HttpSession session1 = request.getSession(false);
    if(session1 == null || session1.getAttribute("sessUserID") == null){
        response.sendRedirect("../clientLogin.jsp");
        return;
    }

    int uid = (int) session1.getAttribute("sessUserID");

    boolean alreadyApplied = false;

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try{
        con = DBConnection.getConnection();
        ps = con.prepareStatement("SELECT application_id, status FROM caregiver_application WHERE user_id=?");
        ps.setInt(1, uid);
        rs = ps.executeQuery();

        if(rs.next()){
            String status = rs.getString("status");

            // alreadyApplied = true ONLY if status is NOT rejected
            if (!"REJECTED".equalsIgnoreCase(status)) {
                alreadyApplied = true;
            }
        }
    }catch(Exception e){
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Apply as Caregiver - SilverCare</title>

  <!-- Bootstrap + icons + font -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">

  <link href="css/caregiver_styles.css" rel="stylesheet">
</head>

<body>
<%@ include file="../header_and_footer/header.jsp" %>

<main class="container my-5">

    <% if(alreadyApplied){ %>

        <div class="row justify-content-center mt-5">
            <div class="col-lg-7">

                <div class="alert alert-info p-5 text-center shadow rounded-4">
                    <h2 class="fw-bold mb-3">
                        <i class="fa-solid fa-circle-check"></i> Application Already Submitted
                    </h2>

                    <p class="text-muted fs-5 mb-4">
                        You have already submitted a caregiver application.<br>
                        You will be notified once the admin reviews your request.
                    </p>

                    <a href="../client/clientDashboard.jsp" class="btn btn-primary px-4">
                        Return to Dashboard
                    </a>
                </div>

            </div>
        </div>

    <% } else { %>

    <!-- FORM SECTION -->
	<div class="row justify-content-center">
      <div class="col-lg-10">
        <div class="card shadow-sm caregiver-card overflow-hidden">
          <div class="row g-0">
            <!-- Left: form -->
            <div class="col-md-7 p-4">
              <h2 class="fw-bold text-primary mb-1">Apply to be a Caregiver</h2>
              <p class="text-muted mb-3">Join SilverCare’s team of trusted caregivers. Fill in your details below — our admin team will review and contact you.</p>

              <form id="caregiverForm" action="<%=request.getContextPath()%>/ApplyCaregiverServlet" method="post" enctype="multipart/form-data" novalidate>
                <!-- Personal -->
                <h6 class="section-title">Personal Information</h6>
                <div class="row g-3">
                  <div class="col-md-6">
                    <label class="form-label">Full name</label>
                    <input type="text" name="fullname" class="form-control" placeholder="Jane Doe" required>
                  </div>
                  <div class="col-md-6">
                    <label class="form-label">Phone</label>
                    <input type="tel" name="phone" class="form-control" placeholder="81234567" pattern="[0-9]{8,}" required>
                  </div>
                  <div class="col-md-6">
                    <label class="form-label">Email</label>
                    <input type="email" name="email" class="form-control" placeholder="name@example.com" required>
                  </div>
                  <div class="col-md-6">
                    <label class="form-label">Date of birth</label>
                    <input type="date" name="dob" class="form-control" required>
                  </div>
                  <div class="col-12">
                    <label class="form-label">Address</label>
                    <input type="text" name="address" class="form-control" placeholder="123 Care St, #05-10" required>
                  </div>
                </div>

                <!-- Experience -->
                <h6 class="section-title mt-4">Care Experience</h6>
                <div class="mb-3">
                  <label class="form-label">Years of experience</label>
                  <input type="number" name="yearsExp" min="0" max="70" class="form-control" placeholder="e.g., 3">
                </div>

                <div class="mb-3">
                  <label class="form-label">Describe your experience (brief)</label>
                  <textarea name="experience" class="form-control" rows="3" placeholder="Describe types of care, elderly conditions, special skills..." required></textarea>
                </div>

                <!-- Skills -->
                <h6 class="section-title mt-4">Skills & Certifications</h6>
                <div class="mb-2 small text-muted">Tick any that apply</div>
                <div class="d-flex flex-wrap gap-3 mb-3">
                  <div class="form-check"><input class="form-check-input" type="checkbox" id="skill1" name="skills" value="Medication Management"><label class="form-check-label" for="skill1">Medication Management</label></div>
                  <div class="form-check"><input class="form-check-input" type="checkbox" id="skill2" name="skills" value="Wound Care"><label class="form-check-label" for="skill2">Wound Care</label></div>
                  <div class="form-check"><input class="form-check-input" type="checkbox" id="skill3" name="skills" value="Mobility Assistance"><label class="form-check-label" for="skill3">Mobility Assistance</label></div>
                  <div class="form-check"><input class="form-check-input" type="checkbox" id="skill4" name="skills" value="Nutrition Support"><label class="form-check-label" for="skill4">Nutrition Support</label></div>
                  <div class="form-check"><input class="form-check-input" type="checkbox" id="skill5" name="skills" value="CPR/First Aid"><label class="form-check-label" for="skill5">CPR / First Aid</label></div>
                </div>

                <div class="mb-3">
                  <label class="form-label">Certifications (list or brief)</label>
                  <input type="text" name="certifications" class="form-control" placeholder="e.g., Basic Nursing Course, CPR certificate">
                </div>

                <!-- Documents -->
                <h6 class="section-title mt-4">Supporting Documents</h6>
                <div class="mb-3">
                  <label class="form-label">Upload profile photo</label>
                  <input class="form-control" type="file" id="profilePic" name="profilePhoto" accept=".jpg,.jpeg,.png">
                  <div class="mt-2 small text-muted">Max 2MB. JPG/PNG.</div>
                  <div id="profilePreview" class="mt-2"></div>
                </div>

                <div class="mb-3">
                  <label class="form-label">Upload CV (PDF)</label>
                  <input class="form-control" type="file" name="cvFile" accept=".pdf">
                  <div class="mt-2 small text-muted">Optional but recommended.</div>
                </div>

				<!-- Interest -->
				<h6 class="section-title mt-4">Interest Area</h6>
				<div class="mb-3">
				  <label class="form-label">Which service would you like to work in?</label>
				
				  <div class="form-check">
				    <input class="form-check-input" type="radio" name="interest" value="Home Nursing" required>
				    <label class="form-check-label">Home Nursing</label>
				  </div>
				
				  <div class="form-check">
				    <input class="form-check-input" type="radio" name="interest" value="Physiotherapy">
				    <label class="form-check-label">Physiotherapy</label>
				  </div>
				
				  <div class="form-check">
				    <input class="form-check-input" type="radio" name="interest" value="Meal Delivery">
				    <label class="form-check-label">Meal Delivery</label>
				  </div>
				
				</div>

                <!-- Availability -->
                <h6 class="section-title mt-4">Availability</h6>
                <div class="row g-2 mb-3">
                  <div class="col-md-6">
                    <label class="form-label">Availability (days)</label>
                    <select name="availabilityDays" class="form-select">
                      <option value="">Select...</option>
                      <option>Weekdays</option>
                      <option>Weekends</option>
                      <option>Weekdays & Weekends</option>
                    </select>
                  </div>
                  <div class="col-md-6">
                    <label class="form-label">Preferred Shift</label>
                    <div class="d-flex gap-3 align-items-center mt-1">
                      <div class="form-check"><input class="form-check-input" type="radio" name="shift" value="Day" required><label class="form-check-label">Day</label></div>
                      <div class="form-check"><input class="form-check-input" type="radio" name="shift" value="Night"><label class="form-check-label">Night</label></div>
                      <div class="form-check"><input class="form-check-input" type="radio" name="shift" value="Flexible"><label class="form-check-label">Flexible</label></div>
                    </div>
                  </div>
                </div>

                <!-- Terms -->
                <div class="form-check mb-4">
                  <input class="form-check-input" type="checkbox" id="agreeCheck" required>
                  <label class="form-check-label" for="agreeCheck">I confirm that the information provided is accurate. I consent to SilverCare verifying my credentials.</label>
                </div>

                <div class="d-grid">
                  <button id="applyBtn" class="btn btn-primary btn-lg fw-semibold" type="submit">
                    <i class="fa-solid fa-paper-plane me-2"></i> Submit Application
                  </button>
                </div>

              </form>
            </div>

            <!-- Right: info panel -->
            <div class="col-md-5 bg-light p-4">
              <div style="top:90px;">
                <h5 class="fw-semibold">Why work with SilverCare?</h5>
                <ul class="small text-muted">
                  <li>Flexible shifts & fair pay</li>
                  <li>Access to continuous training</li>
                  <li>Supportive community and resources</li>
                </ul>

                <hr>

                <h6 class="fw-semibold">Tips for a strong application</h6>
                <ol class="small text-muted">
                  <li>Provide clear examples of past care experience</li>
                  <li>Upload relevant certifications (CPR, nursing)</li>
                  <li>Make your CV concise and legible</li>
                </ol>
              </div>
            </div>
          </div> <!-- row g-0 -->
        </div> <!-- card -->
      </div>
    </div>
    <% } %>

</main>

<%@ include file="../header_and_footer/footer.html" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/caregiver_form.js"></script>

</body>
</html>



