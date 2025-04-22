package support;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/publishSupport")
public class PublishSupportServlet extends HttpServlet {

    // This method handles the POST request when a support message is submitted
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve form data from the request
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String message = request.getParameter("message");

        // Validate the inputs (you can add more validation here if needed)
        if (name == null || email == null || message == null ||
                name.isEmpty() || email.isEmpty() || message.isEmpty()) {
            response.sendRedirect("supportForm.jsp?error=All fields are required");
            return;  // Early return to prevent further processing if validation fails
        }

        try {
            // Call the SupportController to save the support message
            boolean isSaved = SupportController.saveSupportMessage(name, email, message);

            if (isSaved) {
                // If the message is saved successfully, redirect to a success page or show a success message
                response.sendRedirect("supportForm.jsp?success=Message sent successfully!");
            } else {
                // If saving failed, redirect with an error message
                response.sendRedirect("supportForm.jsp?error=Failed to send the message. Please try again.");
            }
        } catch (SQLException e) {
            e.printStackTrace();  // Log the exception
            response.sendRedirect("supportForm.jsp?error=Database error. Please try again later.");
        }
    }

    // This method handles GET requests, if you need to use it
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // This method could be used to fetch support messages, but it's not needed for publishing
        response.sendRedirect("supportForm.jsp");
    }
}
