package members.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import commons.DBConfig;
import members.dto.MembersDTO;
import mypage.dto.GameScoreDTO;

public class MembersDAO {
	public static MembersDAO instance;

	public synchronized static MembersDAO getinstance() {
		if (instance == null) {
			instance = new MembersDAO();
		}
		return instance;
	}

	private MembersDAO() {
	}

	public int insert(MembersDTO dto) throws Exception {
		String sql = "insert into members values(?,?,?,?,?,?,?,?,?,?,sysdate)";
		try (Connection con=DBConfig.getConnection(); PreparedStatement pstat = con.prepareStatement(sql)) {
			pstat.setString(1, dto.getId());
			pstat.setString(2, dto.getPw());
			pstat.setString(3, dto.getName());
			pstat.setString(4, dto.getNickname());
			pstat.setString(5, dto.getPhone());
			pstat.setString(6, dto.getEmail());
			pstat.setString(7, dto.getGender());
			pstat.setString(8, dto.getBirth());
			pstat.setInt(9, dto.getGrade());
			pstat.setString(10, dto.getAvatar());

			return pstat.executeUpdate();

		}
	}

	public boolean CheckById(String id) throws Exception {
		String sql = "SELECT * FROM members WHERE id = ?";
		try (Connection con=DBConfig.getConnection(); PreparedStatement pstat = con.prepareStatement(sql)) {
			pstat.setString(1, id);
			try (ResultSet rs = pstat.executeQuery()) {
				return rs.next();
			}
		}
	}

	public boolean CheckByNickname(String nickname) throws Exception {
		String sql = "SELECT * FROM members WHERE nickname = ?";
		try (Connection con=DBConfig.getConnection(); PreparedStatement pstat = con.prepareStatement(sql)) {
			pstat.setString(1, nickname);
			try (ResultSet rs = pstat.executeQuery()) {
				return rs.next();
			}
		}
	}

	public String[] login(String id, String pw) throws Exception {
		String sql = "select * from members where id = ? and pw = ?";
		try (Connection con=DBConfig.getConnection(); PreparedStatement pstat = con.prepareStatement(sql)) {
			pstat.setString(1, id);
			pstat.setString(2, pw);
			try (ResultSet rs = pstat.executeQuery()) {
				if (rs.next()) {
					String[] result = new String[3];
					result[0] = rs.getString(1);
					result[1] = rs.getString(4);
					result[2] = rs.getString(10);
					return result;
				} else {
					return new String[0];
				}

			}
		}
	}    public boolean checklogin(String id, String pw) throws Exception {
        String sql = "select * from members where id = ? and pw = ?";
        try (Connection con=DBConfig.getConnection(); PreparedStatement pstat = con.prepareStatement(sql)) {
            pstat.setString(1, id);
            pstat.setString(2, pw);
            try (ResultSet rs = pstat.executeQuery()) {
                return rs.next();
            }
        }
    }
	public int updatePassword(String email, String newPassword) throws Exception {
        String sql = "UPDATE members SET pw = ? WHERE email = ? ";
        try (Connection con=DBConfig.getConnection(); PreparedStatement pstat = con.prepareStatement(sql)) {
            pstat.setString(1, newPassword);
            pstat.setString(2, email);
            return pstat.executeUpdate();
        }
    }
    public String selectID(String name, String email) throws Exception {
        String sql = "SELECT id FROM members WHERE email = ? AND name = ?";
        try (Connection con=DBConfig.getConnection(); PreparedStatement pstat = con.prepareStatement(sql)) {
            pstat.setString(1, email);
            pstat.setString(2, name);
            try (ResultSet rs = pstat.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("id");
                } else {
                    return null;
                }
            }
        }
    }
    public boolean checkPassword(String email, String pw) throws Exception {
    	String sql = "select * from members where email = ? and pw = ?";
    	 try (Connection con=DBConfig.getConnection();
    	         PreparedStatement pstmt = con.prepareStatement(sql)) {
    	        pstmt.setString(1, email);
    	        pstmt.setString(2, pw);
    	        try (ResultSet rs = pstmt.executeQuery()) {
    	            return rs.next(); // 결과가 존재하면 true, 아니면 false 반환
    	        }
    	    } 
    	    
    	}
    public boolean selectMemberByIdAndEmail(String id, String email) throws Exception{
       
        String sql = "SELECT * FROM members WHERE id=? AND email=?";
        try (Connection con=DBConfig.getConnection();
   	         PreparedStatement pstmt = con.prepareStatement(sql)){
        	pstmt.setString(1, id);
        	pstmt.setString(2, email);
        		try(ResultSet rs = pstmt.executeQuery()){
        			if(rs.next()) {
        				rs.getString("id");
        				rs.getString("email");
        				return true;
        			}
        		}
        }
		return false;
        	
        }
           
 
	
	
	/**
	 * "내정보" 출력
	 * 
	 * @param loginID
asdasdasda

	 * @return
	 * @throws Exception
	 */
	public MembersDTO selectMember(String loginID) throws Exception {

		String sql = "select * from members where id = ?";

		try (Connection con=DBConfig.getConnection(); PreparedStatement pstat = con.prepareStatement(sql)) {

			pstat.setString(1, loginID);

			try (ResultSet rs = pstat.executeQuery()) {
				while (rs.next()) {
					String id = rs.getString(1);
					System.out.println(id);
					String name = rs.getString(3);
					String nickname = rs.getString(4);
					String phone = rs.getString(5);
					String email = rs.getString(6);
					String gender = rs.getString(7);
					String birth = rs.getString(8);
					int grade = rs.getInt(9);
					String avatar = rs.getString(10);
					Timestamp join_date = rs.getTimestamp(11);
					MembersDTO dto = new MembersDTO(id, null, name, nickname, phone, email, gender, birth, grade,
							avatar, join_date);
					return dto;
				}

				return null;
			}

		}
	}

	/**
	 * 사용자가 수정한 내용 DB에서도 수정
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public int edit(MembersDTO dto) throws Exception {

		String sql = "update members set name =?, nickname =?, phone= ?, email= ?, avatar =? where id = ?";

		try (Connection con=DBConfig.getConnection(); PreparedStatement pstat = con.prepareStatement(sql)) {

			pstat.setString(1, dto.getName());
			pstat.setString(2, dto.getNickname());
			pstat.setString(3, dto.getPhone());
			pstat.setString(4, dto.getEmail());
			pstat.setString(5, dto.getAvatar());
			pstat.setString(6, dto.getId());

			int result = pstat.executeUpdate();
			return result;
		}
	}

	/**
	 * 사용자의 현재 pw가 DB에 등록되어있는 pw와 일치하는지
	 * 
	 * @param id
	 * @param currentPW
	 * @return
	 * @throws Exception
	 */
	public boolean isPWExist(String id, String currentPW) throws Exception {

		String sql = "select * from members where id = ? and pw = ?";

		try (Connection con=DBConfig.getConnection(); PreparedStatement pstat = con.prepareStatement(sql)) {

			pstat.setString(1, id);
			pstat.setString(2, currentPW);

			try (ResultSet rs = pstat.executeQuery()) {
				return rs.next();
			}

		}

	}

	/**
	 * pw 변경
	 * 
	 * @param id
	 * @param newPW
	 * @return
	 * @throws Exception
	 */
	public int updatePW(String id, String newPW) throws Exception {

		String sql = "update members set pw =? where id = ?";

		try (Connection con=DBConfig.getConnection(); PreparedStatement pstat = con.prepareStatement(sql)) {

			pstat.setString(1, newPW);
			pstat.setString(2, id);

			return pstat.executeUpdate();

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
