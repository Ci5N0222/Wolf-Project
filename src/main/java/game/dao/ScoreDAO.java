package game.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import commons.DBConfig;
import game.dto.ScoreDTO;

public class ScoreDAO {
	public static ScoreDAO instance;
	
	public synchronized static ScoreDAO getInstance(){
		if(instance == null) {
			instance = new ScoreDAO();
		}
		return instance;
	}
	private ScoreDAO() {
		
	};
	
	public List <ScoreDTO> getThisGameRank (int game_seq) throws Exception{
		String sql = "SELECT * FROM (SELECT * FROM game_score WHERE game_seq = ? ORDER BY score DESC) WHERE ROWNUM <= 3";
		List <ScoreDTO> dto = new ArrayList<>();
		try(
				Connection con= DBConfig.getConnection();
				PreparedStatement ps= con.prepareStatement(sql);
		){
			ps.setInt(1, game_seq);
			try(ResultSet rs= ps.executeQuery()){
				while(rs.next()) {
					ScoreDTO score = new ScoreDTO();
					score.setScore(rs.getInt(1));
					score.setMember_id(rs.getString(2));
					score.setGame_seq(game_seq);
					dto.add(score);
				}
			}
		}
		
		int dtoSize = dto.size();
		if(dtoSize < 3) {
			while(dtoSize < 3) {
				ScoreDTO score = new ScoreDTO();
				score.setScore(0);
				score.setMember_id("");
				score.setGame_seq(game_seq);
				dto.add(score);
				dtoSize ++;
			}
		}
		
		
		return dto;
	}
	
}
