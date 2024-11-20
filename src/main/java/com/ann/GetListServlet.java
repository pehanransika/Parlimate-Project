package com.ann;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/GetListServlet")
public class GetListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;


    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        List<AnnouncementModel> allannouncements = AnnouncementController.getAllAnnouncements();
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
