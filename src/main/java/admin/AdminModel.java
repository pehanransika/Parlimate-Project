package admin;

public class AdminModel{
    private int userid;
    private String name;
    private String email;
    private String phoneNumber;
    private String password;
    private String role;
    private String createdat;

    // Constructor
    public AdminModel(int userid, String name, String email, String phoneNumber, String password, String role, String createdat) {
        this.userid = userid;
        this.name = name;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.password = password;
        this.role = role;
        this.createdat=createdat;
    }



    // Getters and Setters
    public int getUserID() {
        return userid;
    }

    public void setUserID(int userid) {
        this.userid = userid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
    public String getCreatedAt() { return createdat; }
    public void setCreatedAt(String createdAt) { this.createdat = createdat; }
}
