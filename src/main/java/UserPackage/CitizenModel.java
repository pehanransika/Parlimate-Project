package UserPackage;

<<<<<<< HEAD
=======
import java.security.Timestamp;

>>>>>>> 72354581de48bfd381a545c7f574c30d58d84595
public class CitizenModel  {
    private int citizenId;
    private int userId;
    private String address;
    private String phoneNumber;
    private String name;
<<<<<<< HEAD
    private String district;
    private String imageUrl;

    public CitizenModel(int citizenId, int userId, String address, String phoneNumber, String name, String district, String imageUrl) {
=======
    private String profile;
    private String imageUrl;

    public CitizenModel(int citizenId, int userId, String address, String phoneNumber, String name, String profile, String imageUrl) {
>>>>>>> 72354581de48bfd381a545c7f574c30d58d84595

        this.citizenId = citizenId;
        this.userId = userId;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.name = name;
<<<<<<< HEAD
        this.district = district;
=======
        this.profile = profile;
>>>>>>> 72354581de48bfd381a545c7f574c30d58d84595
        this.imageUrl = imageUrl;
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

<<<<<<< HEAD
    public String getDistrict() { return district; }
    public void setDistrict(String district) { this.district = district; }
=======
    public String getProfile() { return profile; }
    public void setProfile(String profile) { this.profile = profile; }
>>>>>>> 72354581de48bfd381a545c7f574c30d58d84595

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
}
