package board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import board.dto.BoardDTO;

public class BoardDAO {
private static BoardDAO instance;
	
	public static BoardDAO  getInstance() {
		if(instance==null) instance=new BoardDAO();
		return instance;
	}
	
	private BoardDAO() {}
	
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		DataSource db = (DataSource) ctx.lookup("java:comp/env/jdbc/oracle");
		return db.getConnection();
	}
	
	public Object[] selectAll(){
		List<BoardDTO> list = new ArrayList<>();
		String sql="select b.*, m.nickname from board b join members m on m.id =b.member_id";
		Object [] boardList=new Object[2];
		String nickname="";
		try (Connection con=this.getConnection();
				PreparedStatement pstat= con.prepareStatement(sql);
				ResultSet rs=pstat.executeQuery()){
			
			while(rs.next()) {
				int seq=rs.getInt(1);
				String title=rs.getString(2);
				String contents=rs.getString(3);
				int count =rs.getInt(4);
				String member_id=rs.getString(5);
				Timestamp write_date=rs.getTimestamp(6);
				nickname=rs.getString(7);
				list.add(new BoardDTO(seq,title,contents,count,member_id,write_date));
				
				
			}
		
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		
		boardList[0]=list;
		boardList[1]= nickname;
		return boardList;
		
	}
	public Object[] selectBoard(int seq){
		BoardDTO dto= new BoardDTO();
		String sql="select b.*, m.nickname from board b join members m on m.id =b.member_id where b.seq=?";
		Object [] boardList=new Object[2];
		String nickname="";
		try (Connection con=this.getConnection();
				PreparedStatement pstat= con.prepareStatement(sql);){
			pstat.setInt(1, seq);
			try(ResultSet rs=pstat.executeQuery()) {
				rs.next();
					String title=rs.getString(2);
					String contents=rs.getString(3);
					int count =rs.getInt(4);
					String member_id=rs.getString(5);
					Timestamp write_date=rs.getTimestamp(6);
					nickname=rs.getString(7);
					dto=(new BoardDTO(seq,title,contents,count,member_id,write_date));
			} catch (Exception e) {
				
			}
		} catch (Exception e) {
			
		}
		
		boardList[0]=dto;
		boardList[1]= nickname;
		return boardList;
	}
	
	public void delete(int seq) {
		String sql="delete from board where seq=?";
		try (Connection con=this.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql)){
			pstat.setInt(1, seq);
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	
	public void deleteMember(String member_id) {
		String sql="delete from board where member_id=?";
		try (Connection con=this.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql)){
			pstat.setString(1, member_id);
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	
	public void update(BoardDTO dto) {
		String sql="update board set title=?,contents=? , write_date=sysdate where seq=?";
		
		try (Connection con=this.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql)){
			pstat.setString(1, dto.getTitle());
			pstat.setString(2, dto.getContents());
			pstat.setInt(3, dto.getSeq());
			pstat.executeUpdate();
			
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
}
