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
	
	public boolean delete() {
		String sql="delete from images where parent_seq=999999";
		boolean result=false;
		try (Connection con=DBConfig.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql)){
			if(pstat.executeUpdate()>0)result=true;
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return result;
	}
	
	/**
	 * 마이페이지_ 아바타 사진 업데이트
	 * @param oriname
	 * @param sysname
	 * @param member_id
	 * @return
	 */
	public boolean updateMypage(String oriname, String sysname, String member_id) {
		String sql="update images set oriname=?,sysname=? where image_code=2 and member_id=?";
		boolean result=false;
		try (Connection con=DBConfig.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql)){
			pstat.setString(1, oriname);
			pstat.setString(2, sysname);
			pstat.setString(3, member_id);
			if(pstat.executeUpdate()>0)result=true;
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return result;
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
		String sql="update images set parent_seq=? where parent_seq=999999";
		try (Connection con=DBConfig.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql)){
			pstat.setInt(1, board_seq);
			pstat.executeUpdate();
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	}
	
	
	/**
	 * 서버에 저장된 이미지의 이름을 찾는 메서드
	 * @param parent_seq
	 * @param imageCode
	 * @return
	 * @throws Exception
	 */
	public String getImageName(int parent_seq, int imageCode) throws Exception {
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
	 * 게임 추가시 섬네일을 저장하는 메서드
	 * @param path
	 * @param oriName
	 * @param sysName
	 * @param seq
	 * @return
	 * @throws Exception
	 */
	public int GameThumbnailInsert(String oriName, String sysName, int path, int seq) throws Exception {
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
	 * 게임 섬네일을 삭제하는 메서드
	 * @param imageCode
	 * @param parentSeq
	 * @return
	 * @throws Exception
	 */
	public int GameThumbnailDelete(int imageCode, int parentSeq) throws Exception {
		String sql = "delete from images where image_code = ? and parent_seq = ?";
		
		try(Connection con = DBConfig.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql)){
			pstat.setInt(1, imageCode);
			pstat.setInt(2, parentSeq);
			
			return pstat.executeUpdate();
		}
	}
	
}
