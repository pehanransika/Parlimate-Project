

package com.ann;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String url = "jdbc:postgresql://localhost:5433/ParlimateNew"; // Adjust as needed
    private static final String username = "postgres"; // Your PostgreSQL username
    private static final String password = "root"; // Your PostgreSQL password
    public static Connection getConnection() {
        Connection con = null;
        try {
            Class.forName("org.postgresql.Driver"); // Ensure driver is loaded
            con = DriverManager.getConnection(url, username, password);
            if (con != null) {
                System.out.println("Connection established successfully.");
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            System.out.println("PostgreSQL Driver not found.");
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Database connection error: " + e.getMessage());
        }
        return con;
    }

    public static void main(String[] args) {
        Connection con = getConnection();
        if (con != null) {
            System.out.println("Connection successful!");
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } else {
            System.out.println("Connection failed.");
        }
    }


}


