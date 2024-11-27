package com.ann;

import UserPackage.PoliticianModel;
import UserPackage.UserModel;

import javax.net.ssl.HandshakeCompletedEvent;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/GetListServlet")
public class GetListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;


    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        PoliticianModel announcement = ( PoliticianModel) session.getAttribute("userProfile");
        int politicianId = announcement.getPoliticianId();

        List<AnnouncementModel> allannouncements = AnnouncementController.getMyAnnouncements(politicianId);
        request.setAttribute("allannouncements",allannouncements);
// Forward to announcements.jsp
        RequestDispatcher dispatcher1 = request.getRequestDispatcher("announcementlist.jsp");
        dispatcher1.include(request, response);

// Then forward to announcementsDetail.jsp

    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
        doGet(request,response);
    }
}
