package com.ann;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet("/UpdateServlet")
public class UpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
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

                // Show alert and redirect to GetAllServlet
                String alertMessage = "Announcement Updated Successfully";
                response.getWriter().println("<script>alert('" + alertMessage + "'); window.location.href='GetAllServlet';</script>");
            } else {
                // If update fails, forward to the error page
                String alertMessage = "Failed to update the announcement.";
                request.setAttribute("error", alertMessage);
                RequestDispatcher dis = request.getRequestDispatcher("wrong.jsp");
                dis.forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('Error processing request'); window.location.href='wrong.jsp';</script>");
        }
    }
}
