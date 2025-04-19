package UserPackage;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import org.json.JSONObject;

@WebServlet("/SetPoliticsPreference")
public class PoliticalPreferenceServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        JSONObject jsonResponse = new JSONObject();
        PrintWriter out = response.getWriter();

        try {
            // Read request body
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = request.getReader().readLine()) != null) {
                sb.append(line);
            }

            JSONObject jsonRequest = new JSONObject(sb.toString());
            String userId = jsonRequest.getString("userId");
            int rank1Id = jsonRequest.getInt("rank1PoliticianId");
            int rank2Id = jsonRequest.getInt("rank2PoliticianId");
            int rank3Id = jsonRequest.getInt("rank3PoliticianId");
            int partyRank1Id = jsonRequest.getInt("rank1PartyId");
            int partyRank2Id = jsonRequest.getInt("rank2PartyId");
            int partyRank3Id = jsonRequest.getInt("rank3PartyId");

            // Update database
            boolean politicianSuccess = PoliticalPrefereceController.setPoliticianPreference(
                    userId, rank1Id, rank2Id, rank3Id);
            boolean partySuccess = PoliticalPrefereceController.setPartyPreference(userId,partyRank1Id,partyRank2Id,partyRank3Id);


            if (politicianSuccess && partySuccess) {
                jsonResponse.put("success", true);
                jsonResponse.put("message", "Preferences updated successfully");
            } else {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Failed to update preferences");
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }

        } catch (Exception e) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Error: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }

        out.print(jsonResponse.toString());
        out.flush();
    }
}