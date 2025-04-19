package UserPackage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PoliticalPrefereceController {
    public static boolean setPoliticianPreference(String userId, int rank1Id, int rank2Id, int rank3Id) {
        Connection conn = null;
        boolean isSuccess = false;
        int convertedUserId = Integer.parseInt(userId);

        try{
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            isSuccess = (setPreference(conn, convertedUserId,1, rank1Id) && setPreference(conn, convertedUserId,2, rank2Id) && setPreference(conn, convertedUserId,3, rank3Id));

            if(isSuccess){
                conn.commit();
            } else{
                conn.rollback();
            }
        }
        catch(Exception e) {
            e.printStackTrace();
        }

        return isSuccess;
    }


    public static boolean setPreference(Connection conn, int userId, int rank, int politicianId) {
        String query = "UPDATE politicianpreference SET politician_id = ? WHERE user_id = ? AND rank = ?";

        try(PreparedStatement pstmt = conn.prepareStatement(query)){
            // Using parameterized queries to prevent SQL injection
            pstmt.setInt(1, politicianId);
            pstmt.setInt(2, userId);
            pstmt.setInt(3, rank);

            int updated = pstmt.executeUpdate();
            if(updated == 0) {
                String insertQuery = "INSERT INTO politicianpreference VALUES (?, ?, ?)";
                try(PreparedStatement pstmt2 = conn.prepareStatement(insertQuery)) {
                    pstmt2.setInt(1, userId);
                    pstmt2.setInt(2, rank);
                    pstmt2.setInt(3, politicianId);
                    return pstmt2.executeUpdate() > 0;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return true;
    }

    public static List<PoliticianModel> getPrefferedPoliticians(String userId) throws SQLException {
        List<PoliticianModel> list = new ArrayList<>();
        int convertedUserId = Integer.parseInt(userId);

        String query = "SELECT p.* FROM politician p " +
                "JOIN politicianpreference pp ON p.politician_id = pp.politician_id " +
                "WHERE pp.user_id = ? " +
                "ORDER BY pp.rank"; // Important: Order by rank

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, convertedUserId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    PoliticianModel politician = new PoliticianModel(
                            rs.getInt("user_id"),
                            rs.getInt("politician_id"),
                            rs.getString("name"),
                            rs.getString("address"),
                            rs.getString("phone_number"),
                            rs.getInt("political_party_id"),
                            rs.getString("district"),
                            rs.getString("province"),
                            rs.getString("political_view")
                    );
                    list.add(politician);
                }
            }
        }
        return list;
    }
}
