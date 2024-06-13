package game.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import commons.DBConfig;
import game.dto.GameDTO;
import mypage.dto.GameScoreDTO;

public class GameDAO {
	public static GameDAO instance;
	public synchronized static GameDAO getInstance() {
		if(instance == null) {
			instance = new GameDAO();
		}
		return instance;
	}
	private GameDAO() {};
	
	
	

	public List<GameDTO> getList() throws Exception {
	    String sql = "select * from game";
	    
	    try (
	    	Connection con = DBConfig.getConnection();
	        PreparedStatement ps = con.prepareStatement(sql);
	        ResultSet rs = ps.executeQuery();
	    ) {
	    	System.out.println("test!!!");
	        List<GameDTO> list = new ArrayList<>();
	        while (rs.next()) {
	        	int seq = rs.getInt(1);
	            String title = rs.getString(2);
	            String contents = rs.getString(3);
	            String thumbnail = rs.getString(4);
	            System.out.println(title+"@");
	            list.add(new GameDTO(seq,title,contents,thumbnail));
	        }
	        System.out.println("getList: " + list);
	        return list;
	    }
	}
	
	
	public GameDTO getDetail (int id) throws Exception{
		String sql = "select * from game where seq = ?";
		
		try(
			Connection con=DBConfig.getConnection();
			PreparedStatement ps=con.prepareStatement(sql);
		){
			ps.setInt(1, id);
			try(ResultSet rs= ps.executeQuery()){
				GameDTO dto = null;
				while(rs.next()) {
					int seq = rs.getInt(1);
		            String title = rs.getString(2);
		            String contents = rs.getString(3);
		            String thumbnail = rs.getString(4);
		            dto = new GameDTO(seq,title,contents,thumbnail);
				}
				return dto;
			}
		}
	}
	
	
	/**
	 * 게임 플레이 정보 출력
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public List<GameScoreDTO> gameList(String id) throws Exception {
		
		String sql = "select * from game_score gs join game g on g.seq = gs.game_seq where member_id = ? order by seq";
		
		try (Connection con=DBConfig.getConnection(); PreparedStatement pstat = con.prepareStatement(sql)) {

			pstat.setString(1, id);
			
			try(ResultSet rs = pstat.executeQuery()){
				
				List<GameScoreDTO> list = new ArrayList<>();
				while (rs.next()) {
					String title = rs.getString("title");
					int score = rs.getInt("score");
					String member_id = rs.getString("member_id");
					int game_seq = rs.getInt("game_seq");
					
					list.add(new GameScoreDTO(title, score, member_id, game_seq ));
				} 
				return list;
			}
		}
		
	}
	

	
}
