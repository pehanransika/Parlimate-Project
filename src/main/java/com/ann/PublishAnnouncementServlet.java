package com.ann;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import UserPackage.UserModel;

@WebServlet("/PublishAnnouncementServlet")
public class PublishAnnouncementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String politicianIdStr = request.getParameter("politicianid");
        int politicianId = 0; // Default value for error cases

        try {
            // Get user from session
            HttpSession session = request.getSession(false);
            UserModel user = (session != null) ? (UserModel) session.getAttribute("user") : null;

            if (user == null) {
                response.getWriter().println("<script>alert('Please login first'); window.location.href='GetMyAnnouncements';</script>");
                return;
            }

            // Validate politicianid
            if (politicianIdStr == null || politicianIdStr.trim().isEmpty()) {
                response.getWriter().println("<script>alert('Politician ID is missing'); window.location.href='GetMyAnnouncements';</script>");
                return;
            }
            politicianId = Integer.parseInt(politicianIdStr);

            // Validate user type and authorization
            if (!"Politician".equals(user.getUserType()) && !"Political Party".equals(user.getUserType())) {
                response.getWriter().println("<script>alert('Unauthorized: Only Politicians or Political Parties can publish announcements'); window.location.href='GetMyAnnouncements?politicianId=" + politicianId + "';</script>");
                return;
            }

            // Retrieve form data
            String title = request.getParameter("title");
            String content = request.getParameter("content");

            // Validate form data
            if (title == null || title.trim().isEmpty() || content == null || content.trim().isEmpty()) {
                response.getWriter().println("<script>alert('Title and content are required'); window.location.href='GetMyAnnouncements?politicianId=" + politicianId + "';</script>");
                return;
            }

            // Call the controller to publish the announcement
            boolean isPublished = AnnouncementController.PublishAnnouncement(politicianId, title, content);

            if (isPublished) {
                // If successful, show alert and redirect to GetMyAnnouncements
                String alertMessage = "Announcement Published Successfully";
                response.getWriter().println("<script>alert('" + alertMessage + "'); window.location.href='GetMyAnnouncements?politicianId=" + politicianId + "';</script>");
            } else {
                // If publication fails, redirect with an error message
                String alertMessage = "Failed to publish announcement.";
                response.getWriter().println("<script>alert('" + alertMessage + "'); window.location.href='GetMyAnnouncements?politicianId=" + politicianId + "';</script>");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('Invalid politician ID format'); window.location.href='GetMyAnnouncements';</script>");
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('Database error occurred'); window.location.href='GetMyAnnouncements?politicianId=" + politicianId + "';</script>");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('An error occurred'); window.location.href='GetMyAnnouncements?politicianId=" + politicianId + "';</script>");
        }
    }
}