package publicprofile;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/GetPoliticianProfileDetailsServlet")
public class GetPoliticianProfileDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String viewType = request.getParameter("view"); // "1", "2", or "compare"
            String nameParam1 = request.getParameter("politicianName1");
            String nameParam2 = request.getParameter("politicianName2");

            System.out.println("Request parameters: viewType=" + viewType + ", nameParam1=" + nameParam1 + ", nameParam2=" + nameParam2);

            List<PoliticianProfileModel> profiles = new ArrayList<>();
            PoliticianProfileController controller = new PoliticianProfileController();

            // Check for valid names and fetch profiles based on the view type
            if ("1".equals(viewType)) {
                if (nameParam1 != null && !nameParam1.isEmpty()) {
                    try {
                        PoliticianProfileModel profile1 = controller.getProfileByPoliticianName(nameParam1);
                        if (profile1 != null) {
                            profiles.add(profile1);
                            System.out.println("Profile for politicianName1 added.");
                        }
                    } catch (Exception e) {
                        System.out.println("Error fetching profile for politicianName1: " + nameParam1);
                        request.setAttribute("error", "Error fetching profile for politicianName1.");
                        request.getRequestDispatcher("error.jsp").forward(request, response);
                        return;
                    }
                }
            } else if ("2".equals(viewType)) {
                if (nameParam2 != null && !nameParam2.isEmpty()) {
                    try {
                        PoliticianProfileModel profile2 = controller.getProfileByPoliticianName(nameParam2);
                        if (profile2 != null) {
                            profiles.add(profile2);
                            System.out.println("Profile for politicianName2 added.");
                        }
                    } catch (Exception e) {
                        System.out.println("Error fetching profile for politicianName2: " + nameParam2);
                        request.setAttribute("error", "Error fetching profile for politicianName2.");
                        request.getRequestDispatcher("error.jsp").forward(request, response);
                        return;
                    }
                }
            } else if ("compare".equals(viewType)) {
                if (nameParam1 != null && !nameParam1.isEmpty()) {
                    try {
                        PoliticianProfileModel profile1 = controller.getProfileByPoliticianName(nameParam1);
                        if (profile1 != null) {
                            profiles.add(profile1);
                            System.out.println("Profile for politicianName1 added for comparison.");
                        }
                    } catch (Exception e) {
                        System.out.println("Error fetching profile for politicianName1 in compare mode: " + nameParam1);
                        request.setAttribute("error", "Error fetching profile for politicianName1.");
                        request.getRequestDispatcher("error.jsp").forward(request, response);
                        return;
                    }
                }
                if (nameParam2 != null && !nameParam2.isEmpty()) {
                    try {
                        PoliticianProfileModel profile2 = controller.getProfileByPoliticianName(nameParam2);
                        if (profile2 != null) {
                            profiles.add(profile2);
                            System.out.println("Profile for politicianName2 added for comparison.");
                        }
                    } catch (Exception e) {
                        System.out.println("Error fetching profile for politicianName2 in compare mode: " + nameParam2);
                        request.setAttribute("error", "Error fetching profile for politicianName2.");
                        request.getRequestDispatcher("error.jsp").forward(request, response);
                        return;
                    }
                }
            }

            // Check if profiles are fetched and forward to the JSP
            if (!profiles.isEmpty()) {
                System.out.println("Profiles found: " + profiles.size());
                request.setAttribute("profiles", profiles);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/SearchCompare/searchCompare.jsp");
                dispatcher.forward(request, response);
            } else {
                System.out.println("No profiles found for the provided names.");
                request.setAttribute("error", "No profiles found for the provided names.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error occurred: " + e.getMessage());
            request.setAttribute("error", "Something went wrong.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
