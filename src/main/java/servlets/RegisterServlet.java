package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.sql.*;

import com.silvercare.util.DBConnection;

@WebServlet("/RegisterServlet")
@MultipartConfig
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Basic fields
        String fullname = request.getParameter("fullname");
        String gender = request.getParameter("gender");
        String dob = request.getParameter("dob");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String preferredContact = request.getParameter("preferredContact");
        int techLevel = Integer.parseInt(request.getParameter("techLevel"));

        // Interests
        String[] interestsArr = request.getParameterValues("interests");
        String interests = (interestsArr != null) ? String.join(", ", interestsArr) : null;

        // Notification toggle
        boolean notifEnabled = request.getParameter("notif") != null;

        // File upload
        Part filePart = request.getPart("profilePic");
        String fileName = null;

        if (filePart != null && filePart.getSize() > 0) {
            fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();

            String uploadPath = request.getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            filePart.write(uploadPath + File.separator + fileName);
        }

        try {
            Connection con = DBConnection.getConnection();

            // Insert the user
            String sql = "INSERT INTO user (fullname, gender, dob, phone, address, email, password, profile_pic, preferred_contact, tech_level, notif_enabled, areas_of_interest, role) "
                       + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'CLIENT')";

            PreparedStatement pst = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            pst.setString(1, fullname);
            pst.setString(2, gender);
            pst.setString(3, dob);
            pst.setString(4, phone);
            pst.setString(5, address);
            pst.setString(6, email);
            pst.setString(7, password);
            pst.setString(8, fileName);
            pst.setString(9, preferredContact);
            pst.setInt(10, techLevel);
            pst.setBoolean(11, notifEnabled);
            pst.setString(12, interests);

            pst.executeUpdate();

            // Retrieve the user_id (AUTO_INCREMENT)
            ResultSet generatedKeys = pst.getGeneratedKeys();
            int newUserId = 0;

            if (generatedKeys.next()) {
                newUserId = generatedKeys.getInt(1);
            }

            // Now create session and auto-login user
            HttpSession session = request.getSession();
            session.setAttribute("sessUserID", newUserId);
            session.setAttribute("sessUserEmail", email);
            session.setAttribute("sessUserRole", "CLIENT");
            session.setAttribute("sessUserName", fullname);

            // Redirect straight to client dashboard
            response.sendRedirect("/silvercare/client/clientDashboard.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Registration failed: " + e.getMessage());
        }
    }
}

