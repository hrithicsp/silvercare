<%@ page language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%
    HttpSession sessionUser = request.getSession(false);
    boolean loggedIn = (sessionUser != null && sessionUser.getAttribute("sessUserID") != null);
    String role = loggedIn ? (String) sessionUser.getAttribute("sessUserRole") : "";
    String userLang = (sessionUser != null && sessionUser.getAttribute("userLocale") != null)
        ? (String) sessionUser.getAttribute("userLocale") : "en";
    String returnUrl = request.getRequestURL().toString();
    if (request.getQueryString() != null && !request.getQueryString().isEmpty())
        returnUrl += "?" + request.getQueryString();
%>
<fmt:setLocale value="<%= userLang %>" scope="session" />
<fmt:setBundle basename="com.silvercare.i18n.messages" var="msg" />

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/js/all.min.js"></script>

<style>
    .font-btn {
        border: 1px solid #0d6efd;
        background: #eaf2ff;
        color: #0d6efd;
        padding: 4px 12px;
        margin-left: 6px;
        border-radius: 6px;
        font-weight: 600;
        cursor: pointer;
        font-size: 15px;
        transition: 0.2s;
    }
    .font-btn:hover {
        background: #0d6efd;
        color: white;
    }
    .lang-select {
        border: 1px solid #0d9488;
        background: #ccfbf1;
        color: #0f766e;
        padding: 4px 10px;
        margin-left: 6px;
        border-radius: 6px;
        font-weight: 600;
        font-size: 14px;
        cursor: pointer;
        max-width: 140px;
    }
    .lang-select:hover, .lang-select:focus {
        background: #0d9488;
        color: white;
        border-color: #0d9488;
    }
</style>


<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm sticky-top">
  <div class="container d-flex align-items-center">

    <!-- Logo -->
    <a class="navbar-brand fw-bold text-primary"
       href="<%=request.getContextPath()%>/home.jsp"
       style="font-size: 1.4rem;">
      SilverCare
    </a>

	<!-- Accessibility: Font Size + Language (form submits to SetLocaleServlet, page reloads in new language) -->
	<div class="d-flex align-items-center ms-3 flex-wrap gap-1">
	    <button class="font-btn" id="decreaseFont" title="Decrease text size">A-</button>
	    <button class="font-btn" id="increaseFont" title="Increase text size">A+</button>
	    <form action="<%=request.getContextPath()%>/SetLocaleServlet" method="get" class="d-inline" id="langForm">
	        <input type="hidden" name="returnUrl" value="<%= returnUrl %>" />
	        <select class="lang-select" name="lang" title="Change language" aria-label="Language" onchange="this.form.submit()">
	            <option value="en" <%= "en".equals(userLang) ? "selected" : "" %>>English</option>
	            <option value="zh" <%= "zh".equals(userLang) ? "selected" : "" %>>&#20013;&#25991;</option>
	            <option value="ms" <%= "ms".equals(userLang) ? "selected" : "" %>>Bahasa Melayu</option>
	            <option value="ta" <%= "ta".equals(userLang) ? "selected" : "" %>>&#2980;&#2990;&#3007;&#2992;&#3021;</option>
	        </select>
	    </form>
	</div>

    <!-- Burger button -->
    <button class="navbar-toggler ms-auto" type="button"
            data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto align-items-center">

        <% if (!loggedIn) { %>

            <!-- PUBLIC -->
            <li class="nav-item">
              <a class="nav-link fw-semibold"
                 href="<%=request.getContextPath()%>/home.jsp"><fmt:message key="nav.home" bundle="${msg}" /></a>
            </li>

            <li class="nav-item">
              <a class="nav-link fw-semibold"
                 href="<%=request.getContextPath()%>/client/serviceCategories.jsp"><fmt:message key="nav.services" bundle="${msg}" /></a>
            </li>

            <li class="nav-item">
                <a class="nav-link fw-semibold"
                   href="<%=request.getContextPath()%>/register.jsp"><fmt:message key="nav.register" bundle="${msg}" /></a>
            </li>

            <li class="nav-item ms-lg-2">
                <a class="btn btn-primary btn-sm fw-semibold px-3 py-2"
                   href="<%=request.getContextPath()%>/login.jsp"><fmt:message key="nav.login" bundle="${msg}" /></a>
            </li>

        <% } else { %>

            <% if (role.equalsIgnoreCase("ADMIN")) { %>

                <!-- ADMIN -->
                <li class="nav-item">
                    <a class="nav-link fw-semibold"
                       href="<%=request.getContextPath()%>/admin/adminDashboard.jsp"><fmt:message key="nav.dashboard" bundle="${msg}" /></a>
                </li>

            <% } else { %>

                <!-- CLIENT -->
                <li class="nav-item">
                  <a class="nav-link fw-semibold"
                     href="<%=request.getContextPath()%>/home.jsp"><fmt:message key="nav.home" bundle="${msg}" /></a>
                </li>

                <li class="nav-item">
                  <a class="nav-link fw-semibold"
                     href="<%=request.getContextPath()%>/client/serviceCategories.jsp"><fmt:message key="nav.services" bundle="${msg}" /></a>
                </li>

                <li class="nav-item">
                    <a class="nav-link fw-semibold"
                       href="<%=request.getContextPath()%>/client/clientDashboard.jsp"><fmt:message key="nav.dashboard" bundle="${msg}" /></a>
                </li>

                <li class="nav-item">
                    <a class="nav-link fw-semibold"
                       href="<%=request.getContextPath()%>/client/viewProfile.jsp"><fmt:message key="nav.profile" bundle="${msg}" /></a>
                </li>

            <% } %>

            <li class="nav-item ms-lg-2">
                <a class="btn btn-danger btn-sm fw-semibold px-3 py-2"
                   href="<%=request.getContextPath()%>/LogoutServlet"><fmt:message key="nav.logout" bundle="${msg}" /></a>
            </li>

        <% } %>

      </ul>
    </div>
  </div>
</nav>

<script>
    (function() {
        var currentSize = localStorage.getItem("fontSize")
            ? parseInt(localStorage.getItem("fontSize"), 10)
            : 100;
        document.body.style.fontSize = currentSize + "%";
        document.getElementById("increaseFont").onclick = function() {
            if (currentSize < 150) {
                currentSize += 10;
                document.body.style.fontSize = currentSize + "%";
                localStorage.setItem("fontSize", currentSize);
            }
        };
        document.getElementById("decreaseFont").onclick = function() {
            if (currentSize > 70) {
                currentSize -= 10;
                document.body.style.fontSize = currentSize + "%";
                localStorage.setItem("fontSize", currentSize);
            }
        };
    })();
</script>
