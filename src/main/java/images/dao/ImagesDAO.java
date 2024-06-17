package images.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import commons.DBConfig;
import images.dto.ImagesDTO;

public class ImagesDAO {
	
	private ImagesDAO() {}
	
	private static ImagesDAO instance;
	
	public static ImagesDAO  getInstance() {
		if(instance == null) instance = new ImagesDAO();
		return instance;
	}
	
	public void insert(ImagesDTO dto) {
		String sql="insert into images values(images_seq.nextval,?,?,?,?,?)";
		try (Connection con=DBConfig.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql)){
			pstat.setString(1, dto.getOriname());
			pstat.setString(2, dto.getSysname());
			pstat.setInt(3, dto.getImage_code());
			pstat.setInt(4, dto.getParent_seq());
			pstat.setString(5, dto.getMember_id());
			pstat.executeUpdate();
			
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	
	public void delete(int seq) {
		String sql="delete from images where seq=?";
		try (Connection con=DBConfig.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql)){
			pstat.setInt(1, seq);
			pstat.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	
}
