package members.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import members.dto.*;

public class MemberDAO {
	public static MemberDAO instance;

	public synchronized static MemberDAO getinstance() {
		if (instance == null) {
			instance = new MemberDAO();
		}
		return instance;
	}

	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();

	}

	private MemberDAO() {
	}
	public int insert(MemberDTO dto ) throws Exception{
		String sql = "insert into members values(?,?,?,?,?,?,?,?,?,?,sysdate)";
		try(Connection con = this.getConnection(); 
				PreparedStatement pstat = con.prepareStatement(sql)){
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
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql)) {
			pstat.setString(1, id);
			try (ResultSet rs = pstat.executeQuery()) {
				return rs.next();
			}
		}
	}
	public boolean login(String id, String pw) throws Exception {
		String sql = "select * from members where id = ? and pw = ?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql)) {
			pstat.setString(1, id);
			pstat.setString(2, pw);
			ResultSet rs = pstat.executeQuery();
			return rs.next();

		}
	}
}
