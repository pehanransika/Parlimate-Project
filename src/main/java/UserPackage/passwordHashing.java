package UserPackage;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class passwordHashing {

    /**
     * Hashes a password using SHA-256 algorithm.
     *
     * @param password The password to hash.
     * @return The hashed password in hexadecimal format, or null if an error occurs.
     */
    public static String hashPassword(String password) {
        try {
            // Create MessageDigest instance for SHA-256
            MessageDigest digest = MessageDigest.getInstance("SHA-256");

            // Convert the password string to bytes and hash it
            byte[] hashedBytes = digest.digest(password.getBytes());

            // Convert hashed bytes to hexadecimal format
            StringBuilder hexString = new StringBuilder();
            for (byte b : hashedBytes) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }

            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            System.err.println("Error: " + e.getMessage());
            return null;
        }
    }
}

