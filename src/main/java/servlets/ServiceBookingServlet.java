package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

import com.silvercare.util.DBConnection;

@WebServlet("/ServiceBookingServlet")
public class ServiceBookingServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int userId = Integer.parseInt(request.getParameter("user_id"));
        int serviceId = Integer.parseInt(request.getParameter("service_id"));
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String notes = request.getParameter("notes");

        try {
            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO service_booking (user_id, service_id, appointment_date, appointment_time, notes) VALUES (?,?,?,?,?)";
            PreparedStatement pst = con.prepareStatement(sql);

            pst.setInt(1, userId);
            pst.setInt(2, serviceId);
            pst.setString(3, date);
            pst.setString(4, time);
            pst.setString(5, notes);

            pst.executeUpdate();
            con.close();

            response.sendRedirect("/silvercare/client/bookingSuccess.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error booking service: " + e.getMessage());
        }
    }
}
