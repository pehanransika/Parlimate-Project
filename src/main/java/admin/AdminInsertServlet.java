package admin;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/AdminInsertServlet")
public class AdminInsertServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Retrieve form data
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String phonenumber = req.getParameter("phonenumber");
        String password = req.getParameter("password");
        String role = req.getParameter("role");

        System.out.println("Name: " + name);
        System.out.println("Email: " + email);
        System.out.println("Phone: " + phonenumber);
        System.out.println("Password: " + password);
        System.out.println("Role: " + role);

        // Validate inputs
        if (name == null || name.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                phonenumber == null || phonenumber.trim().isEmpty() ||
                password == null || password.trim().isEmpty() ||
                role == null || role.trim().isEmpty()) {

            // Notify user about missing fields
            resp.getWriter().println("<script>alert('All fields are required.');window.location.href='adminRegister.jsp';</script>");
            return;
        }

        try {
            // Attempt to insert the admin into the database
            int adminid = AdminController.insertAdmin(name.trim(), email.trim(), password.trim(), phonenumber.trim(), role.trim());

            if (adminid > 0) {
                // Successfully inserted
                resp.getWriter().println("<script>alert('Admin created successfully!');window.location.href='adminList.jsp';</script>");
            } else {
                // If insertion failed
                resp.getWriter().println("<script>alert('Failed to create admin. Please try again.');window.location.href='adminRegister.jsp';</script>");
            }
        } catch (Exception e) {
            // Log the exception and notify the user
            e.printStackTrace();
            resp.getWriter().println("<script>alert('An error occurred while creating the admin. Please try again later.');window.location.href='adminRegister.jsp';</script>");
        }
    }
}
