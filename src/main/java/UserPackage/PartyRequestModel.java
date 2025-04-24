package UserPackage;

public class PartyRequestModel {
    private int reqId;
    private String name;
    private String address;
    private String leader;
    private String email;
    private String phoneNumber;
    private String submittedDate;
    private String status;
    private String password;

    public PartyRequestModel(int reqId, String name, String address, String leader, String email, String phoneNumber, String submittedDate, String status,String password) {
        this.reqId = reqId;
        this.name = name;
        this.address = address;
        this.leader = leader;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.submittedDate = submittedDate;
        this.status = status;
        this.password = password;
    }

    public int getReqId() {return reqId;}
    public String getName() {return name;}
    public String getAddress() {return address;}
    public String getLeader() {return leader;}
    public String getEmail() {return email;}
    public String getPhoneNumber() {return phoneNumber;}
    public String getSubmittedDate() {return submittedDate;}
    public String getStatus() {return status;}
    public String getPassword() {return password;}

    public void setReqId(int reqId) {this.reqId = reqId;}
    public void setName(String name) {this.name = name;}
    public void setAddress(String address) {this.address = address;}
    public void setLeader(String leader) {this.leader = leader;}
    public void setEmail(String email) {this.email = email;}
    public void setPhoneNumber(String phoneNumber) {this.phoneNumber = phoneNumber;}
    public void setStatus(String status) {this.status = status;}
    public void setPassword(String password) {this.password = password;}

}
