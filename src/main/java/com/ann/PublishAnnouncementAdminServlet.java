package com.ann;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/PublishAnnouncementAdminServlet")
public class PublishAnnouncementAdminServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form parameters
        String userId = request.getParameter("userId");
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        // Validate and process the data
        if (userId != null && title != null && content != null) {
            try {
                int politicianId = Integer.parseInt(userId); // Convert userId to int for politicianid
                // Call the AnnouncementController's PublishAnnouncement method
                AnnouncementController.PublishAnnouncement(politicianId, title, content);

                // Redirect to the admin dashboard
                response.sendRedirect(request.getContextPath() + "/admin/Home/index.jsp");
            } catch (NumberFormatException e) {
                // Handle invalid userId format
                response.sendRedirect("error.jsp");
            } catch (Exception e) {
                // Handle any other exceptions from PublishAnnouncement
                response.sendRedirect("error.jsp");
            }
        } else {
            // Handle missing parameters
            response.sendRedirect("error.jsp");
        }
    }
}