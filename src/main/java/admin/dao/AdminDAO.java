package admin.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import admin.dto.AdminDTO;
import board.dto.BoardDTO;
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
	 * 연령별 회원의 수를 반환하는 메서드
	 * @return
	 * @throws Exception
	 */
	public List<AdminDTO.AdminAgeGroupDTO> membersAgeCount() throws Exception {
		String sql = 
			"WITH age_groups AS ( "
					+ "SELECT '10대 이하' AS age FROM dual UNION ALL "
					+ "SELECT '20대' FROM dual UNION ALL "
					+ "SELECT '30대' FROM dual UNION ALL "
					+ "SELECT '40대' FROM dual UNION ALL "
					+ "SELECT '50대' FROM dual UNION ALL "
					+ "SELECT '60대 이상' FROM dual) "
			+"SELECT ag.age, COALESCE(count(m.birth), 0) AS members_count "
			+"FROM "
				+"age_groups ag "
				+"LEFT JOIN ( "
					+ "SELECT "
						+ "CASE "
							+ "WHEN to_char(sysdate, 'yyyy') - substr(birth, 1, 4) < 20 THEN '10대 이하' "
							+ "WHEN to_char(sysdate, 'yyyy') - substr(birth, 1, 4) BETWEEN 20 AND 29 THEN '20대' "
							+ "WHEN to_char(sysdate, 'yyyy') - substr(birth, 1, 4) BETWEEN 30 AND 39 THEN '30대' "
							+ "WHEN to_char(sysdate, 'yyyy') - substr(birth, 1, 4) BETWEEN 40 AND 49 THEN '40대' "
							+ "WHEN to_char(sysdate, 'yyyy') - substr(birth, 1, 4) BETWEEN 50 AND 59 THEN '50대' "
							+ "ELSE '60대 이상' "
						+ "END AS age, birth "
					+ "FROM "
						+ "MEMBERS "
				+ ") m "
				+ "ON ag.age = m.age "
			+ "GROUP BY ag.age "
			+ "ORDER BY ag.age ";
		
		try(Connection con = DBConfig.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);
			ResultSet rs = pstat.executeQuery()){
			
			List<AdminDTO.AdminAgeGroupDTO> list = new ArrayList<>();
			
			while(rs.next()) {
				String age = rs.getString("age");
				int membersCount = rs.getInt("members_count");
				list.add(new AdminDTO.AdminAgeGroupDTO(age, membersCount));
			}
			
			return list;
		}
	}
	
	
	/**
	 * 관리자 로그인
	 * @param id
	 * @param pw
	 * @return
	 * @throws Exception
	 */
	public MembersDTO adminLogin(String loginId, String loginPw) throws Exception {
		String sql = "select * from members where id = ? and grade in (98, 99)";
		
		try(Connection con = DBConfig.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql)){
			pstat.setString(1, loginId);
			
			try(ResultSet rs = pstat.executeQuery()){
				
				rs.next();
				String id = rs.getString("id");
				String name = rs.getString("name");
				String nickname = rs.getString("nickname");
				String phone = rs.getString("phone");
				String email = rs.getString("email");
				String gender = rs.getString("gender");
				String birth = rs.getString("birth");
				int grade = rs.getInt("grade");
				String avatar = rs.getString("avatar");
				Timestamp joinDate = rs.getTimestamp("join_date");
				
				try {
					if(id != null) {
						if(loginPw.equals(rs.getString("pw"))) return new MembersDTO(id, null, name, nickname, phone, email, gender, birth, grade, avatar, joinDate);
					}
					return null;
					
				} catch (Exception e) {
					e.printStackTrace();
					return null;
				}
			}
		}
	}
	
	
	/**
	 * 회원수를 반환하는 메서드
	 * @return
	 * @throws Exception
	 */
	public int getMemberTotalCount(int param) throws Exception {
		String sql ="";
		if(param == 0) {
			sql = "select count(*) from members";
		} else {
			sql = "select count(*) from members where grade = ?";
		}
		
		try(Connection con = DBConfig.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql)){
			if(param != 0) pstat.setInt(1, param);
			
			try(ResultSet rs = pstat.executeQuery()){
				rs.next();
				
				return rs.getInt(1);
			}
		}
	}
	
	
	/**
	 * 지정된 숫자만큼 멤버 목록을 반환하는 메서드
	 * @return
	 * @throws Exception
	 */
	public List<MembersDTO> getMemberList(int memberGrade, int start, int end) throws Exception {
		String sql = "";
		if(memberGrade == 0) {
			sql = "select * from (select members.*, row_number() over(order by join_date desc) rown from members) where rown between ? and ?";
		} else {
			sql = "select * from (select members.*, row_number() over(order by join_date desc) rown from members where grade = ?) where rown between ? and ?";
		}
		
		try(Connection con = DBConfig.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql)){
			if(memberGrade != 0) {
				pstat.setInt(1, memberGrade);
				pstat.setInt(2, start);
				pstat.setInt(3, end);
			} else {
				pstat.setInt(1, start);
				pstat.setInt(2, end);
			}
			
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
	 * 검색한 회원수를 반환하는 메서드
	 * @return
	 * @throws Exception
	 */
	public int getMemberSearchCount(String memberId) throws Exception {
		String sql ="select count(*) from members where id = ?";
		
		try(Connection con = DBConfig.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql)){
			pstat.setString(1, memberId);
			
			try(ResultSet rs = pstat.executeQuery()){
				rs.next();
				
				return rs.getInt(1);
			}
		}
	}
	
	/**
	 * 검색한 멤버의 목록을 반환하는 메서드
	 * @param start
	 * @param end
	 * @param memberId
	 * @return
	 * @throws Exception
	 */
	public List<MembersDTO> getMemberSearch(int start, int end, String memberId) throws Exception {
		String sql = "select * from (select members.*, row_number() over(order by join_date desc) rown from members) where id like ? and rown between ? and ?";
		
		try(Connection con = DBConfig.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql)){
				pstat.setString(1, "%" + memberId + "%");	
				pstat.setInt(2, start);
				pstat.setInt(3, end);
				
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
	public int getGameTotalCount(int param) throws Exception {
		String sql ="";
		if(param == 9) {
			sql = "select count(*) from game";
		} else {
			sql = "select count(*) from game where service_code = ?";
		}
		
		try(Connection con = DBConfig.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql)){
			if(param != 9) pstat.setInt(1, param);
			
			try(ResultSet rs = pstat.executeQuery()){
				rs.next();
				
				return rs.getInt(1);
			}
		}
	}
	
	

	/**
	 * 지정된 숫자만큼 게임 목록을 반환하는 메서드
	 * @param start
	 * @param end
	 * @return
	 * @throws Exception
	 */
	public List<GameDTO> getGameList(int gameService, int start, int end) throws Exception {
		String sql = "";
		if(gameService == 9) {
			sql = "select * from (select game.*, row_number() over(order by seq) rown from game) where rown between ? and ?";
		} else {
			sql = "select * from (select game.*, row_number() over(order by seq) rown from game where service_code = ?) where rown between ? and ?";
		}
		
		try(Connection con = DBConfig.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql)){
			if(gameService != 9) {
				pstat.setInt(1, gameService);
				pstat.setInt(2, start);
				pstat.setInt(3, end);
			} else {
				pstat.setInt(1, start);
				pstat.setInt(2, end);
			}
			
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
	 * 게임 정보를 업데이트하는 메서드
	 * @param seq
	 * @param title
	 * @param discription
	 * @param contents
	 * @param oriname
	 * @return
	 * @throws Exception
	 */
	public int adminGameUpdate(int seq, String title, String discription, String contents, String oriname, String service) throws Exception {
		String sql = "";
		if(oriname != null) {
			sql = "update game set title = ?, discription =?, contents = ?, thumbnail = ?, service_code = ? where seq = ?";
		} else {
			sql = "update game set title = ?, discription =?, contents = ?, service_code = ? where seq = ?";
		}
		
		try(Connection con = DBConfig.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql)){
			pstat.setString(1, title);
			pstat.setString(2, discription);
			pstat.setString(3, contents);
			if(oriname != null) {
				pstat.setString(4, oriname);
				pstat.setString(5, service);
				pstat.setInt(6, seq);
			} else {
				pstat.setString(4, service);
				pstat.setInt(5, seq);
			}
			
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
	
	
	/**
	 * 게시물의 개수를 반환하는 메서드
	 * @param code
	 * @return
	 * @throws Exception
	 */
	public int getBoardTotalCount() throws Exception {
		String sql = "select count(*) from board where board_code = 2";
				
		try(Connection con = DBConfig.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);
			ResultSet rs = pstat.executeQuery()){
			rs.next();
			
			return rs.getInt(1);
		}
	}
	
	
	/**
	 * 게시물의 목록을 반환하는 메서드
	 * @param start
	 * @param end
	 * @return
	 * @throws Exception
	 */
	public List<AdminDTO.BoardListDTO> getBoardList(int code, int start, int end) throws Exception {
		String sql = "select a.*,m.nickname nickname from (select board.*, row_number() over(order by seq) rown from board where board_code = ?) a join members m on m.id=a.member_id where rown between ? and ?";
		
		try(Connection con = DBConfig.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql)){
			pstat.setInt(1, code);
			pstat.setInt(2, start);
			pstat.setInt(3, end);
			
			try(ResultSet rs = pstat.executeQuery()){
				List<AdminDTO.BoardListDTO> list = new ArrayList<>();
				
				while(rs.next()) {
					int seq = rs.getInt("seq");
					String title = rs.getString("title");
					String contents = rs.getString("contents");
					int count = rs.getInt("count");
					String memberId = rs.getString("member_id");
					String nickName = rs.getString("nickname");
					int boardCode = rs.getInt("board_code");
					Timestamp writeDate = rs.getTimestamp("write_date");
					
					list.add(new AdminDTO.BoardListDTO(seq, title, contents, count, memberId, nickName, boardCode, writeDate));
				}
				
				return list;
			}
		}
	}
	
	
	
}
