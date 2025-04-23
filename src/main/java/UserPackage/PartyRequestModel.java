package UserPackage;

public class PartyRequestModel {
    private int reqId;
    private String name;
    private String address;
    private String leader;
    private String email;
    private String phoneNumber;
    private String submittedDate;

    public PartyRequestModel(int reqId, String name, String address, String leader, String email, String phoneNumber, String submittedDate) {
        this.reqId = reqId;
        this.name = name;
        this.address = address;
        this.leader = leader;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.submittedDate = submittedDate;
    }

    public int getReqId() {return reqId;}
    public String getName() {return name;}
    public String getAddress() {return address;}
    public String getLeader() {return leader;}
    public String getEmail() {return email;}
    public String getPhoneNumber() {return phoneNumber;}
    public String getSubmittedDate() {return submittedDate;}

    public void setReqId(int reqId) {this.reqId = reqId;}
    public void setName(String name) {this.name = name;}
    public void setAddress(String address) {this.address = address;}
    public void setLeader(String leader) {this.leader = leader;}
    public void setEmail(String email) {this.email = email;}
    public void setPhoneNumber(String phoneNumber) {this.phoneNumber = phoneNumber;}
    public void setSubmittedDate(String submittedDate) {this.submittedDate = submittedDate;}

}
