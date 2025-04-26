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
        // Set no-cache headers to prevent caching
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        // Log request receipt
        System.out.println("PublishAnnouncementAdminServlet: Received POST request");

        // Retrieve form parameters
        String userId = request.getParameter("userId");
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        // Log parameters
        System.out.println("Parameters - userId: " + userId + ", title: " + title + ", content: " + content);

        // Validate and process the data
        if (userId != null && title != null && content != null) {
            try {
                int politicianId = Integer.parseInt(userId); // Convert userId to int for politicianid
                // Call the AnnouncementController's PublishAnnouncement method
                System.out.println("Calling PublishAnnouncement with politicianId: " + politicianId);
                AnnouncementController.PublishAnnouncement(politicianId, title, content);

                // Log the redirect URL
                String redirectUrl = request.getContextPath() + "/admin/Home/GetAnalyticsCountServlet";
                System.out.println("Redirecting to: " + redirectUrl);

                // Redirect to the analytics count servlet
                response.sendRedirect(redirectUrl);
            } catch (NumberFormatException e) {
                // Handle invalid userId format
                System.out.println("NumberFormatException: " + e.getMessage());
                response.sendRedirect("error.jsp");
            } catch (Exception e) {
                // Handle any other exceptions from PublishAnnouncement
                System.out.println("Exception: " + e.getMessage());
                response.sendRedirect("error.jsp");
            }
        } else {
            // Handle missing parameters
            System.out.println("Missing parameters: userId=" + userId + ", title=" + title + ", content=" + content);
            response.sendRedirect("error.jsp");
        }
    }
}