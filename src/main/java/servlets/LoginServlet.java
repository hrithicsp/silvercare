package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;

import com.silvercare.util.DBConnection;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
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
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		try {
			Connection con = DBConnection.getConnection();
			
			String sql = "SELECT * FROM user WHERE email=? AND password=?";
			PreparedStatement pst = con.prepareStatement(sql);
			pst.setString(1, email);
			pst.setString(2, password);
			
			ResultSet rs = pst.executeQuery();
			
			if(rs.next()) {
				
				HttpSession session = request.getSession();
				session.setAttribute("sessUserID", rs.getInt("user_id"));
				session.setAttribute("sessUserEmail", rs.getString("email"));
				session.setAttribute("sessUserRole", rs.getString("role"));
				session.setAttribute("sessUserName", rs.getString("fullname"));
				
				// redirect based on role
				if(rs.getString("role").equals("ADMIN")) {
					System.out.print("Success");
					response.sendRedirect("/silvercare/admin/adminDashboard.jsp");
				} else {
					response.sendRedirect("/silvercare/client/clientDashboard.jsp");
				}
				
			} else {
				request.setAttribute("loginError", "Invalid email or password!");
				request.getRequestDispatcher("clientLogin.jsp").forward(request, response);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

}
