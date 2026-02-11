package servlets;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import com.silvercare.dao.ServiceDAO;
import com.silvercare.model.Service;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ServiceServlet")
public class ServiceServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ServiceDAO dao = new ServiceDAO();
        try {
            // Fetch list of services from DB
            List<Service> serviceList = dao.getAllServices();
            // Store the list in the request object
            request.setAttribute("serviceList", serviceList);
            // Forward the request to the JSP view
            request.getRequestDispatcher("services.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}