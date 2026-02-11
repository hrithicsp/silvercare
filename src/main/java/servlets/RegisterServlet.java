package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;

import com.silvercare.model.User;
import com.silvercare.dao.UserDAO;

@WebServlet("/RegisterServlet")
@MultipartConfig
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	Part filePart = request.getPart("profilePic");
        String fileName = null; // Initialize variable so it's accessible below

        if (filePart != null && filePart.getSize() > 0) {
            fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();

            String uploadPath = request.getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            filePart.write(uploadPath + File.separator + fileName);
        }

    	// 1. Create a User object and set the data from the request
    	User newUser = new User();
    	newUser.setFullname(request.getParameter("fullname"));
    	newUser.setGender(request.getParameter("gender"));
    	newUser.setDob(request.getParameter("dob"));
    	newUser.setPhone(request.getParameter("phone"));
    	newUser.setAddress(request.getParameter("address"));
    	newUser.setEmail(request.getParameter("email"));
    	newUser.setPassword(request.getParameter("password"));
    	newUser.setPreferredContact(request.getParameter("preferredContact"));
    	newUser.setTechLevel(Integer.parseInt(request.getParameter("techLevel")));
    	newUser.setNotifEnabled(request.getParameter("notif") != null);
    	newUser.setInterests((request.getParameterValues("interests") != null) ? 
    	    String.join(", ", request.getParameterValues("interests")) : null);

    	// Handle the file upload (fileName logic remains the same)
    	newUser.setProfilePic(fileName); 

    	// 2. Use the DAO to save the user to the database
    	UserDAO userDAO = new UserDAO();
    	try {
    	    int newUserId = userDAO.registerUser(newUser);

    	    if (newUserId > 0) {
    	        // 3. Create session and redirect (The Controller's job)
    	        HttpSession session = request.getSession();
    	        session.setAttribute("sessUserID", newUserId);
    	        session.setAttribute("sessUserEmail", newUser.getEmail());
    	        session.setAttribute("sessUserRole", "CLIENT");
    	        session.setAttribute("sessUserName", newUser.getFullname());

    	        response.sendRedirect(request.getContextPath() + "/client/clientDashboard.jsp");
    	    }
    	} catch (Exception e) {
    	    e.printStackTrace();
    	    response.getWriter().println("Registration failed: " + e.getMessage());
    	}
    }
}

