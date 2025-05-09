package publicprofile;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

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
                profile.setImagePath(rs.getString("image_path"));

            }

            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return profile;
    }

    public List<PoliticianProfileModel> getAllProfiles() {
        List<PoliticianProfileModel> profiles = new ArrayList<>();

        String query = "SELECT profile_id, full_name FROM politicianprofile ORDER BY profile_id";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                PoliticianProfileModel profile = new PoliticianProfileModel();
                profile.setProfileId(rs.getInt("profile_id"));
                profile.setFullName(rs.getString("full_name"));
                profiles.add(profile);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return profiles;
    }

    public boolean insertPoliticianDetails(PoliticianProfileModel profile) {
        String query = "INSERT INTO politicianprofile (" +
                "politician_id, full_name, age, gender, public_contact_number, public_email_address, district, " +
                "schools_attended, university, highest_education_qualification, field_of_study, educational_qualifications, " +
                "profession, work_experience_summary, party, electoral_level, electoral_province, electoral_district, " +
                "electoral_division, current_position, current_position_in_party, years_active_in_politics, " +
                "election_year, type_of_election, number_of_votes, election_result, " +
                "vision_or_slogan, economic_policy, healthcare_policy, infrastructure_policy, education_policy, " +
                "youth_development_policy, agriculture_policy, facebook, instagram, linkedin, x, image_path) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, profile.getPoliticianId());
            stmt.setString(2, profile.getFullName());
            stmt.setInt(3, profile.getAge());
            stmt.setString(4, profile.getGender());
            stmt.setString(5, profile.getPublicContactNumber());
            stmt.setString(6, profile.getPublicEmailAddress());
            stmt.setString(7, profile.getDistrict());

            stmt.setString(8, profile.getSchoolsAttended());
            stmt.setString(9, profile.getUniversity());
            stmt.setString(10, profile.getHighestEducationQualification());
            stmt.setString(11, profile.getFieldOfStudy());
            stmt.setString(12, profile.getEducationalQualifications());

            stmt.setString(13, profile.getProfession());
            stmt.setString(14, profile.getWorkExperienceSummary());

            stmt.setString(15, profile.getParty());
            stmt.setString(16, profile.getElectoralLevel());
            stmt.setString(17, profile.getElectoralProvince());
            stmt.setString(18, profile.getElectoralDistrict());
            stmt.setString(19, profile.getElectoralDivision());
            stmt.setString(20, profile.getCurrentPosition());
            stmt.setString(21, profile.getCurrentPositionInParty());
            stmt.setString(22, profile.getYearsActiveInPolitics());

            stmt.setString(23, profile.getElectionYear());
            stmt.setString(24, profile.getTypeOfElection());
            stmt.setString(25, profile.getNumberOfVotes());
            stmt.setString(26, profile.getElectionResult());

            stmt.setString(27, profile.getVisionOrSlogan());
            stmt.setString(28, profile.getEconomicPolicy());
            stmt.setString(29, profile.getHealthcarePolicy());
            stmt.setString(30, profile.getInfrastructurePolicy());
            stmt.setString(31, profile.getEducationPolicy());
            stmt.setString(32, profile.getYouthDevelopmentPolicy());
            stmt.setString(33, profile.getAgriculturePolicy());

            stmt.setString(34, profile.getFacebook());
            stmt.setString(35, profile.getInstagram());
            stmt.setString(36, profile.getLinkedin());
            stmt.setString(37, profile.getX());
            stmt.setString(38, profile.getImagePath());

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updatePoliticianDetails(PoliticianProfileModel profile) {
        String updateQuery = "UPDATE politicianprofile SET " +
                "politician_id = ?, full_name = ?, age = ?, gender = ?, public_contact_number = ?, " +
                "public_email_address = ?, district = ?, schools_attended = ?, university = ?, " +
                "highest_education_qualification = ?, field_of_study = ?, educational_qualifications = ?, " +
                "profession = ?, work_experience_summary = ?, party = ?, electoral_level = ?, " +
                "electoral_province = ?, electoral_district = ?, electoral_division = ?, current_position = ?, " +
                "current_position_in_party = ?, years_active_in_politics = ?, election_year = ?, " +
                "type_of_election = ?, number_of_votes = ?, election_result = ?, vision_or_slogan = ?, " +
                "economic_policy = ?, healthcare_policy = ?, infrastructure_policy = ?, education_policy = ?, " +
                "youth_development_policy = ?, agriculture_policy = ?, facebook = ?, instagram = ?, linkedin = ?, " +
                "x = ?, image_path = ? WHERE profile_id = ?";

        String insertQuery = "INSERT INTO politicianprofile (" +
                "politician_id, full_name, age, gender, public_contact_number, public_email_address, district, " +
                "schools_attended, university, highest_education_qualification, field_of_study, educational_qualifications, " +
                "profession, work_experience_summary, party, electoral_level, electoral_province, electoral_district, " +
                "electoral_division, current_position, current_position_in_party, years_active_in_politics, " +
                "election_year, type_of_election, number_of_votes, election_result, vision_or_slogan, economic_policy, " +
                "healthcare_policy, infrastructure_policy, education_policy, youth_development_policy, agriculture_policy, " +
                "facebook, instagram, linkedin, x, image_path) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement updateStmt = conn.prepareStatement(updateQuery);
             PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {

            // Bind update statement
            bindPoliticianProfileParams(updateStmt, profile, true);
            int rowsUpdated = updateStmt.executeUpdate();

            if (rowsUpdated == 0) {
                // Bind insert statement (excluding profile_id)
                bindPoliticianProfileParams(insertStmt, profile, false);
                insertStmt.executeUpdate();
            }

            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private void bindPoliticianProfileParams(PreparedStatement stmt, PoliticianProfileModel profile, boolean isUpdate) throws SQLException {
        stmt.setInt(1, profile.getPoliticianId());
        stmt.setString(2, profile.getFullName());
        stmt.setInt(3, profile.getAge());
        stmt.setString(4, profile.getGender());
        stmt.setString(5, profile.getPublicContactNumber());
        stmt.setString(6, profile.getPublicEmailAddress());
        stmt.setString(7, profile.getDistrict());
        stmt.setString(8, profile.getSchoolsAttended());
        stmt.setString(9, profile.getUniversity());
        stmt.setString(10, profile.getHighestEducationQualification());
        stmt.setString(11, profile.getFieldOfStudy());
        stmt.setString(12, profile.getEducationalQualifications());
        stmt.setString(13, profile.getProfession());
        stmt.setString(14, profile.getWorkExperienceSummary());
        stmt.setString(15, profile.getParty());
        stmt.setString(16, profile.getElectoralLevel());
        stmt.setString(17, profile.getElectoralProvince());
        stmt.setString(18, profile.getElectoralDistrict());
        stmt.setString(19, profile.getElectoralDivision());
        stmt.setString(20, profile.getCurrentPosition());
        stmt.setString(21, profile.getCurrentPositionInParty());
        stmt.setString(22, profile.getYearsActiveInPolitics());
        stmt.setString(23, profile.getElectionYear());
        stmt.setString(24, profile.getTypeOfElection());
        stmt.setString(25, profile.getNumberOfVotes());
        stmt.setString(26, profile.getElectionResult());
        stmt.setString(27, profile.getVisionOrSlogan());
        stmt.setString(28, profile.getEconomicPolicy());
        stmt.setString(29, profile.getHealthcarePolicy());
        stmt.setString(30, profile.getInfrastructurePolicy());
        stmt.setString(31, profile.getEducationPolicy());
        stmt.setString(32, profile.getYouthDevelopmentPolicy());
        stmt.setString(33, profile.getAgriculturePolicy());
        stmt.setString(34, profile.getFacebook());
        stmt.setString(35, profile.getInstagram());
        stmt.setString(36, profile.getLinkedin());
        stmt.setString(37, profile.getX());
        stmt.setString(38, profile.getImagePath());

        if (isUpdate) {
            stmt.setInt(39, profile.getProfileId());
        }
    }


}
