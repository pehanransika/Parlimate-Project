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

@WebServlet("/GetPartyProfileDetailsServlet")
public class GetPartyProfileDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            System.out.println("GetPartyProfileDetailsServlet");
            String viewType = request.getParameter("view"); // "1", "2", or "compare"
            String nameParam1 = request.getParameter("partyName1");
            String nameParam2 = request.getParameter("partyName2");

            System.out.println("Request parameters are: viewType=" + viewType + ", partyName1=" + nameParam1 + ", partyName2=" + nameParam2);

            List<PartyProfileModel> profiles = new ArrayList<>();
            PartyProfileController controller = new PartyProfileController();

            if ("1".equals(viewType)) {
                if (nameParam1 != null && !nameParam1.isEmpty()) {
                    try {
                        PartyProfileModel profile1 = controller.getProfileByPartyName(nameParam1);
                        if (profile1 != null) {
                            profiles.add(profile1);
                            System.out.println("Profile for partyName1 added.");
                        }
                    } catch (Exception e) {
                        System.out.println("Error fetching profile for partyName1: " + nameParam1);
                        request.setAttribute("error", "Error fetching profile for partyName1.");
                        request.getRequestDispatcher("error.jsp").forward(request, response);
                        return;
                    }
                }
            } else if ("2".equals(viewType)) {
                if (nameParam2 != null && !nameParam2.isEmpty()) {
                    try {
                        PartyProfileModel profile2 = controller.getProfileByPartyName(nameParam2);
                        if (profile2 != null) {
                            profiles.add(profile2);
                            System.out.println("Profile for partyName2 added.");
                        }
                    } catch (Exception e) {
                        System.out.println("Error fetching profile for partyName2: " + nameParam2);
                        request.setAttribute("error", "Error fetching profile for partyName2.");
                        request.getRequestDispatcher("error.jsp").forward(request, response);
                        return;
                    }
                }
            } else if ("compare".equals(viewType)) {
                if (nameParam1 != null && !nameParam1.isEmpty()) {
                    try {
                        PartyProfileModel profile1 = controller.getProfileByPartyName(nameParam1);
                        if (profile1 != null) {
                            profiles.add(profile1);
                            System.out.println("Profile for partyName1 added for comparison.");
                        }
                    } catch (Exception e) {
                        System.out.println("Error fetching profile for partyName1 in compare mode: " + nameParam1);
                        request.setAttribute("error", "Error fetching profile for partyName1.");
                        request.getRequestDispatcher("error.jsp").forward(request, response);
                        return;
                    }
                }
                if (nameParam2 != null && !nameParam2.isEmpty()) {
                    try {
                        PartyProfileModel profile2 = controller.getProfileByPartyName(nameParam2);
                        if (profile2 != null) {
                            profiles.add(profile2);
                            System.out.println("Profile for partyName2 added for comparison.");
                        }
                    } catch (Exception e) {
                        System.out.println("Error fetching profile for partyName2 in compare mode: " + nameParam2);
                        request.setAttribute("error", "Error fetching profile for partyName2.");
                        request.getRequestDispatcher("error.jsp").forward(request, response);
                        return;
                    }
                }
            }

            if (!profiles.isEmpty()) {
                System.out.println("Party profiles found: " + profiles.size());
                request.setAttribute("party", profiles);

                RequestDispatcher dispatcher = request.getRequestDispatcher("/SearchCompare/searchCompare.jsp");
                dispatcher.forward(request, response);
            } else {
                System.out.println("No party profiles found for the provided names.");
                request.setAttribute("error", "No party profiles found for the provided names.");
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
