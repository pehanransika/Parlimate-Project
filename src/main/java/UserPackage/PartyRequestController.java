package UserPackage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class PartyRequestController {
        static Connection conn = null;
        static PreparedStatement stmt = null;
        static ResultSet rs = null;

    public static List<PartyRequestModel> listAllPartyRequests() {
        List<PartyRequestModel> list = new ArrayList<PartyRequestModel>();

        String query = "Select * from political_party_requests";

        try{
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(query);
            rs = stmt.executeQuery();

            while(rs.next()){
                PartyRequestModel partyRequest = new PartyRequestModel(
                        rs.getInt("req_id"),
                        rs.getString("name"),
                        rs.getString("address"),
                        rs.getString("leader"),
                        rs.getString("email"),
                        rs.getString("contact_no"),
                        rs.getString("submission_date"),
                        rs.getString("status"),
                        rs.getString("password")
                );

                list.add(partyRequest);
            }
        } catch (Exception e){
            e.printStackTrace();
        }

        return list;
    }
}
