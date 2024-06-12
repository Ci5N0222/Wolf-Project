package admin.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import commons.DBConfig;
import game.dto.GameDTO;
import members.dto.MembersDTO;

public class AdminDAO {
	
	private AdminDAO() {}
	
	private static AdminDAO instance;
	
	public static AdminDAO  getInstance() {
		if(instance == null) instance = new AdminDAO();
		return instance;
	}
	
	/**
	 * 총 회원수와 남자 회원의 회원수를 반환하는 메서드
	 * @return
	 * @throws Exception
	 */
	public int[] membersTotalCount() throws Exception {
		String sql = "select (select count(*) from members) as \"total\", (select count(*) from members where gender = 'M') as \"man\" from dual";
		try(Connection con = DBConfig.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);
			ResultSet rs = pstat.executeQuery()){
			rs.next();
			
			return new int[]{rs.getInt("total"), rs.getInt("man")};
		}
	}
	
	
	/**
	 * 관리자 로그인
	 * @param id
	 * @param pw
	 * @return
	 * @throws Exception
	 */
	public int adminLogin(String id, String pw) throws Exception {
		String sql = "select id, pw from members where id = ? and grade = 99";
		try(Connection con = DBConfig.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql)){
			pstat.setString(1, id);
			
			try(ResultSet rs = pstat.executeQuery()){
				
				rs.next();
				
				try {
					if(rs.getString("id") != null) {
						if(pw.equals(rs.getString("pw"))) return 1;
					}
					return 2;
					
				} catch (Exception e) {
					e.printStackTrace();
					return 2;
				}
			}
		}
	}
	
	
	/**
	 * 총 회원수를 반환하는 메서드
	 * @return
	 * @throws Exception
	 */
	public int getMemberTotalCount() throws Exception {
		String sql ="select count(*) from members where grade not in (98, 99)";
		try(Connection con = DBConfig.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);
			ResultSet rs = pstat.executeQuery()){
			
			rs.next();
			
			return rs.getInt(1);
		}
	}
	
	
	/**
	 * 지정된 숫자만큼 멤버 목록을 반환하는 메서드
	 * @return
	 * @throws Exception
	 */
	public List<MembersDTO> getMemberList(int start, int end) throws Exception {
		String sql = "select * from (select members.*, row_number() over(order by join_date desc) rown from members) where rown between ? and ?";
		try(Connection con = DBConfig.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql)){
			pstat.setInt(1, start);
			pstat.setInt(2, end);
			try (ResultSet rs = pstat.executeQuery()){
				List<MembersDTO> list = new ArrayList<>();
				
				while(rs.next()) {
					String id = rs.getString("id");
					String name = rs.getString("name");
					String nickname = rs.getString("nickname");
					String phone = rs.getString("phone");
					String email = rs.getString("email");
					String gender = rs.getString("gender");
					String birth = rs.getString("birth");
					int grade = rs.getInt("grade");
					Timestamp join_date = rs.getTimestamp("join_date");
					
					list.add(new MembersDTO(id, null, name, nickname, phone, email,gender, birth, grade, null, join_date));
				}
				
				return list;
			}
		}
	}
	
	
	/**
	 * 모든 멤버 목록을 반환하는 메서드
	 * @return
	 * @throws Exception
	 */
	public List<MembersDTO> getMemberListAll() throws Exception {
		String sql ="select * from members where grade not in (98, 99)";
		try(Connection con = DBConfig.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);
			ResultSet rs = pstat.executeQuery()){
			
			List<MembersDTO> list = new ArrayList<>();
			while(rs.next()) {
				String id = rs.getString("id");
				String name = rs.getString("name");
				String nickname = rs.getString("nickname");
				String phone = rs.getString("phone");
				String email = rs.getString("email");
				String gender = rs.getString("gender");
				String birth = rs.getString("birth");
				int grade = rs.getInt("grade");
				Timestamp join_date = rs.getTimestamp("join_date");
				// 그외 정보
				
				list.add(new MembersDTO(id, null, name, nickname, phone, email,gender, birth, grade, null, join_date));
			}
			
			return list;
		}
	}
	
	
	/**
	 * 게임의 총 개수를 반환하는 메서드
	 * @return
	 * @throws Exception
	 */
	public int getGameTotalCount() throws Exception {
		String sql ="select count(*) from game";
		try(Connection con = DBConfig.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);
			ResultSet rs = pstat.executeQuery()){
			
			rs.next();
			return rs.getInt(1);
		}
	}
	

	/**
	 * 지정된 숫자만큼 게임 목록을 반환하는 메서드
	 * @param start
	 * @param end
	 * @return
	 * @throws Exception
	 */
	public List<GameDTO> getGameList(int start, int end) throws Exception {
		String sql = "select * from (select game.*, row_number() over(order by seq) rown from game) where rown between ? and ?";
		try(Connection con = DBConfig.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql)){
				pstat.setInt(1, start);
				pstat.setInt(2, end);
				try(ResultSet rs = pstat.executeQuery()){
				
				List<GameDTO> list = new ArrayList<>();
				while(rs.next()) {
					int seq = rs.getInt("seq");
					String title = rs.getString("title");
					String contents = rs.getString("contents");
					String thumbnail = rs.getString("thumbnail");
					
					list.add(new GameDTO(seq, title, contents, thumbnail));
				}
				
				return list;
			}
		}
	}
	
	
	/**
	 * 모든 게임 목록을 반환하는 메서드
	 * @return
	 * @throws Exception
	 */
	public List<GameDTO> getGameListAll() throws Exception {
		String sql = "select * from game";
		try(Connection con = DBConfig.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);
			ResultSet rs = pstat.executeQuery()){
			
			List<GameDTO> list = new ArrayList<>();
			while(rs.next()) {
				int seq = rs.getInt("seq");
				String title = rs.getString("title");
				String contents= rs.getString("contents");
				String thumbnail = rs.getString("thumbnail");
				
				list.add(new GameDTO(seq, title, contents, thumbnail));
			}
			
			return list;
		}
	}
	
}
