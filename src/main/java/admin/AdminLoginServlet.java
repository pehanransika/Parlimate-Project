package admin;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        System.out.println("Login attempt with email: " + email);

        try {
            List<AdminModel> adminlogin = AdminController.loginValidate(email, password);
            if (adminlogin != null && !adminlogin.isEmpty()) {
                System.out.println("Login successful for: " + adminlogin.get(0).getName());
                req.getSession().setAttribute("admin", adminlogin.get(0));
                resp.sendRedirect("success.jsp");
            } else {
                System.out.println("Login failed for email: " + email);
                resp.getWriter().println("<script>alert('Login failed, please try again');window.location.href='login.jsp';</script>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().println("<script>alert('An error occurred during login.');window.location.href='login.jsp';</script>");
        }
    }
}