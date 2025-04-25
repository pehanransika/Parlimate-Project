package publicprofile;

import java.sql.Timestamp;

public class PartyProfileModel {
    private int id;
    private String name;
    private String founder;
    private int foundYear;
    private String leader;
    private String generalSecretary;
    private String publicContactNumber;
    private String publicEmailAddress;

    private String ideology;
    private String coalitions;
    private int membership;
    private String address;
    private int yearsActiveInPolitics;

    private int seatsParliament;
    private int electionYear;
    private String typeOfElection;
    private int numberOfVotes;
    private String electionResult;

    private String visionOrSlogan;
    private String economicPolicy;
    private String healthcarePolicy;
    private String infrastructurePolicy;
    private String educationPolicy;
    private String youthDevelopmentPolicy;
    private String agriculturePolicy;

    private String imagePath; // newly added

    private Timestamp createdAt;
    private String website;
    private String facebook;
    private String instagram;
    private String linkedin;
    private String xLink;


    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getFounder() { return founder; }
    public void setFounder(String founder) { this.founder = founder; }

    public int getFoundYear() { return foundYear; }
    public void setFoundYear(int foundYear) { this.foundYear = foundYear; }

    public String getLeader() { return leader; }
    public void setLeader(String leader) { this.leader = leader; }

    public String getGeneralSecretary() { return generalSecretary; }
    public void setGeneralSecretary(String generalSecretary) { this.generalSecretary = generalSecretary; }

    public String getPublicContactNumber() { return publicContactNumber; }
    public void setPublicContactNumber(String publicContactNumber) { this.publicContactNumber = publicContactNumber; }

    public String getPublicEmailAddress() { return publicEmailAddress; }
    public void setPublicEmailAddress(String publicEmailAddress) { this.publicEmailAddress = publicEmailAddress; }

    public String getIdeology() { return ideology; }
    public void setIdeology(String ideology) { this.ideology = ideology; }

    public String getCoalitions() { return coalitions; }
    public void setCoalitions(String coalitions) { this.coalitions = coalitions; }

    public int getMembership() { return membership; }
    public void setMembership(int membership) { this.membership = membership; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public int getYearsActiveInPolitics() { return yearsActiveInPolitics; }
    public void setYearsActiveInPolitics(int yearsActiveInPolitics) { this.yearsActiveInPolitics = yearsActiveInPolitics; }

    public int getSeatsParliament() { return seatsParliament; }
    public void setSeatsParliament(int seatsParliament) { this.seatsParliament = seatsParliament; }

    public int getElectionYear() { return electionYear; }
    public void setElectionYear(int electionYear) { this.electionYear = electionYear; }

    public String getTypeOfElection() { return typeOfElection; }
    public void setTypeOfElection(String typeOfElection) { this.typeOfElection = typeOfElection; }

    public int getNumberOfVotes() { return numberOfVotes; }
    public void setNumberOfVotes(int numberOfVotes) { this.numberOfVotes = numberOfVotes; }

    public String getElectionResult() { return electionResult; }
    public void setElectionResult(String electionResult) { this.electionResult = electionResult; }

    public String getVisionOrSlogan() { return visionOrSlogan; }
    public void setVisionOrSlogan(String visionOrSlogan) { this.visionOrSlogan = visionOrSlogan; }

    public String getEconomicPolicy() { return economicPolicy; }
    public void setEconomicPolicy(String economicPolicy) { this.economicPolicy = economicPolicy; }

    public String getHealthcarePolicy() { return healthcarePolicy; }
    public void setHealthcarePolicy(String healthcarePolicy) { this.healthcarePolicy = healthcarePolicy; }

    public String getInfrastructurePolicy() { return infrastructurePolicy; }
    public void setInfrastructurePolicy(String infrastructurePolicy) { this.infrastructurePolicy = infrastructurePolicy; }

    public String getEducationPolicy() { return educationPolicy; }
    public void setEducationPolicy(String educationPolicy) { this.educationPolicy = educationPolicy; }

    public String getYouthDevelopmentPolicy() { return youthDevelopmentPolicy; }
    public void setYouthDevelopmentPolicy(String youthDevelopmentPolicy) { this.youthDevelopmentPolicy = youthDevelopmentPolicy; }

    public String getAgriculturePolicy() { return agriculturePolicy; }
    public void setAgriculturePolicy(String agriculturePolicy) { this.agriculturePolicy = agriculturePolicy; }

    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public String getFacebook() {
        return facebook;
    }

    public void setFacebook(String facebook) {
        this.facebook = facebook;
    }

    public String getInstagram() {
        return instagram;
    }

    public void setInstagram(String instagram) {
        this.instagram = instagram;
    }

    public String getLinkedin() {
        return linkedin;
    }

    public void setLinkedin(String linkedin) {
        this.linkedin = linkedin;
    }

    public String getXLink() {
        return xLink;
    }

    public void setXLink(String xLink) {
        this.xLink = xLink;
    }

}
