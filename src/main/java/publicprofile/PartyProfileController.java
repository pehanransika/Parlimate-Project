package publicprofile;

import java.sql.*;

public class PartyProfileController {

    public PartyProfileModel getProfileByPartyName(String partyName) {
        PartyProfileModel profile = null;

        // SQL query to fetch the party profile by party name
        String query = "SELECT * FROM party_profile WHERE name = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            // Set the party name parameter for the query
            stmt.setString(1, partyName);
            ResultSet rs = stmt.executeQuery();

            // If a result is returned, map it to the PartyProfileModel
            if (rs.next()) {
                profile = new PartyProfileModel();

                profile.setId(rs.getInt("id"));
                profile.setName(rs.getString("name"));
                profile.setFounder(rs.getString("founder"));
                profile.setFoundYear(rs.getInt("found_year"));
                profile.setLeader(rs.getString("leader"));
                profile.setGeneralSecretary(rs.getString("general_secretary"));
                profile.setPublicContactNumber(rs.getString("public_contact_number"));
                profile.setPublicEmailAddress(rs.getString("public_email_address"));

                profile.setIdeology(rs.getString("ideology"));
                profile.setCoalitions(rs.getString("coalitions"));
                profile.setMembership(rs.getInt("membership"));
                profile.setAddress(rs.getString("address"));
                profile.setYearsActiveInPolitics(rs.getInt("years_active_in_politics"));

                profile.setSeatsParliament(rs.getInt("seats_parliament"));
                profile.setElectionYear(rs.getInt("election_year"));
                profile.setTypeOfElection(rs.getString("type_of_election"));
                profile.setNumberOfVotes(rs.getInt("number_of_votes"));
                profile.setElectionResult(rs.getString("election_result"));

                profile.setVisionOrSlogan(rs.getString("vision_or_slogan"));
                profile.setEconomicPolicy(rs.getString("economic_policy"));
                profile.setHealthcarePolicy(rs.getString("healthcare_policy"));
                profile.setInfrastructurePolicy(rs.getString("infrastructure_policy"));
                profile.setEducationPolicy(rs.getString("education_policy"));
                profile.setYouthDevelopmentPolicy(rs.getString("youth_development_policy"));
                profile.setAgriculturePolicy(rs.getString("agriculture_policy"));

                profile.setWebsite(rs.getString("website"));
                profile.setFacebook(rs.getString("facebook"));
                profile.setInstagram(rs.getString("instagram"));
                profile.setLinkedin(rs.getString("linkedin"));
                profile.setXLink(rs.getString("x_link"));

                profile.setImagePath(rs.getString("image_path"));
                profile.setCreatedAt(rs.getTimestamp("created_at"));
            }

            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return profile;
    }
}
