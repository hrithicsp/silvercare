package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.silvercare.util.DBConnection;

@WebServlet("/ApproveCaregiverServlet")
public class ApproveCaregiverServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException {

        int id = Integer.parseInt(req.getParameter("id"));

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement pst = con.prepareStatement(
                "UPDATE caregiver_application SET status='APPROVED' WHERE application_id=?"
            );
            pst.setInt(1, id);
            pst.executeUpdate();

            res.sendRedirect("/silvercare/admin/pendingCaregiver.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
