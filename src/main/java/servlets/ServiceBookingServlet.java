package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

import com.silvercare.util.DBConnection;

@WebServlet("/ServiceBookingServlet")
public class ServiceBookingServlet extends HttpServlet {

    // Handles the booking form submission
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Pull all form values
        int userId = Integer.parseInt(request.getParameter("user_id"));
        int serviceId = Integer.parseInt(request.getParameter("service_id"));
        int caregiverId = Integer.parseInt(request.getParameter("caregiver_id"));
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String notes = request.getParameter("notes");

        try {
            // Open database connection
            Connection con = DBConnection.getConnection();

            // Insert a new booking record
            String sql = "INSERT INTO service_booking (user_id, service_id, caregiver_id, appointment_date, appointment_time, notes) VALUES (?,?,?,?,?,?)";
            PreparedStatement pst = con.prepareStatement(sql);

            // Fill in parameters
            pst.setInt(1, userId);
            pst.setInt(2, serviceId);
            pst.setInt(3, caregiverId);
            pst.setString(4, date);
            pst.setString(5, time);
            pst.setString(6, notes);

            pst.executeUpdate(); // save to DB
            con.close();

            // Redirect user to the success page
            response.sendRedirect(request.getContextPath() + "/client/bookingSuccess.jsp");

        } catch (Exception e) {
            // For debugging - shows the error on screen
            e.printStackTrace();
            response.getWriter().println("Error booking service: " + e.getMessage());
        }
    }
}