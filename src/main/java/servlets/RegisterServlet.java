package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.sql.*;

import com.silvercare.util.DBConnection;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
        String fullname = request.getParameter("fullname");
        String gender = request.getParameter("gender");
        String dob = request.getParameter("dob");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String preferredContact = request.getParameter("preferredContact");
        String address = request.getParameter("address");
        String techLevel = request.getParameter("techLevel");
        String notif = request.getParameter("notif") != null ? "1" : "0";

        // ===== File Upload Logic =====
        Part filePart = request.getPart("profilePic");
        String fileName = null;

        if(filePart != null && filePart.getSize() > 0) {

            fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();

            String uploadPath = request.getServletContext().getRealPath("") + "uploads";

            File uploadDir = new File(uploadPath);

            if(!uploadDir.exists()) uploadDir.mkdir();

            filePart.write(uploadPath + File.separator + fileName);
        }

        try {
            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO user(fullname, gender, dob, phone, email, password, preferred_contact, address, tech_level, notif_enabled, profile_pic) "
                       + "VALUES (?,?,?,?,?,?,?,?,?,?,?)";

            PreparedStatement pst = con.prepareStatement(sql);
            
            pst.setString(1, fullname);
            pst.setString(2, gender);
            pst.setString(3, dob);
            pst.setString(4, phone);
            pst.setString(5, email);
            pst.setString(6, password);
            pst.setString(7, preferredContact);
            pst.setString(8, address);
            pst.setString(9, techLevel);
            pst.setString(10, notif);
            pst.setString(11, fileName);

            pst.executeUpdate();

            // redirect success
            response.sendRedirect("clientLogin.jsp?registered=true");

        } catch(Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=1");
        }
	}

}
