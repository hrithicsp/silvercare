package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import com.silvercare.dao.UserDAO;
import com.silvercare.model.User;

/**
 * Servlet implementation class AdminClientServlet
 */
@WebServlet("/AdminClientServlet")
public class AdminClientServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminClientServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String area = request.getParameter("areaCode") != null ? request.getParameter("areaCode") : "";
        String need = request.getParameter("careNeed") != null ? request.getParameter("careNeed") : "";
        
        UserDAO dao = new UserDAO();
        try {
            List<User> clients = dao.getClientsReport(area, need);
            request.setAttribute("clientList", clients);
            request.getRequestDispatcher("/admin/viewClients.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
