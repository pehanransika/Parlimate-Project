package publicprofile;

public class PoliticianProfileModel {
    private int profileId;
    private int politicianId;

    private String fullName, gender, publicContactNumber, publicEmailAddress, district;
    private int age;

    // Educational
    private String schoolsAttended, university, highestEducationQualification, fieldOfStudy, educationalQualifications;

    // Professional
    private String profession, workExperienceSummary;

    // Political
    private String party, electoralLevel, electoralProvince, electoralDistrict, electoralDivision;
    private String currentPosition, currentPositionInParty, yearsActiveInPolitics;

    // Election
    private String electionYear, typeOfElection, numberOfVotes, electionResult;

    // Policies
    private String visionOrSlogan, economicPolicy, healthcarePolicy, infrastructurePolicy,
            educationPolicy, youthDevelopmentPolicy, agriculturePolicy;

    private String facebook;
    private String instagram;
    private String linkedin;
    private String x;

    // Getters and Setters
    public int getProfileId() {
        return profileId;
    }

    public void setProfileId(int profileId) {
        this.profileId = profileId;
    }

    public int getPoliticianId() {
        return politicianId;
    }

    public void setPoliticianId(int politicianId) {
        this.politicianId = politicianId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getPublicContactNumber() {
        return publicContactNumber;
    }

    public void setPublicContactNumber(String publicContactNumber) {
        this.publicContactNumber = publicContactNumber;
    }

    public String getPublicEmailAddress() {
        return publicEmailAddress;
    }

    public void setPublicEmailAddress(String publicEmailAddress) {
        this.publicEmailAddress = publicEmailAddress;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getSchoolsAttended() {
        return schoolsAttended;
    }

    public void setSchoolsAttended(String schoolsAttended) {
        this.schoolsAttended = schoolsAttended;
    }

    public String getUniversity() {
        return university;
    }

    public void setUniversity(String university) {
        this.university = university;
    }

    public String getHighestEducationQualification() {
        return highestEducationQualification;
    }

    public void setHighestEducationQualification(String highestEducationQualification) {
        this.highestEducationQualification = highestEducationQualification;
    }

    public String getFieldOfStudy() {
        return fieldOfStudy;
    }

    public void setFieldOfStudy(String fieldOfStudy) {
        this.fieldOfStudy = fieldOfStudy;
    }

    public String getEducationalQualifications() {
        return educationalQualifications;
    }

    public void setEducationalQualifications(String educationalQualifications) {
        this.educationalQualifications = educationalQualifications;
    }

    public String getProfession() {
        return profession;
    }

    public void setProfession(String profession) {
        this.profession = profession;
    }

    public String getWorkExperienceSummary() {
        return workExperienceSummary;
    }

    public void setWorkExperienceSummary(String workExperienceSummary) {
        this.workExperienceSummary = workExperienceSummary;
    }

    public String getParty() {
        return party;
    }

    public void setParty(String party) {
        this.party = party;
    }

    public String getElectoralLevel() {
        return electoralLevel;
    }

    public void setElectoralLevel(String electoralLevel) {
        this.electoralLevel = electoralLevel;
    }

    public String getElectoralProvince() {
        return electoralProvince;
    }

    public void setElectoralProvince(String electoralProvince) {
        this.electoralProvince = electoralProvince;
    }

    public String getElectoralDistrict() {
        return electoralDistrict;
    }

    public void setElectoralDistrict(String electoralDistrict) {
        this.electoralDistrict = electoralDistrict;
    }

    public String getElectoralDivision() {
        return electoralDivision;
    }

    public void setElectoralDivision(String electoralDivision) {
        this.electoralDivision = electoralDivision;
    }

    public String getCurrentPosition() {
        return currentPosition;
    }

    public void setCurrentPosition(String currentPosition) {
        this.currentPosition = currentPosition;
    }

    public String getCurrentPositionInParty() {
        return currentPositionInParty;
    }

    public void setCurrentPositionInParty(String currentPositionInParty) {
        this.currentPositionInParty = currentPositionInParty;
    }

    public String getYearsActiveInPolitics() {
        return yearsActiveInPolitics;
    }

    public void setYearsActiveInPolitics(String yearsActiveInPolitics) {
        this.yearsActiveInPolitics = yearsActiveInPolitics;
    }

    public String getElectionYear() {
        return electionYear;
    }

    public void setElectionYear(String electionYear) {
        this.electionYear = electionYear;
    }

    public String getTypeOfElection() {
        return typeOfElection;
    }

    public void setTypeOfElection(String typeOfElection) {
        this.typeOfElection = typeOfElection;
    }

    public String getNumberOfVotes() {
        return numberOfVotes;
    }

    public void setNumberOfVotes(String numberOfVotes) {
        this.numberOfVotes = numberOfVotes;
    }

    public String getElectionResult() {
        return electionResult;
    }

    public void setElectionResult(String electionResult) {
        this.electionResult = electionResult;
    }

    public String getVisionOrSlogan() {
        return visionOrSlogan;
    }

    public void setVisionOrSlogan(String visionOrSlogan) {
        this.visionOrSlogan = visionOrSlogan;
    }

    public String getEconomicPolicy() {
        return economicPolicy;
    }

    public void setEconomicPolicy(String economicPolicy) {
        this.economicPolicy = economicPolicy;
    }

    public String getHealthcarePolicy() {
        return healthcarePolicy;
    }

    public void setHealthcarePolicy(String healthcarePolicy) {
        this.healthcarePolicy = healthcarePolicy;
    }

    public String getInfrastructurePolicy() {
        return infrastructurePolicy;
    }

    public void setInfrastructurePolicy(String infrastructurePolicy) {
        this.infrastructurePolicy = infrastructurePolicy;
    }

    public String getEducationPolicy() {
        return educationPolicy;
    }

    public void setEducationPolicy(String educationPolicy) {
        this.educationPolicy = educationPolicy;
    }

    public String getYouthDevelopmentPolicy() {
        return youthDevelopmentPolicy;
    }

    public void setYouthDevelopmentPolicy(String youthDevelopmentPolicy) {
        this.youthDevelopmentPolicy = youthDevelopmentPolicy;
    }

    public String getAgriculturePolicy() {
        return agriculturePolicy;
    }

    public void setAgriculturePolicy(String agriculturePolicy) {
        this.agriculturePolicy = agriculturePolicy;
    }
    public String getFacebook() { return facebook; }
    public void setFacebook(String facebook) { this.facebook = facebook; }

    public String getInstagram() { return instagram; }
    public void setInstagram(String instagram) { this.instagram = instagram; }

    public String getLinkedin() { return linkedin; }
    public void setLinkedin(String linkedin) { this.linkedin = linkedin; }

    public String getX() { return x; }
    public void setX(String x) { this.x = x; }
}
