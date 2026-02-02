<%@ page language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    HttpSession sess = request.getSession(false);
    boolean isClient = (sess != null && "CLIENT".equals(sess.getAttribute("sessUserRole")));
    String ctx = request.getContextPath();
%>
<style>
  .footer-section {
      background: #f8f9fa;
      margin-top: 40px;
      padding-top: 50px;
      padding-bottom: 30px;
      border-top: 1px solid #e5e5e5;
      font-family: 'Poppins', sans-serif;
  }
  .footer-title {
      font-weight: 700;
      color: #0d6efd;
      margin-bottom: 16px;
  }
  .footer-links a {
      text-decoration: none;
      color: #0d6efd;
  }
  .footer-links a:hover {
      text-decoration: underline;
  }
  .footer-mini {
      font-size: 0.9rem;
      color: #6c757d;
  }
</style>

<footer class="footer-section">
  <div class="container">
    <div class="row">
      <div class="col-lg-4 col-md-6 mb-4">
        <h5 class="footer-title">SilverCare</h5>
        <p class="footer-mini">
          Compassionate eldercare services built on trust, respect, and dignity.
        </p>
      </div>
      <div class="col-lg-2 col-md-6 mb-4">
        <h6 class="footer-title">Quick Links</h6>
        <ul class="list-unstyled footer-links">
          <li class="mb-2"><a href="<%= ctx %>/home.jsp">Home</a></li>
          <li class="mb-2"><a href="<%= ctx %>/client/serviceCategories.jsp">Services</a></li>
          <% if (isClient) { %>
          <li class="mb-2"><a href="<%= ctx %>/client/clientDashboard.jsp">Dashboard</a></li>
          <li class="mb-2"><a href="<%= ctx %>/client/viewProfile.jsp">Profile</a></li>
          <% } %>
        </ul>
      </div>
      <div class="col-lg-3 col-md-6 mb-4">
        <h6 class="footer-title">Our Services</h6>
        <ul class="list-unstyled footer-mini">
          <li class="mb-2">Home Nursing</li>
          <li class="mb-2">Physiotherapy</li>
          <li class="mb-2">Meal Delivery</li>
          <li class="mb-2">Caregiver Support</li>
        </ul>
      </div>
      <div class="col-lg-3 col-md-6 mb-4">
        <h6 class="footer-title">Contact</h6>
        <ul class="list-unstyled footer-mini">
          <li class="mb-2"><i class="fas fa-home me-2"></i> 10 Tampines Central, Singapore 529536</li>
          <li class="mb-2"><i class="fas fa-envelope me-2"></i> info@silvercare.sg</li>
          <li class="mb-2"><i class="fas fa-phone me-2"></i> +65 6123 4567</li>
        </ul>
      </div>
    </div>
  </div>
  <div class="text-center p-3 footer-mini" style="background-color: rgba(0,0,0,0.03);">
    &copy; <span id="year"></span> SilverCare. All Rights Reserved.
  </div>
</footer>
<script>
  (function(){ var y = document.getElementById("year"); if(y) y.textContent = new Date().getFullYear(); })();
</script>
