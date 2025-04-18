package UserPackage;

public class PoliticianModel  {
    private int politicianId;
    private int userId;
    private String name;
    private String address;
    private String phoneNumber;
    private Integer politicalPartyId; // Nullable if no party
    private String district;
    private String province;
    private String politicalView;


    public PoliticianModel(int userId,int politicianId, String name, String address, String phoneNumber,
                      int politicalPartyId, String district, String province, String politicalView) {
        this.userId = userId;
        this.politicianId = politicianId;
        this.name = name;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.politicalPartyId = politicalPartyId;
        this.district = district;
        this.province = province;
        this.politicalView = politicalView;

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

    public String getDistrict() { return district; }
    public void setDistrict(String district) { this.district = district; }

    public String getProvince() { return province; }
    public void setProvince(String province) { this.province = province; }

    public String getPoliticalView() { return politicalView; }
    public void setPoliticalView(String politicalView) { this.politicalView = politicalView; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
}
