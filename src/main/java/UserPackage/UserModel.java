package UserPackage;

public class UserModel {
    private int userId;
    private String email;
    private String password;
    private String userType;
    private String created_at;

    // Constructors, Getters, and Setters
    public UserModel(int userId, String email, String password, String userType, String created_at) {
        this.userId = userId;
        this.email = email;
        this.password = password;
        this.userType = userType;
        this.created_at = created_at;
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

    public String getCreated_at() { return created_at; }
    public void setCreated_at(String created_at) { this.created_at = created_at; }
}




