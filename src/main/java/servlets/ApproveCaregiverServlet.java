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

        // Retrieve the caregiver application ID from the URL (?id=xxx)
        int id = Integer.parseInt(req.getParameter("id"));

        try {
            // Establish database connection
            Connection con = DBConnection.getConnection();

            // Prepare SQL query to update the caregiver's application status
            PreparedStatement pst = con.prepareStatement(
                "UPDATE caregiver_application SET status='APPROVED' WHERE application_id=?"
            );

            // Bind the application_id to the placeholder
            pst.setInt(1, id);

            // Execute the update query
            pst.executeUpdate();

            // Redirect admin back to the pending caregiver list page
            res.sendRedirect("/silvercare/admin/pendingCaregiver.jsp");

        } catch (Exception e) {
            // Print any errors in the server logs for debugging
            e.printStackTrace();
        }
    }
}

