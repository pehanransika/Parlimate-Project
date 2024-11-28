package UserPackage;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/newPassword")
public class NewPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		String newPassword = request.getParameter("password");
		String confPassword = request.getParameter("confPassword");

		System.out.println("Received password: " + newPassword);  // Debugging line
		System.out.println("Received confirm password: " + confPassword);  // Debugging line

		if (newPassword != null && confPassword != null && newPassword.equals(confPassword)) {
			System.out.println("Passwords match.");  // Debugging line

			Connection con = null;
			try {
				// Get a connection to the PostgreSQL database
				con = DBConnection.getConnection();
				System.out.println("Database connection established.");  // Debugging line

				// Prepare the SQL update statement
				String sql = "UPDATE users SET password = ? WHERE email = ?";
				PreparedStatement pst = con.prepareStatement(sql);
				pst.setString(1, newPassword);
				pst.setString(2, (String) session.getAttribute("email"));
				System.out.println("Prepared statement set: " + sql);  // Debugging line

				// Execute the update statement
				int rowCount = pst.executeUpdate();
				System.out.println("Rows affected: " + rowCount);  // Debugging line

				// Prepare alert message based on the result
				String alertMessage = "";
				if (rowCount > 0) {
					System.out.println("Password update successful.");  // Debugging line
					alertMessage = "Password updated successfully!";
				} else {
					System.out.println("Password update failed.");  // Debugging line
					alertMessage = "Password update failed. Please try again.";
				}

				// Send the alert and redirect to the index.jsp
				response.setContentType("text/html");
				response.getWriter().println("<script>");
				response.getWriter().println("alert('" + alertMessage + "');");
				response.getWriter().println("window.location.href = 'index.jsp';"); // Redirect to index.jsp
				response.getWriter().println("</script>");

			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println("SQLException occurred: " + e.getMessage());  // Debugging line
				String alertMessage = "An error occurred while updating the password. Please try again.";
				response.setContentType("text/html");
				response.getWriter().println("<script>");
				response.getWriter().println("alert('" + alertMessage + "');");
				response.getWriter().println("window.location.href = 'index.jsp';"); // Redirect to index.jsp
				response.getWriter().println("</script>");
			} finally {
				// Ensure the connection is closed after use
				if (con != null) {
					try {
						con.close();
						System.out.println("Database connection closed.");  // Debugging line
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		} else {
			// If passwords don't match, stay on the same page with an error message
			System.out.println("Passwords do not match.");  // Debugging line
			String alertMessage = "Passwords do not match. Please try again.";
			response.setContentType("text/html");
			response.getWriter().println("<script>");
			response.getWriter().println("alert('" + alertMessage + "');");
			response.getWriter().println("window.history.back();"); // Go back to the previous page
			response.getWriter().println("</script>");
		}
	}
}
