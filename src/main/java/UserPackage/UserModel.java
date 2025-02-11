package UserPackage;

public class UserModel {
    private int userId;
    private String email;
    private String password;
    private String userType;
    private String createdAt;

    // Constructors, Getters, and Setters
    public UserModel(int userId, String email, String password, String userType, String createdAt) {
        this.userId = userId;
        this.email = email;
        this.password = password;
        this.userType = userType;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getUserType() { return userType; }
    public void setUserType(String userType) { this.userType = userType; }

    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }
}




