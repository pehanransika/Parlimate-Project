package com.ann;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/GetMyAnnouncements")
public class GetMyAnnouncements extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve politicianId from query parameter
        String politicianIdStr = request.getParameter("politicianId");


        // Validate politicianId (optional, depending on your requirements)
        if (politicianIdStr == null || politicianIdStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing politicianId parameter");
            return;
        }

        int politicianId = Integer.parseInt(politicianIdStr);
        // Fetch announcements for the given politicianId
        List<AnnouncementModel> myannouncements = AnnouncementController.getMyAnnouncements(politicianId);
        request.setAttribute("myannouncements", myannouncements);

        // Forward to announcementsDetail.jsp
        RequestDispatcher dispatcher = request.getRequestDispatcher("announcementsDetail.jsp");
        dispatcher.forward(request, response); // Use forward instead of include
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}