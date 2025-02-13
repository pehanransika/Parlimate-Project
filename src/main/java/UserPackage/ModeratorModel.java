package UserPackage;

public class ModeratorModel {
    private int moderatorid;
    private String fullname;
    private String phone_number;
    private int userid;



    public ModeratorModel(int moderatorid,String fullname,String phone_number,int userid){
        this.moderatorid=moderatorid;
        this.fullname=fullname;
        this.phone_number=phone_number;
        this.userid=userid;

    }

    public int getModeratorid() {
        return moderatorid;
    }
    public void setModeratorid(int moderatorid){
        this.moderatorid=moderatorid;
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

}

