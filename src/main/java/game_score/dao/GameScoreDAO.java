package game_score.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import commons.DBConfig;

public class GameScoreDAO {
	
	private GameScoreDAO() {}
	
	private static GameScoreDAO instance;
	
	public static GameScoreDAO  getInstance() {
		if(instance == null) instance = new GameScoreDAO();
		return instance;
	}
	
	
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
