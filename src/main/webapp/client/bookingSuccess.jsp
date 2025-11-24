<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Booking Successful - SilverCare</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">

    <style>
        body {
            background: #E8F7F3;
            font-family: 'Poppins', sans-serif;
        }

        .success-box {
            background: white;
            padding: 50px 30px;
            border-radius: 18px;
            max-width: 650px;
            margin: 80px auto;
            text-align: center;
            box-shadow: 0 10px 28px rgba(0, 0, 0, 0.12);
        }

        .success-icon {
            font-size: 70px;
            color: #2ecc71;
            margin-bottom: 15px;
        }

        .btn-home {
            background-color: #00796B;
            border-radius: 10px;
            font-weight: 600;
            padding: 12px 25px;
        }

        .btn-home:hover {
            background-color: #005f52;
        }
    </style>

</head>

<body>

<div class="success-box shadow">
    
    <i class="fa-solid fa-circle-check success-icon"></i>

    <h2 class="fw-bold text-success mb-2">Booking Confirmed!</h2>
    <p class="text-muted mb-4" style="font-size: 1.1rem;">
        Your appointment has been successfully scheduled.  
        Our caregiver team will contact you shortly.
    </p>

    <a href="<%=request.getContextPath()%>/client/clientDashboard.jsp" 
       class="btn btn-home text-white">
        <i class="fa-solid fa-arrow-left me-2"></i> Return to Dashboard
    </a>

</div>

</body>
</html>
