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
	
	public void delete(int parent_seq, String[] sysnames) {
		String sql="delete from images where sysname not in (";
		  for (int i = 0; i < sysnames.length; i++) {
	            sql += "?";  // placeholder 추가
	            if (i < sysnames.length - 1) {
	                sql += ", ";
	            }
	        }
	        
	        sql += ") and parent_seq = ?";
		try (Connection con=DBConfig.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql)){
			 for (int i = 0; i < sysnames.length; i++) {
	                pstat.setString(i + 1, sysnames[i]);
	            }
			 pstat.setInt(sysnames.length + 1, parent_seq);

			pstat.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	
}
