package files.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import files.dto.FilesDTO;

public class FilesDAO {
	private static FilesDAO instance;
	
	public static FilesDAO  getInstance() {
		if(instance==null) instance=new FilesDAO();
		return instance;
	}
	
	private FilesDAO() {}
	
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		DataSource db = (DataSource) ctx.lookup("java:comp/env/jdbc/oracle");
		return db.getConnection();
	}
	
	public void insert(FilesDTO dto) {
		String sql="insert into files values(files_seq.nextval,?,?,?)";
		try (Connection con=this.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql)){
			pstat.setString(1, dto.getOriname());
			pstat.setString(2, dto.getSysname());
			pstat.setInt(3, dto.getBoard_seq());
			pstat.executeUpdate();
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	}
	
	public List<FilesDTO> select(int board_seq){
		List<FilesDTO> list= new ArrayList<>();
		String sql="select *from files where board_seq=?";
		try (Connection con=this.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql)){
			pstat.setInt(1, board_seq);
			
			try (ResultSet rs=pstat.executeQuery()){
				while(rs.next()) {
					int seq=rs.getInt(1);
					String oriname=rs.getString(2);
					String sysname=rs.getString(3);
					
					list.add(new FilesDTO(seq,oriname,sysname,board_seq));
				}
				
			} catch (Exception e) {
				// TODO: handle exception
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		
		
		return list;
	}
}
