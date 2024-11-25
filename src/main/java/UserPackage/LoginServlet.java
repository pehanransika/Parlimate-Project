package UserPackage;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/LoginNewServlet")

public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        try{
            List<UserModel> userlogin = UserController.loginValidate(email,password);
            if(userlogin != null && !userlogin.isEmpty()){
                req.getSession().setAttribute("user", userlogin.get(0));
                resp.sendRedirect("Home.jsp");
            }else{
                String alertMessage = "Login failed,please try again";
                resp.getWriter().println("<script>alert('"+alertMessage+"');window.location.href='index.jsp'</script>");
            }
            //req.setAttribute("userlogin", userlogin);
        }catch (Exception e){
            e.printStackTrace();
        }
        //RequestDispatcher dis = req.getRequestDispatcher("profile.jsp");
       // dis.forward(req, resp);
    }
}
