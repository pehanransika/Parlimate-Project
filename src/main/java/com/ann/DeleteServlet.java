package com.ann;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import UserPackage.UserModel;

@WebServlet("/DeleteServlet")
public class DeleteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().println("<script>alert('Invalid request method'); window.location.href='GetMyMeetingRequests';</script>");
    }

    @Override
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

            // Retrieve the announcement ID and politician ID from the request parameters
            String announcementIdParam = request.getParameter("announcementid");

            // Log the parameters for debugging
            System.out.println("Received announcementid: " + announcementIdParam + ", politicianid: " + politicianIdStr);

            // Check if the parameters are null or empty
            if (announcementIdParam == null || announcementIdParam.trim().isEmpty()) {
                response.getWriter().println("<script>alert('Announcement ID is missing or invalid'); window.location.href='GetMyMeetingRequests';</script>");
                return;
            }
            if (politicianIdStr == null || politicianIdStr.trim().isEmpty()) {
                response.getWriter().println("<script>alert('Politician ID is missing'); window.location.href='GetMyMeetingRequests';</script>");
                return;
            }

            // Convert the parameters to integers
            int announcementId = Integer.parseInt(announcementIdParam);
            politicianId = Integer.parseInt(politicianIdStr);

            // Call the delete method from the controller
            boolean isDeleted = AnnouncementController.deleteAnnouncement(announcementId);

            if (isDeleted) {
                // If deletion is successful, redirect with a success message
                String alertMessage = "Data Deleted Successfully";
                response.getWriter().println("<script>alert('" + alertMessage + "'); window.location.href='GetMyAnnouncements?politicianId=" + politicianId + "';</script>");
            } else {
                // If deletion fails, redirect with an error message
                String alertMessage = "Failed to delete the announcement.";
                response.getWriter().println("<script>alert('" + alertMessage + "'); window.location.href='GetMyAnnouncements?politicianId=" + politicianId + "';</script>");
            }
        } catch (NumberFormatException e) {
            // Handle invalid or missing announcement ID or politician ID
            e.printStackTrace();
            response.getWriter().println("<script>alert('Invalid input format'); window.location.href='GetMyAnnouncements';</script>");
        } catch (Exception e) {
            // General exception handling
            e.printStackTrace();
            response.getWriter().println("<script>alert('An error occurred'); window.location.href='GetMyAnnouncements?politicianId=" + politicianId + "';</script>");
        }
    }
}