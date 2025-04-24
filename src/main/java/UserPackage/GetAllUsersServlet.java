package UserPackage;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/admin/userManagement")
public class GetAllUsersServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try{
            List<UserDetailModel> usersDetails = new ArrayList<UserDetailModel>();
            List<UserModel> users = UserController.getAllUsers();

            for(UserModel user : users){
                String name = "";
                String address = "";
                String pNo= "";
                String district= "";
                String province= "";
                String politicalView= "";

                switch (user.getUserType().toLowerCase()){
                    case "citizen" :
                        List<CitizenModel> citizen = CitizenController.CitizenProfile(user.getUserId());
                        if (citizen != null && !citizen.isEmpty()){
                            name = citizen.get(0).getName();
                            address = citizen.get(0).getAddress();
                            pNo = citizen.get(0).getPhoneNumber();
                            district = citizen.get(0).getDistrict();
                            province = citizen.get(0).getProvince();
                            politicalView = citizen.get(0).getPoliticalView();
                        }
                        break;

                    case "politician" :
                        List<PoliticianModel> politician = PoliticianController.PoliticianProfile(user.getUserId());
                        if (politician != null && !politician.isEmpty()){
                            name = politician.get(0).getName();
                            address = politician.get(0).getAddress();
                            pNo = politician.get(0).getPhoneNumber();
                            district = politician.get(0).getDistrict();
                            province = politician.get(0).getProvince();
                            politicalView = politician.get(0).getPoliticalView();
                        }
                        break;

                    case "political party":
                        List<PoliticalPartyModel> party = PoliticalPartyController.PoliticalPartyProfile(user.getUserId());
                        if (party != null && !party.isEmpty()){
                            name = party.get(0).getName();
                            address = party.get(0).getAddress();
                            pNo = party.get(0).getPhoneNumber();
                        }
                        break;

                    case "admin":
                        List<AdminModel> admin = AdminController.AdminProfile(user.getUserId());

                        if (admin != null && !admin.isEmpty()){
                            name = admin.get(0).getFullname();
                        }
                        break;
                }

                UserDetailModel userDetail = new UserDetailModel(
                        user.getUserId(),
                        user.getEmail(),
                        user.getUserType().toLowerCase(),
                        user.getCreated_at(),
                        name,
                        address,
                        pNo,
                        district,
                        province,
                        politicalView
                );
                usersDetails.add(userDetail);
            }
            System.out.println("Total users fetched: " + usersDetails.size());
            request.setAttribute("AllUsers", usersDetails);
            request.getRequestDispatcher("/getAllPartyRequests").include(request, response);
            request.getRequestDispatcher("/admin/userManagement/userManagement.jsp").forward(request, response);

        }
        catch(Exception e){
            e.printStackTrace();
        }

    }
}
