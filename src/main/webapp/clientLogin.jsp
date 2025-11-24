<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Client Login - SilverCare</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;600;700&display=swap" rel="stylesheet">

<style>
    body {
        font-family: 'Poppins', sans-serif;
        background: linear-gradient(135deg,#00796B,#43A047);
        min-height:100vh;
    }

    .login-card {
        background:white;
        width:95%;
        max-width:450px;
        padding:2.5rem;
        border-radius:18px;
        box-shadow:0 8px 20px rgba(0,0,0,0.15);
        margin:auto;
    }

    .btn-login {
        background:#00796B;
        border:none;
        font-weight:600;
    }
    
    .btn-login:hover {
        background:#005a4d;
    }
</style>
</head>
<body>

<%@ include file="header_and_footer/header.html" %>

<div class="login-card mt-5">
    <h3 class="text-center text-success fw-bold mb-4">Login</h3>

    <form action="/silvercare/LoginServlet" method="post">
        
        <div class="mb-3">
            <label class="form-label">Email</label>
            <input name="email" type="email" class="form-control" required />
        </div>
        
        <div class="mb-3">
            <label class="form-label">Password</label>
            <input name="password" type="password" class="form-control" required />
        </div>

        <button type="submit" class="btn btn-login w-100 py-2">Login</button>
        
        <p class="mt-3 text-center">
            Don't have account? <a href="register.jsp">Register here</a>
        </p>
    </form>
</div>

<%@ include file="header_and_footer/footer.html" %>

</body>
</html>
