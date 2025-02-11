package UserPackage;

public class PoliticalPartyModel {
    private int politicalPartyId;
    private int userId;
    private String name;
    private String phoneNumber;
    private String address;
    private String logoImg;
    private int noOfMembers;

    public PoliticalPartyModel(int politicalPartyId, int userId, String name, String phoneNumber,
                          String address, String logoImg, int noOfMembers) {
        this.politicalPartyId = politicalPartyId;
        this.userId = userId;
        this.name = name;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.logoImg = logoImg;
        this.noOfMembers = noOfMembers;
    }

    // Getters and Setters
    public int getPoliticalPartyId() { return politicalPartyId; }
    public void setPoliticalPartyId(int politicalPartyId) { this.politicalPartyId = politicalPartyId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getLogoImg() { return logoImg; }
    public void setLogoImg(String logoImg) { this.logoImg = logoImg; }

    public int getNoOfMembers() { return noOfMembers; }
    public void setNoOfMembers(int noOfMembers) { this.noOfMembers = noOfMembers; }
}

