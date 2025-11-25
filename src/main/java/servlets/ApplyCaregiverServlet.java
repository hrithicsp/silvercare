package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

import com.silvercare.util.DBConnection;

@WebServlet("/ApplyCaregiverServlet")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5) // 5MB
public class ApplyCaregiverServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if(session == null || session.getAttribute("sessUserID") == null){
            response.sendRedirect("../clientLogin.jsp");
            return;
        }

        int userId = (int) session.getAttribute("sessUserID");

        // read form values
        String fullname = request.getParameter("fullname");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String dob = request.getParameter("dob");
        String address = request.getParameter("address");
        String yearsExp = request.getParameter("yearsExp");
        String experience = request.getParameter("experience");
        String certifications = request.getParameter("certifications");
        String availabilityDays = request.getParameter("availabilityDays");
        String interest = request.getParameter("interest");
        String shift = request.getParameter("shift");

        // join skills[]
        String[] skills = request.getParameterValues("skills");
        String skillsJoined = (skills != null) ? String.join(", ", skills) : "";

        // FILE UPLOAD
        Part profilePicPart = request.getPart("profilePhoto");
        Part cvPart = request.getPart("cvFile");

        String uploadPath = request.getServletContext().getRealPath("") + "uploads/caregiver/";

        File dir = new File(uploadPath);
        if(!dir.exists()) dir.mkdirs();

        String profileFilename = null, cvFilename = null;

        if(profilePicPart != null && profilePicPart.getSize() > 0){
            profileFilename = System.currentTimeMillis()+"_"+ profilePicPart.getSubmittedFileName();
            profilePicPart.write(uploadPath + profileFilename);
        }

        if(cvPart != null && cvPart.getSize() > 0){
            cvFilename = System.currentTimeMillis()+"_"+ cvPart.getSubmittedFileName();
            cvPart.write(uploadPath + cvFilename);
        }

        try{
            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO caregiver_application "
                    + "(user_id, full_name, phone, email, dob, address, years_experience, experience, skills, certifications, profile_photo, cv_file, availability_days, preferred_shift, interest_service) "
                    + "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

            PreparedStatement pst = con.prepareStatement(sql);

            pst.setInt(1, userId);
            pst.setString(2, fullname);
            pst.setString(3, phone);
            pst.setString(4, email);
            pst.setString(5, dob);
            pst.setString(6, address);
            pst.setString(7, yearsExp);
            pst.setString(8, experience);
            pst.setString(9, skillsJoined);
            pst.setString(10, certifications);
            pst.setString(11, profileFilename);
            pst.setString(12, cvFilename);
            pst.setString(13, availabilityDays);
            pst.setString(14, shift);
            pst.setString(15, interest);

            pst.executeUpdate();

            response.sendRedirect(request.getContextPath() + "/caregiver_application/applicationSuccess.jsp");

        }catch(Exception e){
            e.printStackTrace();
        }

    }
}

