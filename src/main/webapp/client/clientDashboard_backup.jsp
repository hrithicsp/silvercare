<%@ page language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession s = request.getSession(false);
    if(s == null || s.getAttribute("sessUserID") == null){
        response.sendRedirect("../clientLogin.jsp");
        return;
    }

    String fullName = (String) s.getAttribute("sessUserName");
%>

