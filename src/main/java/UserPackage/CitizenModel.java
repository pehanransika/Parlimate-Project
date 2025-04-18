package UserPackage;

public class CitizenModel  {
    private int citizenId;
    private int userId;
    private String address;
    private String phoneNumber;
    private String name;
    private String district;
    private String province;
    private String politicalView;


    public CitizenModel(int citizenId, int userId, String address, String phoneNumber, String name,  String district, String province, String political_view) {

        this.citizenId = citizenId;
        this.userId = userId;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.name = name;
        this.district = district;
        this.province = province;
        this.politicalView = political_view;

    }



    // Getters and Setters
    public int getCitizenId() { return citizenId; }
    public void setCitizenId(int citizenId) { this.citizenId = citizenId; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDistrict() { return district; }
    public void setDistrict(String district) { this.district = district; }

    public String getPoliticalView() { return politicalView; }
    public void setPoliticalView(String politicalView) { this.politicalView = politicalView; }

    public String getProvince() { return province; }
    public void setProvince(String province) { this.province = province; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
}
