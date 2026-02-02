package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Sets the user's preferred language (locale) in session and redirects back.
 * Used by the language dropdown in the header. Stores language code (en, zh, ms, ta)
 * for JSTL fmt:setLocale / ResourceBundle.
 */
@WebServlet("/SetLocaleServlet")
public class SetLocaleServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String lang = request.getParameter("lang");
        if (lang != null && (lang.equals("en") || lang.equals("zh") || lang.equals("ms") || lang.equals("ta"))) {
            request.getSession(true).setAttribute("userLocale", lang);
        }
        String returnUrl = request.getParameter("returnUrl");
        if (returnUrl != null && !returnUrl.isEmpty()) {
            response.sendRedirect(returnUrl);
        } else {
            String referer = request.getHeader("Referer");
            if (referer != null && !referer.isEmpty()) {
                response.sendRedirect(referer);
            } else {
                response.sendRedirect(request.getContextPath() + "/home.jsp");
            }
        }
    }
}
