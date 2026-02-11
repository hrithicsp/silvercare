<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.silvercare.model.Service" %>
<%
    HttpSession s = request.getSession(false);
    if(s == null || !"ADMIN".equals(s.getAttribute("sessUserRole"))){
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Services | Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
    <style>
        body { background:#e7f0ff; font-family:'Poppins',sans-serif; }
        .services-container { background:white; padding:40px; border-radius:20px; max-width:1150px; margin:50px auto; box-shadow:0 12px 30px rgba(0,0,0,.12); }
        .service-card { background:white; border-radius:18px; overflow:hidden; transition:.25s ease; box-shadow:0 6px 18px rgba(0,0,0,.12); }
        .service-card img { width:100%; height:180px; object-fit:cover; }
        .btn-add { background:#0d6efd!important; color:white!important; font-weight:600; padding:10px 22px; border-radius:10px; }
    </style>
</head>
<body>
<%@ include file="../header_and_footer/header.jsp" %>
<div class="services-container">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold text-primary">Manage Services</h2>
        <a href="<%=request.getContextPath()%>/ServiceController?action=add" class="btn btn-add"><i class="fa-solid fa-plus me-1"></i> Add New Service</a>
    </div>

    <div class="row g-4 mt-1 mb-4">
        <%
            List<Service> adminList = (List<Service>) request.getAttribute("adminServiceList");
            if (adminList != null && !adminList.isEmpty()) {
                for (Service svc : adminList) {
        %>
        <div class="col-md-4">
            <div class="service-card">
                <img src="<%= svc.getImagePath() %>" alt="service">
                <div class="p-3">
                    <h5 class="fw-bold mb-1"><%= svc.getServiceName() %></h5>
                    <p class="text-muted small mb-2"><%= svc.getDescription() %></p>
                    <p class="fw-bold text-primary mb-3">$<%= String.format("%.2f", svc.getPrice()) %></p>
                    <div class="d-flex justify-content-between">
                        <%-- Links now point back to the Controller for actions --%>
                        <a href="<%=request.getContextPath()%>/ServiceController?action=editPage&id=<%= svc.getServiceId() %>" class="btn btn-warning btn-sm">Edit</a>
                        <a href="<%=request.getContextPath()%>/ServiceController?action=delete&id=<%= svc.getServiceId() %>" 
                           class="btn btn-danger btn-sm" onclick="return confirm('Delete this service?');">Delete</a>
                    </div>
                </div>
            </div>
        </div>
        <%
                }
            } else {
        %>
            <div class="col-12 text-center text-muted fst-italic">No services found. Please trigger the controller first.</div>
        <% } %>
    </div>
</div>
<%@ include file="../header_and_footer/footer.html" %>
</body>
</html>
