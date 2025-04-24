package UserPackage;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/ProcessPartyRequestServlet")
public class ProcessPartyRequestServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        String reqId = request.getParameter("reqId");
        System.out.println("action: " + action );

        if (action == null || reqId == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Missing action or reqId parameter");
            return;
        }

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Start transaction

            if ("approve".equals(action)) {
                String checkEmailSQL = "SELECT COUNT(*) FROM users WHERE email = ?";
                stmt = conn.prepareStatement(checkEmailSQL);
                stmt.setString(1, request.getParameter("email"));
                ResultSet rs;
                System.out.println("email" + request.getParameter("email"));
                rs = stmt.executeQuery();
                if (rs.next() && rs.getInt(1) > 0) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("Email already exists");
                    return;
                }

                // 1. Update request status
                String updateRequestSQL = "UPDATE political_party_requests SET status = 'accepted' WHERE req_id = ?";
                stmt = conn.prepareStatement(updateRequestSQL);
                stmt.setInt(1, Integer.parseInt(reqId));
                int updated = stmt.executeUpdate();

                if (updated == 0) {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    response.getWriter().write("No request found with ID: " + reqId);
                    return;
                }

                // 2. Create user account
                String email = request.getParameter("email");
                String password = request.getParameter("password");

                if (email == null || password == null) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("Email and password are required");
                    return;
                }

                String insertUserSQL = "INSERT INTO users (email, password, user_type) VALUES (?, ?, 'political party')";
                stmt = conn.prepareStatement(insertUserSQL, Statement.RETURN_GENERATED_KEYS);
                stmt.setString(1, email);
                stmt.setString(2, password);
                stmt.executeUpdate();

                rs = stmt.getGeneratedKeys();
                if (!rs.next()) {
                    conn.rollback();
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    response.getWriter().write("Failed to create user account");
                    return;
                }

                int userId = rs.getInt(1);

                // 3. Create political party record
                String insertPartySQL = "INSERT INTO politicalparty " +
                        "(user_id, name, phone_number, address, no_of_members, leader) " +
                        "VALUES (?, ?, ?, ?, 0, ?)";
                stmt = conn.prepareStatement(insertPartySQL);
                stmt.setInt(1, userId);
                stmt.setString(2, request.getParameter("name"));
                stmt.setString(3, request.getParameter("phone"));  // Should match parameter name from JSP
                stmt.setString(4, request.getParameter("address"));
                stmt.setString(5, request.getParameter("leader"));  // Add leader from request
                stmt.executeUpdate();

                conn.commit(); // Commit transaction
                response.getWriter().write("success");

            } else if ("reject".equals(action)) {
                // Handle rejection
                String updateRequestSQL = "UPDATE political_party_requests SET status = 'rejected' WHERE req_id = ?";
                stmt = conn.prepareStatement(updateRequestSQL);
                stmt.setInt(1, Integer.parseInt(reqId));
                int updated = stmt.executeUpdate();

                if (updated == 0) {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    response.getWriter().write("No request found with ID: " + reqId);
                    return;
                }

                conn.commit();
                response.getWriter().write("success");
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("Invalid action: " + action);
            }
        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            // Send more detailed error message
            response.getWriter().write("Error processing request: " + e.getMessage() +
                    "\nSQL State: " + ((SQLException) e).getSQLState());
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}