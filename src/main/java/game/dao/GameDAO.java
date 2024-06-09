package game.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import game.dto.GameDTO;

public class GameDAO {
	public static GameDAO instance;
	public synchronized static GameDAO getInstance() {
		if(instance == null) {
			instance = new GameDAO();
		}
		return instance;
	}
	private Connection getConnection () throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	private GameDAO() {};
	
	
	

	public List<GameDTO> getList() throws Exception {
	    String sql = "select * from game";
	    
	    try (
	        Connection con = this.getConnection();
	        PreparedStatement ps = con.prepareStatement(sql);
	        ResultSet rs = ps.executeQuery();
	    ) {
	    	
	        List<GameDTO> list = new ArrayList<>();
	        while (rs.next()) {
	        	int seq = rs.getInt(1);
	            String title = rs.getString(2);
	            String contents = rs.getString(3);
	            String thumbnail = rs.getString(4);
	            System.out.println("test");
	            list.add(new GameDTO(seq,title,contents,thumbnail));
	        }
	        System.out.println("getList: " + list);
	        return list;
	    }
	}
	
	
	public GameDTO getDetail (int id) throws Exception{
		String sql = "select * from game where seq = ?";
		
		try(
			Connection con= this.getConnection();
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
	

	
}
