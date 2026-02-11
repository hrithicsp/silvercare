package servlets;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import com.silvercare.dao.ServiceDAO;
import com.silvercare.model.Service;
import com.silvercare.model.Category;
import com.silvercare.model.Caregiver;

@WebServlet("/ServiceController")
public class ServiceControllerServlet extends HttpServlet {
    
    private ServiceDAO dao = new ServiceDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "listClient"; // Default action

        try {
            switch (action) {
                case "add": // FIX: Now correctly routes to the add form
                    showAddForm(request, response);
                    break;
                case "listClient": // For clients viewing a category
                    listServicesForClient(request, response);
                    break;
                case "manageAdmin": // For admin viewing all services
                    listServicesForAdmin(request, response);
                    break;
                case "delete": // Admin deleting
                    deleteService(request, response);
                    break;
                case "loadCategories": // Load category page
                    List<Category> catList = dao.getAllCategories();
                    request.setAttribute("categoryList", catList);
                    request.getRequestDispatcher("client/serviceCategories.jsp").forward(request, response);
                    break;
                case "editPage": // Show the edit form with pre-filled data
                    showEditForm(request, response);
                    break;
                case "bookPage":
                    showBookingPage(request, response);
                    break;
                default:
                    listServicesForClient(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred.");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if ("add".equals(action)) {
                addService(request, response);
            } else if ("update".equals(action)) {
                updateService(request, response);
            } else if ("book".equals(action)) { // Logic to process the booking
                processBooking(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while saving.");
        }
    }

    // --- Action Methods ---

    // FIX: Added showAddForm method to properly forward the user to the blank JSP
    private void showAddForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.getRequestDispatcher("admin/addService.jsp").forward(request, response);
    }

    private void listServicesForClient(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int catId = Integer.parseInt(request.getParameter("category_id"));
        List<Service> list = dao.getServicesByCategory(catId);
        request.setAttribute("serviceList", list);
        request.getRequestDispatcher("client/services.jsp").forward(request, response);
    }

    private void listServicesForAdmin(HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<Service> list = dao.getAllServices();
        request.setAttribute("adminServiceList", list);
        request.getRequestDispatcher("admin/manageServices.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        Service existingService = dao.getServiceById(id); 
        request.setAttribute("serviceToEdit", existingService);
        request.getRequestDispatcher("admin/editService.jsp").forward(request, response);
    }

    private void addService(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Service s = new Service();
        s.setServiceName(request.getParameter("service_name"));
        s.setCategoryId(Integer.parseInt(request.getParameter("category_id")));
        s.setPrice(Double.parseDouble(request.getParameter("price")));
        s.setDescription(request.getParameter("description"));
        String img = request.getParameter("image_path");
        s.setImagePath((img == null || img.isEmpty()) ? "https://via.placeholder.com/300" : img);
        
        dao.addService(s);
        response.sendRedirect(request.getContextPath() + "/ServiceController?action=manageAdmin");
    }

    private void updateService(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Service s = new Service();
        s.setServiceId(Integer.parseInt(request.getParameter("service_id")));
        s.setServiceName(request.getParameter("service_name"));
        s.setCategoryId(Integer.parseInt(request.getParameter("category_id")));
        s.setPrice(Double.parseDouble(request.getParameter("price")));
        s.setDescription(request.getParameter("description"));
        s.setImagePath(request.getParameter("image_path"));
        
        dao.updateService(s);
        response.sendRedirect(request.getContextPath() + "/ServiceController?action=manageAdmin");
    }

    private void deleteService(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        dao.deleteService(id);
        response.sendRedirect(request.getContextPath() + "/ServiceController?action=manageAdmin");
    }
    
    private void showBookingPage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("sessUserID") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int serviceId = Integer.parseInt(request.getParameter("service_id"));
        
        // 1. Get the Service
        Service service = dao.getServiceById(serviceId);
        request.setAttribute("serviceDetails", service);
        
        // 2. Get the Category Name to find matching Caregivers
        List<Category> allCategories = dao.getAllCategories();
        String catName = "";
        for (Category c : allCategories) {
            if (c.getCategoryId() == service.getCategoryId()) {
                catName = c.getCategoryName();
                break;
            }
        }
        
        // 3. Get Caregivers
        List<Caregiver> caregivers = dao.getApprovedCaregiversByCategory(catName);
        request.setAttribute("caregiverList", caregivers);
        
        // 4. Forward to the view
        request.getRequestDispatcher("client/serviceBooking.jsp").forward(request, response);
    }

    private void processBooking(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int userId = Integer.parseInt(request.getParameter("user_id"));
        int serviceId = Integer.parseInt(request.getParameter("service_id"));
        int caregiverId = Integer.parseInt(request.getParameter("caregiver_id"));
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String notes = request.getParameter("notes");
        
        dao.saveBooking(userId, serviceId, caregiverId, date, time, notes);
        
        // Redirect to a success page or dashboard
        response.sendRedirect(request.getContextPath() + "/client/bookingSuccess.jsp");
    }
}