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
		String sql = "select id, pw from members where id = ? and grade in (98, 99)";
		
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
	 * 선택된 멤버의 정보를 반환하는 메서드
	 * @param memberId
	 * @return
	 * @throws Exception
	 */
	public MembersDTO getMemberInfo(String memberId) throws Exception {
		String sql = "select * from members where id = ?";
		
		try(Connection con = DBConfig.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql)){
			pstat.setString(1, memberId);
			
			try (ResultSet rs = pstat.executeQuery()){
				rs.next();
				
				String id = rs.getString("id");
				String name = rs.getString("name");
				String nickname = rs.getString("nickname");
				String phone = rs.getString("phone");
				String email = rs.getString("email");
				String gender = rs.getString("gender");
				String birth = rs.getString("birth");
				int grade = rs.getInt("grade");
				Timestamp join_date = rs.getTimestamp("join_date");
				
				return new MembersDTO(id, null, name, nickname, phone, email, gender, birth, grade, null, join_date);
					
			}
		}
	}
	
	
	/**
	 * 멤버의 등급을 수정하는 메서드
	 * @param id
	 * @param grade
	 * @return
	 * @throws Exception
	 */
	public int memberGradeUpdate(String id, int grade) throws Exception {
		String sql="update members set grade = ? where id = ?";
		
		try(Connection con = DBConfig.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql)){
			pstat.setInt(1, grade);
			pstat.setString(2, id);
			
			return pstat.executeUpdate();
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
					String discription = rs.getString("discription");
					String contents = rs.getString("contents");
					String thumbnail = rs.getString("thumbnail");
					int service_code = rs.getInt("service_code");
					
					list.add(new GameDTO(seq, title, discription, contents, thumbnail, service_code));
				}
				
				return list;
			}
		}
	}
	

	/**
	 * 게임 정보를 반환하는 메서드
	 * @param gameSeq
	 * @return
	 * @throws Exception
	 */
	public GameDTO getGameInfo(int gameSeq) throws Exception {
		String sql = "select * from game where seq = ?";
		try(Connection con = DBConfig.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql)){
			pstat.setInt(1, gameSeq);
			try (ResultSet rs = pstat.executeQuery()){
					
				rs.next();
				
				int seq = rs.getInt("seq");
				String title = rs.getString("title");
				String discription = rs.getString("discription");
				String contents = rs.getString("contents");
				String thumbnail = rs.getString("thumbnail");
				int service_code = rs.getInt("service_code");
				
				return new GameDTO(seq, title, discription, contents, thumbnail, service_code);
					
			}
		}
	}
	
	/**
	 * 서버에 저장된 이미지의 이름을 찾는 메서드
	 * @param parent_seq
	 * @param imageCode
	 * @return
	 * @throws Exception
	 */
	public String getThumbnailName(int parent_seq, int imageCode) throws Exception {
		String sql = "select * from images where image_code = ? and parent_seq = ?";
		try(Connection con = DBConfig.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql)){
			pstat.setInt(1, imageCode);
			pstat.setInt(2, parent_seq);
			try (ResultSet rs = pstat.executeQuery()){
					
				if(rs.next()) {
					return rs.getString("sysname");	
				} else {
					return "none";
				}
				
				
			}
		}
	}
	
	
	/**
	 * 게임을 추가하는 메서드
	 * @param title
	 * @param discription
	 * @param contents
	 * @param thumbnail
	 * @return
	 * @throws Exception
	 */
	public int adminGameInsert(String title, String discription, String contents, String thumbnail) throws Exception {
		String sql = "insert into game values(game_seq.nextval, ?, ?, ?, ?, 0)";
		
		try(Connection con = DBConfig.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql, new String[] {"seq"})){
			pstat.setString(1, title);
			pstat.setString(2, discription);
			pstat.setString(3, contents);
			pstat.setString(4, thumbnail);
			
			pstat.executeQuery();
			
			try(ResultSet rs = pstat.getGeneratedKeys()){
				if(rs.next()) {
					return rs.getInt(1);
				} else {
					return 0;
				}
				
			}
			
		}
		
	}
	
	
	/**
	 * 게임 추가시 섬네일을 저장하는 메서드
	 * @param path
	 * @param oriName
	 * @param sysName
	 * @param seq
	 * @return
	 * @throws Exception
	 */
	public int adminGameThumbnailInsert(String oriName, String sysName, int path, int seq) throws Exception {
		String sql = "insert into images values(images_seq.nextval, ?, ?, ?, ?, null)";
		
		try(Connection con = DBConfig.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql)){
			pstat.setString(1, oriName);
			pstat.setString(2, sysName);
			pstat.setInt(3, path);
			pstat.setInt(4, seq);
			
			return pstat.executeUpdate();
		}
	}
	
	
	/**
	 * 게임을 삭제하는 메서드
	 * @param seq
	 * @return
	 * @throws Exception
	 */
	public int adminGameDelete(int seq) throws Exception {
		String sql ="delete from game where seq = ?";
		
		try(Connection con = DBConfig.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql)){
			pstat.setInt(1, seq);
			
			return pstat.executeUpdate();
		}
			
	}
	
}
