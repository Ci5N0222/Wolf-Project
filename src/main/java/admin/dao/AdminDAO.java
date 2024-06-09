package admin.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import game.dto.GameDTO;
import members.dto.MembersDTO;

public class AdminDAO {
	private static AdminDAO instance;
	
	public static AdminDAO  getInstance() {
		if(instance == null) instance = new AdminDAO();
		return instance;
	}
	
	private AdminDAO() {}
	
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		DataSource db = (DataSource) ctx.lookup("java:comp/env/jdbc/oracle");
		return db.getConnection();
	}
	
	
	/**
	 * 총 회원수와 남자 회원의 회원수를 반환하는 메서드
	 * @return
	 * @throws Exception
	 */
	public int[] membersTotalCount() throws Exception {
		String sql = "select count(*), (select count(*) from members where gender = 'M') from members where grade != 99";
		try(Connection con = getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);
			ResultSet rs = pstat.executeQuery()){
			rs.next();
			
			return new int[]{rs.getInt(1), rs.getInt(2)};
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
		String sql = "select member_id, member_pw from members where id = ? and grade = 99";
		try(Connection con = getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery()){
				
				rs.next();
				
				if(rs.getString("id") != null) {
					if(pw.equals(rs.getString("pw"))) {
						// 비밀번호까지 맞는 경우
						return 1;
					} else {
						// id는 맞고 비밀번호가 틀린 경우
					}
				} else {
					// 존재하지 않는 아이디
				}
				
			}
		
		return 0;
	}
	
	
	/**
	 * 멤버 목록을 반환하는 메서드
	 * @return
	 * @throws Exception
	 */
	public List<MembersDTO> getMemberList() throws Exception {
		String sql ="select * from members where grade != 99";
		try(Connection con = getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);
			ResultSet rs = pstat.executeQuery()){
			
			List<MembersDTO> list = new ArrayList<>();
			while(rs.next()) {
				String id = rs.getString("id");
				// 그외 정보
				
				list.add(new MembersDTO());
			}
			
			return list;
		}
	}
	
	
	
	
	/**
	 * 서비스 중인 게임 목록을 반환하는 메서드
	 * @return
	 * @throws Exception
	 */
	public List<GameDTO> getGameList() throws Exception {
		String sql = "select * from game";
		try(Connection con = getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);
			ResultSet rs = pstat.executeQuery()){
			
			List<GameDTO> list = new ArrayList<>();
			while(rs.next()) {
				int seq = rs.getInt("seq");
				// 그외 정보
				
				list.add(new GameDTO());
			}
			
			return list;
		}
	}
	
}
