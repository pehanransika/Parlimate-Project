package UserPackage;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private static String url = "jdbc:postgresql://localhost:5432/Parlimate";
    private static String user = "postgres";
    private static String pass = "manuja";
    private static Connection conn ;
    public static Connection getConnection() {
        try{
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection(url,user,pass);
        }
        catch (Exception e){
            System.out.println("Database not connected!");
        }
        return conn;
    }

}
