package rank.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
    
    public List<RankDTO> selectRank(int game_seq) throws Exception {
        String sql = "SELECT nickname, avatar, score, 순위 FROM (SELECT m.nickname, m.avatar, s.score,ROW_NUMBER() OVER (ORDER BY s.score DESC) AS 순위  FROM members m JOIN game_score s ON m.id = s.member_id WHERE s.game_seq = ? )WHERE 순위 BETWEEN 1 AND 20";
        List<RankDTO> list = new ArrayList<>();
        try (Connection con = DBConfig.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql)) {
        	pstat.setInt(1, game_seq);
        	try(ResultSet rs = pstat.executeQuery()){
            while (rs.next()) {
                String nickname = rs.getString("nickname");
                String avatar = rs.getString("avatar");
                int score = rs.getInt("score");
                int rank = rs.getInt("순위"); // 순위 컬럼 이름 사용
                RankDTO dto = new RankDTO(nickname, avatar, score, rank);
                list.add(dto);
            }
        }
        return list;
    }
    }
     public List<RankDTO> myRank (String nickname, int game_seq) throws Exception{
    	 String sql = "select nickname,score,순위 from (select m.nickname as 닉네임. gs.score as 점수 , rank() over (order by gs.score desc) as 순위 from members m join (select memberid, max(score) as score from game_score where game_seq = ? group by member_id) gs on m.id = gs.memberid ) where nickname=?";
    	 List<RankDTO> list = new ArrayList<>();
    	   try (Connection con = DBConfig.getConnection();
    	             PreparedStatement pstat = con.prepareStatement(sql)) {
    		   pstat.setInt(1, game_seq);
    		   pstat.setString(2, nickname);
    		   try(ResultSet rs = pstat.executeQuery()){
    			   while(rs.next()) {
    				   rs.getString(nickname);
    				   int score = rs.getInt("score");
    				   int rank = rs.getInt("순위");
    				   
    				   RankDTO dto = new RankDTO(nickname, null, score, rank);
    				   list.add(dto);
    			   }
    		   }
    	   }return list;
     }
}
