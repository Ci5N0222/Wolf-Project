package game_score.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import commons.DBConfig;
import game.dto.ScoreDTO;

public class GameScoreDAO {
	
	private GameScoreDAO() {}
	
	private static GameScoreDAO instance;
	
	public static GameScoreDAO  getInstance() {
		if(instance == null) instance = new GameScoreDAO();
		return instance;
	}
	
	// 본인 랭크 조회
//	public ScoreDTO getMyRank(int seq, String id) throws Exception {
//		String sql ="select * from game_score where game_seq = ?, member_id = ?";
//		
//		try(Connection con = DBConfig.getConnection();
//			PreparedStatement pstat = con.prepareStatement(sql)){
//			pstat.setInt(1, seq);
//			pstat.setString(2, id);
//			
//			try(ResultSet rs = pstat.executeQuery()){
//				if(rs.next()) {
//					int score = rs.getInt("score");
//					String memberId = rs.getString("member_id");
//					int gameSeq = rs.getInt("game_seq");
//					
//					return new ScoreDTO(score, memberId, gameSeq);
//							
//				}
//			}
//		}
//	}
	
	/**
	 * 게임 점수 데이터 추가
	 * @param score
	 * @param id
	 * @param seq
	 * @return
	 * @throws Exception
	 */
	public int gameScoreInsert(int score, String id, int seq) throws Exception {
		String sql = "insert into game_score values(?, ?, ?)";
		
		try(Connection con = DBConfig.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql)){
			pstat.setInt(1, score);
			pstat.setString(2, id);
			pstat.setInt(3, seq);
			
			return pstat.executeUpdate();
		}
	}
	
	
	/**
	 * 게임 점수 데이터 업데이트
	 * @param score
	 * @param id
	 * @param seq
	 * @return
	 * @throws Exception
	 */
	public int gameScoreUpdate(int score, String id, int seq) throws Exception {
		String sql = "update game_score set score = ? where member_id = ?, game_seq = ?";
		
		try(Connection con = DBConfig.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql)){
			pstat.setInt(1, score);
			pstat.setString(2, id);
			pstat.setInt(3, seq);
			
			return pstat.executeUpdate();
		}
	}
	
}
