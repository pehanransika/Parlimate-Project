package UserPackage;

public class AdminModel {
    private int adminid;
    private String fullname;
    private String phone_number;
    private int userid;



    public AdminModel(int adminid,String fullname,String phone_number,int userid){
        this.adminid=adminid;
        this.fullname=fullname;
        this.phone_number=phone_number;
        this.userid=userid;

    }

    public int getAdminid() {
        return adminid;
    }
    public void setAdminid(int adminid){
        this.adminid=adminid;
    }
    public String getFullname(){
        return fullname;
    }
    public void setFullname(String fullname){
        this.fullname=fullname;
    }
    public String getPhone_number(){
        return phone_number;
    }
    public void setPhone_number(String phoneNumber){
        this.phone_number=phone_number;
    }
    public int getUserid(){ return userid;}
    public void setUserid(int userid){this.userid=userid;}

}
