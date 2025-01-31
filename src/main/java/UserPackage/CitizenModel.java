
package UserPackage;

public class CitizenModel  {
    private int citizenId;
    private int userId;

    private String phoneNumber;
    private String name;
    private String district;


    public CitizenModel(int citizenId, int userId, String phoneNumber, String name, String district) {

        this.citizenId = citizenId;
        this.userId = userId;

        this.phoneNumber = phoneNumber;
        this.name = name;
        this.district = district;

    }



    // Getters and Setters
    public int getCitizenId() { return citizenId; }
    public void setCitizenId(int citizenId) { this.citizenId = citizenId; }



    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDistrict() { return district; }
    public void setDistrict(String district) { this.district = district; }


    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
}

