package members.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import commons.DBConfig;
import members.dto.MembersDTO;

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
	}
	
	
	/**
	 * "내정보" 출력
	 * 
	 * @param loginID
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

}
