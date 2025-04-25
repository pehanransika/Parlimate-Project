package UserPackage;

public class UserDetailModel {
    private int userId;
    private String email;
    private String userType;
    private String created_at;
    private String name;
    private String address;
    private String pNo;
    private String district;
    private String province;
    private String politicalView = null;

    // Constructors, Getters, and Setters
    public UserDetailModel(int userId, String email, String userType, String created_at, String name, String address, String pNo, String district, String province, String politicalView) {
        this.userId = userId;
        this.email = email;
        this.userType = userType;
        this.created_at = created_at;
        this.name = name;
        this.address = address;
        this.pNo = pNo;
        this.district = district;
        this.province = province;
        this.politicalView = politicalView;

    }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getUserType() { return userType; }
    public void setUserType(String userType) { this.userType = userType; }

    public String getCreated_at() { return created_at; }
    public void setCreated_at(String created_at) { this.created_at = created_at; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getpNo() { return pNo; }
    public void setpNo(String pNo) { this.pNo = pNo; }

    public String getDistrict() { return district; }
    public void setDistrict(String district) { this.district = district; }

    public String getProvince() { return province; }
    public void setProvince(String province) { this.province = province; }

    public String getPoliticalView() { return politicalView; }
    public void setPoliticalView(String politicalView) { this.politicalView = politicalView; }

}