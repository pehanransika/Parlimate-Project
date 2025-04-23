package publicprofile;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/UpdatePolitcianDetailsServlet")
public class UpdatePolitcianDetailsServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve parameters from the form (assume all are passed as form data)
        int profileId = Integer.parseInt(request.getParameter("profile_id"));
        int politicianId = Integer.parseInt(request.getParameter("politician_id"));
        String fullName = request.getParameter("full_name");
        int age = Integer.parseInt(request.getParameter("age"));
        String gender = request.getParameter("gender");
        String contact = request.getParameter("public_contact_number");
        String email = request.getParameter("public_email_address");
        String district = request.getParameter("district");

        String schools = request.getParameter("schools_attended");
        String university = request.getParameter("university");
        String qualification = request.getParameter("highest_education_qualification");
        String field = request.getParameter("field_of_study");
        String qualifications = request.getParameter("educational_qualifications");

        String profession = request.getParameter("profession");
        String workSummary = request.getParameter("work_experience_summary");

        String party = request.getParameter("party");
        String level = request.getParameter("electoral_level");
        String province = request.getParameter("electoral_province");
        String eDistrict = request.getParameter("electoral_district");
        String division = request.getParameter("electoral_division");
        String currentPosition = request.getParameter("current_position");
        String currentPositionInParty = request.getParameter("current_position_in_party");
        String yearsActive = request.getParameter("years_active_in_politics");

        String electionYear = request.getParameter("election_year");
        String typeOfElection = request.getParameter("type_of_election");
        String votes = request.getParameter("number_of_votes");
        String result = request.getParameter("election_result");

        String slogan = request.getParameter("vision_or_slogan");
        String economic = request.getParameter("economic_policy");
        String healthcare = request.getParameter("healthcare_policy");
        String infrastructure = request.getParameter("infrastructure_policy");
        String education = request.getParameter("education_policy");
        String youth = request.getParameter("youth_development_policy");
        String agriculture = request.getParameter("agriculture_policy");

        String facebook = request.getParameter("facebook");
        String instagram = request.getParameter("instagram");
        String linkedin = request.getParameter("linkedin");
        String x = request.getParameter("x");
        String imagePath = request.getParameter("image_path");

        // Create and populate the model
        PoliticianProfileModel profile = new PoliticianProfileModel();
        profile.setProfileId(profileId);
        profile.setPoliticianId(politicianId);
        profile.setFullName(fullName);
        profile.setAge(age);
        profile.setGender(gender);
        profile.setPublicContactNumber(contact);
        profile.setPublicEmailAddress(email);
        profile.setDistrict(district);
        profile.setSchoolsAttended(schools);
        profile.setUniversity(university);
        profile.setHighestEducationQualification(qualification);
        profile.setFieldOfStudy(field);
        profile.setEducationalQualifications(qualifications);
        profile.setProfession(profession);
        profile.setWorkExperienceSummary(workSummary);
        profile.setParty(party);
        profile.setElectoralLevel(level);
        profile.setElectoralProvince(province);
        profile.setElectoralDistrict(eDistrict);
        profile.setElectoralDivision(division);
        profile.setCurrentPosition(currentPosition);
        profile.setCurrentPositionInParty(currentPositionInParty);
        profile.setYearsActiveInPolitics(yearsActive);
        profile.setElectionYear(electionYear);
        profile.setTypeOfElection(typeOfElection);
        profile.setNumberOfVotes(votes);
        profile.setElectionResult(result);
        profile.setVisionOrSlogan(slogan);
        profile.setEconomicPolicy(economic);
        profile.setHealthcarePolicy(healthcare);
        profile.setInfrastructurePolicy(infrastructure);
        profile.setEducationPolicy(education);
        profile.setYouthDevelopmentPolicy(youth);
        profile.setAgriculturePolicy(agriculture);
        profile.setFacebook(facebook);
        profile.setInstagram(instagram);
        profile.setLinkedin(linkedin);
        profile.setX(x);
        profile.setImagePath(imagePath);

        // Call controller to update details
        PoliticianProfileController controller = new PoliticianProfileController();
        boolean updated = controller.updatePoliticianDetails(profile);

        if (updated) {
            response.sendRedirect(request.getContextPath() + "/admin/ProfileManagement/GetPoliticianProfileDetailsAdminServlet");
        } else {
            response.sendRedirect(request.getContextPath() + "/update-failure.jsp");
        }

    }
}
