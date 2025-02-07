package UserPackage;

public class PoliticianModel {
    private int politicianId;
    private int userId;
    private String name;
    private String addressLine1;
    private String addressLine2;
    private String city;
    private String zipCode;
    private String phoneNumber;
    private Integer politicalPartyId; // Nullable if no party
    private String profileImgUrl;

    public PoliticianModel(int userId, int politicianId, String name, String addressLine1, String addressLine2,
                           String city, String zipCode, String phoneNumber, Integer politicalPartyId,
                           String profileImgUrl) {
        this.userId = userId;
        this.politicianId = politicianId;
        this.name = name;
        this.addressLine1 = addressLine1;
        this.addressLine2 = addressLine2;
        this.city = city;
        this.zipCode = zipCode;
        this.phoneNumber = phoneNumber;
        this.politicalPartyId = politicalPartyId;
        this.profileImgUrl = profileImgUrl;
    }

    // Getters and Setters
    public int getPoliticianId() { return politicianId; }
    public void setPoliticianId(int politicianId) { this.politicianId = politicianId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getAddressLine1() { return addressLine1; }
    public void setAddressLine1(String addressLine1) { this.addressLine1 = addressLine1; }

    public String getAddressLine2() { return addressLine2; }
    public void setAddressLine2(String addressLine2) { this.addressLine2 = addressLine2; }

    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }

    public String getZipCode() { return zipCode; }
    public void setZipCode(String zipCode) { this.zipCode = zipCode; }

    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }

    public Integer getPoliticalPartyId() { return politicalPartyId; }
    public void setPoliticalPartyId(Integer politicalPartyId) { this.politicalPartyId = politicalPartyId; }

    public String getProfileImgUrl() { return profileImgUrl; }
    public void setProfileImgUrl(String profileImgUrl) { this.profileImgUrl = profileImgUrl; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
}
