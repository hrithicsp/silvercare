package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;

import com.silvercare.model.User;
import com.silvercare.dao.UserDAO;

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

		UserDAO userDAO = new UserDAO();
		try {
		    User user = userDAO.validateUser(email, password);

		    if (user != null) {
		        // Successful login - Set up the session
		        HttpSession session = request.getSession();
		        session.setAttribute("sessUserID", user.getUserId());
		        session.setAttribute("sessUserEmail", user.getEmail());
		        session.setAttribute("sessUserRole", user.getRole());
		        session.setAttribute("sessUserName", user.getFullname());

		        // Role-based redirection
		        if ("ADMIN".equalsIgnoreCase(user.getRole())) {
		            response.sendRedirect(request.getContextPath() + "/admin/adminDashboard.jsp");
		        } else {
		            response.sendRedirect(request.getContextPath() + "/client/clientDashboard.jsp");
		        }
		    } else {
		        // Login failed
		        response.sendRedirect(request.getContextPath() + "/login.jsp?error=invalid");
		    }
		} catch (SQLException e) {
		    e.printStackTrace();
		    response.sendRedirect(request.getContextPath() + "/login.jsp?error=db");
		}
	}

}
