<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.silvercare.model.Service" %>
<%
    HttpSession s = request.getSession(false);
    if (s == null || !"ADMIN".equals(s.getAttribute("sessUserRole"))) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    Service svc = (Service) request.getAttribute("serviceToEdit");
    if (svc == null) {
        response.sendRedirect(request.getContextPath() + "/ServiceController?action=manageAdmin");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Edit Service | Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #e7f0ff; font-family: 'Poppins', sans-serif; }
        .form-container { background: white; padding: 40px; border-radius: 20px; max-width: 750px; margin: 55px auto; box-shadow: 0 12px 30px rgba(0,0,0,.12); }
    </style>
</head>
<body>
<%@ include file="../header_and_footer/header.jsp" %>
<div class="form-container">

    <p class="mb-3">
        <a href="<%=request.getContextPath()%>/ServiceController?action=manageAdmin" class="text-primary text-decoration-none">
            <i class="fa-solid fa-arrow-left me-1"></i> Back to Manage Services
        </a>
    </p>

    <h2 class="text-primary fw-bold mb-4">Edit Service</h2>
    <form method="post" action="<%=request.getContextPath()%>/ServiceController?action=update">
        <input type="hidden" name="service_id" value="<%= svc.getServiceId() %>">
        <div class="mb-3">
            <label class="form-label fw-semibold">Service Name</label>
            <input type="text" name="service_name" class="form-control" value="<%= svc.getServiceName() %>" required>
        </div>
        <div class="mb-3">
            <label class="form-label fw-semibold">Category ID</label>
            <input type="number" name="category_id" class="form-control" value="<%= svc.getCategoryId() %>" required>
        </div>
        <div class="mb-3">
            <label class="form-label fw-semibold">Price (SGD)</label>
            <input type="number" step="0.01" name="price" class="form-control" value="<%= svc.getPrice() %>" required>
        </div>
        <div class="mb-3">
            <label class="form-label fw-semibold">Image URL</label>
            <input type="text" name="image_path" class="form-control" value="<%= svc.getImagePath() %>">
        </div>
        <div class="mb-3">
            <label class="form-label fw-semibold">Description</label>
            <textarea name="description" class="form-control" rows="4" required><%= svc.getDescription() %></textarea>
        </div>
        <div class="d-flex justify-content-between mt-4">
            <a href="<%=request.getContextPath()%>/ServiceController?action=manageAdmin" class="btn btn-secondary">Back to Manage Services</a>
            <button type="submit" class="btn btn-primary">Update Service</button>
        </div>
    </form>
</div>

<%@ include file="../header_and_footer/footer.html" %>
</body>
</html>