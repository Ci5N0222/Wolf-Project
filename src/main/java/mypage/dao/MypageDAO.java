package mypage.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import commons.DBConfig;

public class MypageDAO {
	public static MypageDAO instance;

	public synchronized static MypageDAO getinstance() {
		if (instance == null) {
			instance = new MypageDAO();
		}
		return instance;
	}

	private MypageDAO() {
	}
	
	public String avatar(String id) {
		String sql="select avatar from members where id=?";
		String avatar="";
		try (Connection con =DBConfig.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql)){
			pstat.setString(1, id);
			try (ResultSet rs =pstat.executeQuery()){
				rs.next();
				avatar=rs.getString(1);
				
			} catch (Exception e) {
				// TODO: handle exception
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		
		
		
		
		return avatar;
	}

}
