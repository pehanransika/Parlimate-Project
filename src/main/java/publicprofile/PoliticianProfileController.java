package publicprofile;

import java.sql.*;

public class PoliticianProfileController {

    public PoliticianProfileModel getProfileByPoliticianName(String name) {
        PoliticianProfileModel profile = null;

        // Update the query to search by name instead of politician_id
        String query = "SELECT * FROM politicianprofile WHERE full_name = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, name); // Set the politician's full name
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                profile = new PoliticianProfileModel();

                profile.setProfileId(rs.getInt("profile_id"));
                profile.setPoliticianId(rs.getInt("politician_id"));
                profile.setFullName(rs.getString("full_name"));
                profile.setAge(rs.getInt("age"));
                profile.setGender(rs.getString("gender"));
                profile.setPublicContactNumber(rs.getString("public_contact_number"));
                profile.setPublicEmailAddress(rs.getString("public_email_address"));
                profile.setDistrict(rs.getString("district"));

                profile.setSchoolsAttended(rs.getString("schools_attended"));
                profile.setUniversity(rs.getString("university"));
                profile.setHighestEducationQualification(rs.getString("highest_education_qualification"));
                profile.setFieldOfStudy(rs.getString("field_of_study"));
                profile.setEducationalQualifications(rs.getString("educational_qualifications"));

                profile.setProfession(rs.getString("profession"));
                profile.setWorkExperienceSummary(rs.getString("work_experience_summary"));

                profile.setParty(rs.getString("party"));
                profile.setElectoralLevel(rs.getString("electoral_level"));
                profile.setElectoralProvince(rs.getString("electoral_province"));
                profile.setElectoralDistrict(rs.getString("electoral_district"));
                profile.setElectoralDivision(rs.getString("electoral_division"));
                profile.setCurrentPosition(rs.getString("current_position"));
                profile.setCurrentPositionInParty(rs.getString("current_position_in_party"));
                profile.setYearsActiveInPolitics(rs.getString("years_active_in_politics"));

                profile.setElectionYear(rs.getString("election_year"));
                profile.setTypeOfElection(rs.getString("type_of_election"));
                profile.setNumberOfVotes(rs.getString("number_of_votes"));
                profile.setElectionResult(rs.getString("election_result"));

                profile.setVisionOrSlogan(rs.getString("vision_or_slogan"));
                profile.setEconomicPolicy(rs.getString("economic_policy"));
                profile.setHealthcarePolicy(rs.getString("healthcare_policy"));
                profile.setInfrastructurePolicy(rs.getString("infrastructure_policy"));
                profile.setEducationPolicy(rs.getString("education_policy"));
                profile.setYouthDevelopmentPolicy(rs.getString("youth_development_policy"));
                profile.setAgriculturePolicy(rs.getString("agriculture_policy"));

                profile.setFacebook(rs.getString("facebook"));
                profile.setInstagram(rs.getString("instagram"));
                profile.setLinkedin(rs.getString("linkedin"));
                profile.setX(rs.getString("x"));
            }

            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return profile;
    }
}
