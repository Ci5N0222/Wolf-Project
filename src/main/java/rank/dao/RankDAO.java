package rank.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import commons.DBConfig;
import oracle.net.aso.l;
import rank.dto.RankDTO;

public class RankDAO {
    
    private static RankDAO instance;
    
    public static RankDAO getInstance() {
        if(instance == null) instance = new RankDAO();
        return instance;
    }
    
    private RankDAO() {}
    
    public List<RankDTO> selectRank(int gameSeq) throws Exception {
        String sql = "SELECT nickname, avatar, score, ROW_NUMBER() OVER (ORDER BY score DESC) AS rank " +
                     "FROM members m " +
                     "JOIN game_score s ON m.id = s.member_id " +
                     "WHERE s.game_seq = ?";

        List<RankDTO> list = new ArrayList<>();
        try (Connection con = DBConfig.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql)) {

            pstat.setInt(1, gameSeq);

            try (ResultSet rs = pstat.executeQuery()) {
                while (rs.next()) {
                    String nickname = rs.getString("nickname");
                    String avatar = rs.getString("avatar");
                    int score = rs.getInt("score");
                    int rank = rs.getInt("rank");

                    RankDTO dto = new RankDTO(nickname, avatar, score, rank);
                    list.add(dto);
                }
            }
        }
        return list;
    }


    

    public RankDTO getUserInfo(String id, int gameSeq) throws Exception {
    	
    	 String sql = "SELECT nickname, score, rank FROM ( "
                 + "    SELECT m.nickname, s.score, ROW_NUMBER() OVER (ORDER BY s.score DESC) AS rank "
                 + "    FROM members m "
                 + "    JOIN game_score s ON m.id = s.member_id "
                 + "    WHERE s.game_seq = ? "
                 + ") ranking "
                 + "WHERE nickname = (SELECT nickname FROM members WHERE id = ?)";

        try (Connection con = DBConfig.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql)) {
            pstat.setInt(1, gameSeq);
            pstat.setString(2, id); // Set member ID
            try (ResultSet rs = pstat.executeQuery()) {
                if (rs.next()) {
                    String nickname = rs.getString("nickname");
                    
                    int score = rs.getInt("score");
                    int rank = rs.getInt("rank");
                    return new RankDTO(nickname, null, score, rank);
                }
            }
        }
        return null;
    }
    
}

