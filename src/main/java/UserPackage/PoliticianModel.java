package UserPackage;

public class PoliticianModel  {
    private int politicianId;
    private int userId;
    private String name;
    private String address;
    private String phoneNumber;
    private Integer politicalPartyId; // Nullable if no party
    private String profileImgUrl;

    public PoliticianModel(int userId,int politicianId, String name, String address, String phoneNumber,
                      int politicalPartyId, String profileImgUrl) {
        this.userId = userId;
        this.politicianId = politicianId;
        this.name = name;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.politicalPartyId = politicalPartyId;
        this.profileImgUrl = profileImgUrl;
    }

    // Getters and Setters
    public int getPoliticianId() { return politicianId; }
    public void setPoliticianId(int politicianId) { this.politicianId = politicianId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }

    public Integer getPoliticalPartyId() { return politicalPartyId; }
    public void setPoliticalPartyId(Integer politicalPartyId) { this.politicalPartyId = politicalPartyId; }

    public String getProfileImgUrl() { return profileImgUrl; }
    public void setProfileImgUrl(String profileImgUrl) { this.profileImgUrl = profileImgUrl; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
}
