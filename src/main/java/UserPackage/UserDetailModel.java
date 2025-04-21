package UserPackage;

public class UserDetailModel {
    private int userId;
    private String email;
    private String userType;
    private String created_at;
    private String name;
    private String status;
    private String deleteReason = null;

    // Constructors, Getters, and Setters
    public UserDetailModel(int userId, String email, String userType, String created_at, String name, String status, String deleteReason) {
        this.userId = userId;
        this.email = email;
        this.userType = userType;
        this.created_at = created_at;
        this.name = name;
        this.status = status;
        this.deleteReason = deleteReason;

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

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getDeleteReason() { return deleteReason; }
    public void setDeleteReason(String deleteReason) { this.deleteReason = deleteReason; }
}