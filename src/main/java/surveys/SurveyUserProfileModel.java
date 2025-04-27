package surveys;

public class SurveyUserProfileModel {
    private int userId;
    private String email;
    private String userType;
    private String created_at;


    private String name;
    private String imageUrl;
    private String District;


    public SurveyUserProfileModel(int userId, String email, String userType, String created_at,
                                  String name, String imageUrl, String district) {
        this.userId = userId;
        this.email = email;
        this.userType = userType;
        this.created_at = created_at;
        this.name = name;
        this.imageUrl = imageUrl;
        this.District = district;
    }



    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {
        this.userId = userId;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getUserType() {
        return userType;
    }
    public void setUserType(String userType) {
        this.userType = userType;
    }
    public String getCreated_at() {
        return created_at;
    }
    public void setCreated_at(String created_at) {
        this.created_at = created_at;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getDistrict() {
        return District;
    }

    public void setDistrict(String district) {
        District = district;
    }
}

