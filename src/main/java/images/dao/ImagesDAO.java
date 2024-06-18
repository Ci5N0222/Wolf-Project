package images.dao;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

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
	
	public void delete() {
		String sql="delete from images board_seq=999999";
		try (Connection con=DBConfig.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql)){
			pstat.executeUpdate();
			
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	
	public ArrayList<String> delete(int parent_seq,int image_code ,String[] sysnames) {
	
		ArrayList<String> sysnameList= new ArrayList<>();
		String selectsql="select sysname from images where sysname not in (";
		  for (int i = 0; i < sysnames.length; i++) {
			  selectsql += "?";  // placeholder 추가
	            if (i < sysnames.length - 1) {
	            	selectsql += ", ";
	            }
	        }
	        
		  selectsql += ") and parent_seq = ? and image_code=?";
		try (Connection con=DBConfig.getConnection();
				PreparedStatement pstat=con.prepareStatement(selectsql)){
			 for (int i = 0; i < sysnames.length; i++) {
	                pstat.setString(i + 1, sysnames[i]);
	            }
			 pstat.setInt(sysnames.length + 1, parent_seq);
			 pstat.setInt(sysnames.length + 2, image_code);
			 try (ResultSet rs= pstat.executeQuery()){
				while(rs.next()) {
					sysnameList.add(rs.getString(1));
				}
			} catch (Exception e) {
				
			}
		} catch (Exception e) {
			
		}
		
		//
		String sql="delete from images where sysname not in (";
		  for (int i = 0; i < sysnames.length; i++) {
	            sql += "?";  // placeholder 추가
	            if (i < sysnames.length - 1) {
	                sql += ", ";
	            }
	        }
	        
	        sql += ") and parent_seq = ? and image_code=?";
		try (Connection con=DBConfig.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql)){
			 for (int i = 0; i < sysnames.length; i++) {
	                pstat.setString(i + 1, sysnames[i]);
	            }
			 pstat.setInt(sysnames.length + 1, parent_seq);
			 pstat.setInt(sysnames.length + 2, image_code);
			pstat.executeUpdate();
		} catch (Exception e) {
			
		}
		
		return sysnameList;
	}
	
	public void deleteImageFile(String realPath, ArrayList<String> sysnames) {
		for (String sysname : sysnames) {
			 File imageFile = new File(realPath + "/" + sysname);
			 if (imageFile.exists()) {
				   if (imageFile.delete()) {
			         System.out.println("파일 삭제 성공");
				   } else {
			         System.out.println("파일 삭제 실패");
				   }
			    } else {
			    	System.out.println("파일이 존재하지 않습니다.");
			 	}
		}
		
	}
	
	public void updateTemp(int board_seq) {
		String sql="update images set board_seq=? where board_seq=999999";
		try (Connection con=DBConfig.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql)){
			pstat.setInt(1, board_seq);
			pstat.executeUpdate();
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	}
	
	
}
