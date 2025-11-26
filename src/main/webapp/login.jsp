<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Login | SilverCare</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">

<style>
	:root{
	    --primary-teal:#00796B;
	    --dark-teal:#005a4d;
	    --light-teal:#E0F3EC;
	    --shadow:0 8px 22px rgba(0,0,0,0.16);
	}
	
	body {
	    font-family:'Poppins',sans-serif;
	    background:#eef5ff; 
	    min-height:100vh;
	    display:flex;
	    flex-direction:column;
	}
	
	.login-card {
	    background:white;
	    width:95%;
	    max-width:450px;
	    padding:2.8rem;
	    border-radius:20px;
	    margin:auto;
	    box-shadow: var(--shadow);
	    animation: fadeIn 0.5s ease;
	}
	
	h3 {
	    color:#0d6efd;
	}
	
	.btn-login {
	    background:#0d6efd !important;
	    color:white !important;
	    border:none !important;
	    font-weight:600;
	    border-radius:12px;
	    transition:0.25s ease;
	}
	
	.btn-login:hover {
	    background:#0b5ed7 !important;
	    color:white !important;
	}
	
	.login-card a {
	    color:#0d6efd;
	    font-weight:600;
	    text-decoration:none;
	}
	
	.login-card a:hover {
	    text-decoration:underline;
	}
	
	@keyframes fadeIn {
	    from {opacity:0; transform:translateY(20px);}
	    to   {opacity:1; transform:translateY(0);}
	}
</style>

</head>

<body>

<%@ include file="header_and_footer/header.jsp" %>

<div class="login-card mt-5">
    <h3 class="text-center fw-bold mb-4">
        <i class="fa-solid fa-right-to-bracket me-2"></i> Login
    </h3>

    <form action="<%=request.getContextPath()%>/LoginServlet" method="post">
        
        <div class="mb-3">
            <label class="form-label fw-semibold">Email</label>
            <input name="email" type="email" class="form-control" required />
        </div>
        
        <div class="mb-3">
            <label class="form-label fw-semibold">Password</label>
            <input name="password" type="password" class="form-control" required />
        </div>

        <button type="submit" class="btn btn-login w-100 py-2 mt-2">
            Login
        </button>
        
        <p class="mt-3 text-center">
            Don't have an account? 
            <a href="register.jsp">Register here</a>
        </p>
    </form>
</div>

<%@ include file="header_and_footer/footer.html" %>

</body>
</html>
