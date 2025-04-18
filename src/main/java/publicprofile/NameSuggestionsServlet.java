package publicprofile;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/SearchCompare/NameSuggestionsServlet")
public class NameSuggestionsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String query = request.getParameter("query");
        List<String> suggestions = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();) {
            String sql = "SELECT full_name FROM politicianprofile WHERE LOWER(full_name) LIKE ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + query.toLowerCase() + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                suggestions.add(rs.getString("full_name"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.setContentType("text/plain");
        for (String name : suggestions) {
            response.getWriter().println(name); // Each suggestion in a new line
        }
    }
}
