<%@ page language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession sessionUser = request.getSession(false);
    boolean loggedIn = (sessionUser != null && sessionUser.getAttribute("sessUserID") != null);
    String role = loggedIn ? (String) sessionUser.getAttribute("sessUserRole") : "";
%>

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
        border: 1px solid #0d6efd;
        background: #eaf2ff;
        color: #0d6efd;
        padding: 4px 10px;
        margin-left: 6px;
        border-radius: 6px;
        font-weight: 600;
        font-size: 14px;
        cursor: pointer;
        max-width: 140px;
    }
    .lang-select:hover, .lang-select:focus {
        background: #0d6efd;
        color: white;
        border-color: #0d6efd;
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

	<!-- Accessibility: Font Size + Language -->
	<div class="d-flex align-items-center ms-3 flex-wrap gap-1">
	    <button class="font-btn" id="decreaseFont" title="Decrease text size">A-</button>
	    <button class="font-btn" id="increaseFont" title="Increase text size">A+</button>
	    <select class="lang-select" id="langSelect" title="Change language" aria-label="Language">
	        <option value="en">English</option>
	        <option value="zh">&#20013;&#25991;</option>
	        <option value="ms">Bahasa Melayu</option>
	        <option value="ta">&#2980;&#2990;&#3007;&#2992;&#3021;</option>
	    </select>
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
              <a class="nav-link fw-semibold" data-i18n="nav.home"
                 href="<%=request.getContextPath()%>/home.jsp">Home</a>
            </li>

            <li class="nav-item">
              <a class="nav-link fw-semibold" data-i18n="nav.services"
                 href="<%=request.getContextPath()%>/client/serviceCategories.jsp">Services</a>
            </li>

            <li class="nav-item">
                <a class="nav-link fw-semibold" data-i18n="nav.register"
                   href="<%=request.getContextPath()%>/register.jsp">Register</a>
            </li>

            <li class="nav-item ms-lg-2">
                <a class="btn btn-primary btn-sm fw-semibold px-3 py-2" data-i18n="nav.login"
                   href="<%=request.getContextPath()%>/login.jsp">Login</a>
            </li>

        <% } else { %>

            <% if (role.equalsIgnoreCase("ADMIN")) { %>

                <!-- ADMIN -->
                <li class="nav-item">
                    <a class="nav-link fw-semibold" data-i18n="nav.dashboard"
                       href="<%=request.getContextPath()%>/admin/adminDashboard.jsp">Dashboard</a>
                </li>

            <% } else { %>

                <!-- CLIENT -->
                <li class="nav-item">
                  <a class="nav-link fw-semibold" data-i18n="nav.home"
                     href="<%=request.getContextPath()%>/home.jsp">Home</a>
                </li>

                <li class="nav-item">
                  <a class="nav-link fw-semibold" data-i18n="nav.services"
                     href="<%=request.getContextPath()%>/client/serviceCategories.jsp">Services</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link fw-semibold" data-i18n="nav.dashboard"
                       href="<%=request.getContextPath()%>/client/clientDashboard.jsp">Dashboard</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link fw-semibold" data-i18n="nav.profile"
                       href="<%=request.getContextPath()%>/client/viewProfile.jsp">Profile</a>
                </li>

            <% } %>

            <li class="nav-item ms-lg-2">
                <a class="btn btn-danger btn-sm fw-semibold px-3 py-2" data-i18n="nav.logout"
                   href="<%=request.getContextPath()%>/LogoutServlet">Logout</a>
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
    var i18n = {
        en: { "nav.home": "Home", "nav.services": "Services", "nav.register": "Register", "nav.login": "Login", "nav.dashboard": "Dashboard", "nav.profile": "Profile", "nav.logout": "Logout" },
        zh: { "nav.home": "\u9996\u9875", "nav.services": "\u670d\u52a1", "nav.register": "\u6ce8\u518c", "nav.login": "\u767b\u5f55", "nav.dashboard": "\u63a7\u5236\u677f", "nav.profile": "\u4e2a\u4eba\u8d44\u6599", "nav.logout": "\u9000\u51fa" },
        ms: { "nav.home": "Laman Utama", "nav.services": "Perkhidmatan", "nav.register": "Daftar", "nav.login": "Log Masuk", "nav.dashboard": "Papan Pemuka", "nav.profile": "Profil", "nav.logout": "Log Keluar" },
        ta: { "nav.home": "\u0bae\u0bc1\u0b95\u0bae\u0bcd", "nav.services": "\u0b9a\u0bc7\u0bb5\u0bc8\u0b95\u0bb3\u0bcd", "nav.register": "\u0baa\u0ba4\u0bbf\u0bb5\u0bc7\u0b9f\u0bcd", "nav.login": "\u0b89\u0bb3\u0bcd\u0bb3\u0bb5\u0bc1", "nav.dashboard": "\u0bae\u0bc1\u0b95\u0bbe\u0baa\u0bcd\u0baa\u0b9f\u0bcd\u0b9f\u0bbf", "nav.profile": "\u0b86\u0bb3\u0bcd\u0bb3\u0bae\u0bcd", "nav.logout": "\u0bb5\u0bc6\u0bb3\u0bbf\u0baf\u0bc1\u0bb0\u0bc1" }
    };
    function applyLang(code) {
        var t = i18n[code] || i18n.en;
        document.querySelectorAll("[data-i18n]").forEach(function(el) {
            var k = el.getAttribute("data-i18n");
            if (t[k]) el.textContent = t[k];
        });
    }
    function initLang() {
        var langSelect = document.getElementById("langSelect");
        if (langSelect) {
            var saved = localStorage.getItem("silvercareLang") || "en";
            langSelect.value = saved;
            applyLang(saved);
            langSelect.addEventListener("change", function() {
                var code = this.value;
                localStorage.setItem("silvercareLang", code);
                applyLang(code);
            });
        }
    }
    if (document.readyState === "loading") {
        document.addEventListener("DOMContentLoaded", initLang);
    } else {
        initLang();
    }
</script>
