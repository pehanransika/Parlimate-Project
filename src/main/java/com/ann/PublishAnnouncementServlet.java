package com.ann;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/PublishNewAnnouncementServlet")
public class PublishAnnouncementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Set a default value for politicianid if not provided
            int defaultPoliticianId = 2; // Change this to the ID you'd like to set as default

            // Retrieve form data
            String politicianIdStr = request.getParameter("politicianid");
            int politicianid = (politicianIdStr != null && !politicianIdStr.isEmpty())
                    ? Integer.parseInt(politicianIdStr)
                    : defaultPoliticianId;

            String title = request.getParameter("title");
            String content = request.getParameter("content");

            // Call the controller to publish the announcement
            boolean isTrue = AnnouncementController.PublishAnnouncement(politicianid, title, content);

            if (isTrue) {
                // If successful, show alert and redirect to done.jsp
                String alertMessage = "Announcement Published Successfully";
                response.getWriter().println("<script>alert('" + alertMessage + "'); window.location.href='GetAllServlet';</script>");
                response.getWriter().println("<script>alert('" + alertMessage + "'); window.location.href='GetListServlet';</script>");
            } else {
                // If not successful, forward to the error page
                String alertMessage = "Failed to publish announcement.";
                request.setAttribute("error", alertMessage);
                RequestDispatcher dis = request.getRequestDispatcher("wrong.jsp");
                dis.forward(request, response);
            }
        } catch (NumberFormatException | SQLException e) {
            // Log the exception for debugging
            e.printStackTrace();

            // Provide user-friendly error message
            String alertMessage = "Invalid input or database error. Please try again.";
            request.setAttribute("error", alertMessage);
            RequestDispatcher dis = request.getRequestDispatcher("wrong.jsp");
            dis.forward(request, response);
        }
    }
}
