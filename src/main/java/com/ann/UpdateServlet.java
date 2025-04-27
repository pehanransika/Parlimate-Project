package com.ann;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import UserPackage.UserModel;

@WebServlet("/UpdateServlet")
public class UpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String politicianIdStr = request.getParameter("politicianid");
        int politicianId = 0; // Default value in case politicianId is invalid

        try {
            // Get user from session
            HttpSession session = request.getSession();
            UserModel user = (UserModel) session.getAttribute("user");

            if (user == null) {
                // Handle case where user is not logged in
                response.getWriter().println("<script>alert('Please login first'); window.location.href='GetMyMeetingRequests';</script>");
                return;
            }

            // Validate politicianid
            if (politicianIdStr == null || politicianIdStr.trim().isEmpty()) {
                response.getWriter().println("<script>alert('Politician ID is missing'); window.location.href='GetMyMeetingRequests';</script>");
                return;
            }
            politicianId = Integer.parseInt(politicianIdStr);

            // Retrieve parameters from the form
            int announcementid = Integer.parseInt(request.getParameter("announcementid"));
            String title = request.getParameter("title");
            String content = request.getParameter("content");

            // Set the current timestamp
            LocalDateTime datetime = LocalDateTime.now();

            // Call the controller to update the announcement
            boolean isUpdated = AnnouncementController.updateAnnouncement(announcementid, title, content, datetime);

            if (isUpdated) {
                // If successful, retrieve the updated list of announcements
                List<AnnouncementModel> announcements = AnnouncementController.getAllAnnouncements();
                request.setAttribute("announcements", announcements);

                // Show alert and redirect to GetMyMeetingRequests with politicianId
                String alertMessage = "Announcement Updated Successfully";
                response.getWriter().println("<script>alert('" + alertMessage + "'); window.location.href='GetMyAnnouncements?politicianId=" + politicianId + "';</script>");
            } else {
                // If update fails, redirect to GetMyMeetingRequests with politicianId
                String alertMessage = "Failed to update the announcement.";
                response.getWriter().println("<script>alert('" + alertMessage + "'); window.location.href='GetMyAnnouncements?politicianId=" + politicianId + "';</script>");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('Invalid input format'); window.location.href='GetMyAnnouncements';</script>");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('Error processing request'); window.location.href='GetMyAnnouncements?politicianId=" + politicianId + "';</script>");
        }
    }
}