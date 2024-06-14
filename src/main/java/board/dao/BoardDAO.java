package board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import board.dto.BoardDTO;
import commons.DBConfig;

public class BoardDAO {
private static BoardDAO instance;
	
	public static BoardDAO  getInstance() {
		if(instance==null) instance=new BoardDAO();
		return instance;
	}
	
	private BoardDAO() {}
	
	public int insert(BoardDTO dto) {
		String sql="insert into board values(board_seq.nextval,?,?,0,?,?,sysdate)";
		int seq=0;
		try (Connection con=DBConfig.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql,new String[] {"seq"})){
			pstat.setString(1, dto.getTitle());
			pstat.setString(2, dto.getContents());
			pstat.setString(3, dto.getMember_id());
			pstat.setInt(4, dto.getBoard_code());
			
			pstat.executeUpdate();
			try (ResultSet rs=pstat.getGeneratedKeys()){
				rs.next();
				seq=rs.getInt(1);
			} catch (Exception e) {
				// TODO: handle exception
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return seq;
	}
	
	
	public Object[] selectAll(int board_code){
		List<BoardDTO> list = new ArrayList<>();
		String sql="select b.*, m.nickname from board b join members m on m.id =b.member_id";
		Object [] boardList=new Object[2];
		ArrayList<String> nickname=new ArrayList<>();
		
		try (Connection con=DBConfig.getConnection();
				PreparedStatement pstat= con.prepareStatement(sql);
				ResultSet rs=pstat.executeQuery()){
			
			while(rs.next()) {
				int seq=rs.getInt(1);
				String title=rs.getString(2);
				String contents=rs.getString(3);
				int count =rs.getInt(4);
				String member_id=rs.getString(5);
				Timestamp write_date=rs.getTimestamp(6);
				nickname.add(rs.getString(8));
				list.add(new BoardDTO(seq,title,contents,count,member_id,board_code,write_date));			
			}		
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		
		boardList[0]= list;
		boardList[1]= nickname;
		return boardList;
		
	}
	public Object[] selectAll(int recordCountPerPage,int cpage,int board_code){
		String sql="SELECT a.*,m.nickname FROM (SELECT  board.*, ROW_NUMBER() OVER (ORDER BY seq DESC) AS rown FROM board)a join members m on m.id=a.member_id WHERE rown between ? and ? and board_code=?";
		List<BoardDTO> list=new ArrayList<>();
		Object [] boardList=new Object[2];
		ArrayList<String> nickname=new ArrayList<>();
		try (Connection con=DBConfig.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql);){
			
			pstat.setInt(1, cpage*recordCountPerPage - (recordCountPerPage-1));
			pstat.setInt(2, cpage*recordCountPerPage);
			pstat.setInt(3, board_code);
			try(ResultSet rs=pstat.executeQuery()) {
				for (int i = 0; i < recordCountPerPage; i++) {
					rs.next();
					int seq=rs.getInt(1);
					String title=rs.getString(2);
					String contents=rs.getString(3);
					int count =rs.getInt(4);
					String member_id=rs.getString(5);
					Timestamp write_date=rs.getTimestamp(7);
					nickname.add(rs.getString(9));
					BoardDTO dto=new BoardDTO(seq,title,contents,count,member_id,board_code,write_date);
					list.add(dto);
				}
			} catch (Exception e) {
				// TODO: handle exception
			}
			
			
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		boardList[0]= list;
		boardList[1]= nickname;
		
		return boardList;
	}
	
	public Object[] selectType(int recordCountPerPage,int cpage,int board_code,String target,String keyword){
		List<BoardDTO> list=new ArrayList<>();
	
		Object [] boardList=new Object[2];
		ArrayList<String> nickname=new ArrayList<>();
		
		if(target.equals("title")) {
			String sql="	SELECT * FROM (SELECT c.*, ROW_NUMBER() OVER (ORDER BY seq DESC) AS rown FROM (SELECT * FROM (select b.*,m.nickname from board b join members m on b.member_id =m.id where b.title like ?))c)a WHERE rown between ? and ? and a.board_code=?";
			try (Connection con=DBConfig.getConnection();
					PreparedStatement pstat=con.prepareStatement(sql);){
				pstat.setString(1, "%" + keyword + "%");
				pstat.setInt(2, cpage*recordCountPerPage - (recordCountPerPage-1));
				pstat.setInt(3, cpage*recordCountPerPage);
				pstat.setInt(4, board_code);
		
				try(ResultSet rs=pstat.executeQuery()) {
					for (int i = 0; i < recordCountPerPage; i++) {
						rs.next();
						int seq=rs.getInt(1);
						String title=rs.getString(2);
						String contents=rs.getString(3);
						int count =rs.getInt(4);
						String member_id=rs.getString(5);
						Timestamp write_date=rs.getTimestamp(7);
						nickname.add(rs.getString(8));
						BoardDTO dto=new BoardDTO(seq,title,contents,count,member_id,board_code,write_date);
						list.add(dto);
					}
				} catch (Exception e) {}
			} catch (Exception e) {}
		} else if(target.equals("contents")) {
			String sql="SELECT * FROM (SELECT c.*, ROW_NUMBER() OVER (ORDER BY seq DESC) AS rown FROM (SELECT * FROM (select b.*,m.nickname from board b join members m on b.member_id =m.id where b.contents like ?))c)a WHERE rown between ? and ? and a.board_code=?";
			try (Connection con=DBConfig.getConnection();
					PreparedStatement pstat=con.prepareStatement(sql);){
				pstat.setString(1, "%" + keyword + "%");
				pstat.setInt(2, cpage*recordCountPerPage - (recordCountPerPage-1));
				pstat.setInt(3, cpage*recordCountPerPage);
				pstat.setInt(4, board_code);
			
				try(ResultSet rs=pstat.executeQuery()) {
					for (int i = 0; i < recordCountPerPage; i++) {
						rs.next();
						int seq=rs.getInt(1);
						String title=rs.getString(2);
						String contents=rs.getString(3);
						int count =rs.getInt(4);
						String member_id=rs.getString(5);
						Timestamp write_date=rs.getTimestamp(7);
						nickname.add(rs.getString(8));
						BoardDTO dto=new BoardDTO(seq,title,contents,count,member_id,board_code,write_date);
						list.add(dto);
					}
				} catch (Exception e) {}
			} catch (Exception e) {}
			
		} else if(target.equals("nickname")) {
			String sql="SELECT * FROM (SELECT c.*, ROW_NUMBER() OVER (ORDER BY seq DESC) AS rown FROM (SELECT * FROM (select b.*,m.nickname from board b join members m on b.member_id =m.id where m.nickname=?))c)a WHERE rown between ? and ? and a.board_code=?";
			try (Connection con=DBConfig.getConnection();
					PreparedStatement pstat=con.prepareStatement(sql);){
				pstat.setString(1, keyword);
				pstat.setInt(2, cpage*recordCountPerPage - (recordCountPerPage-1));
				pstat.setInt(3, cpage*recordCountPerPage);
				pstat.setInt(4, board_code);
			
				try(ResultSet rs=pstat.executeQuery()) {
					for (int i = 0; i < recordCountPerPage; i++) {
						rs.next();
						int seq=rs.getInt(1);
						String title=rs.getString(2);
						String contents=rs.getString(3);
						int count =rs.getInt(4);
						String member_id=rs.getString(5);
						Timestamp write_date=rs.getTimestamp(7);
						nickname.add(rs.getString(8));
						BoardDTO dto=new BoardDTO(seq,title,contents,count,member_id,board_code,write_date);
						list.add(dto);
					}
				} catch (Exception e) {}
			} catch (Exception e) {}
			
		}
		
		
		boardList[0]= list;
		boardList[1]= nickname;

		return boardList;
	}
	
	
	public Object[] selectBoard(int seq,int board_code){
		BoardDTO dto= new BoardDTO();
		String sql="select b.*, m.nickname from board b join members m on m.id =b.member_id where b.seq=?";
		Object [] boardList=new Object[2];
		String nickname="";
		try (Connection con=DBConfig.getConnection();
				PreparedStatement pstat= con.prepareStatement(sql);){
			pstat.setInt(1, seq);
			try(ResultSet rs=pstat.executeQuery()) {
				rs.next();
					String title=rs.getString(2);
					String contents=rs.getString(3);
					int count =rs.getInt(4);
					String member_id=rs.getString(5);
					Timestamp write_date=rs.getTimestamp(7);
					nickname=rs.getString(8);
					dto=(new BoardDTO(seq,title,contents,count,member_id,board_code,write_date));
			} catch (Exception e) {
				
			}
		} catch (Exception e) {
			
		}
		
		boardList[0]=dto;
		boardList[1]= nickname;
		return boardList;
	}
	
	public void delete(int seq,int board_code) {
		String sql="delete from board where seq=?";
		try (Connection con=DBConfig.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql)){
			pstat.setInt(1, seq);
			pstat.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	
	public void deleteMember(String member_id) {
		String sql="delete from board where member_id=?";
		try (Connection con=DBConfig.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql)){
			pstat.setString(1, member_id);
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	
	public void update(BoardDTO dto) {
		String sql="update board set title=?,contents=? , write_date=sysdate where seq=?";
		
		try (Connection con=DBConfig.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql)){
			pstat.setString(1, dto.getTitle());
			pstat.setString(2, dto.getContents());
			pstat.setInt(3, dto.getSeq());
			pstat.executeUpdate();
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	}
	
	public int getRecordCount(String type,String keyword) {
		int recordTotalCount=0;
		if(type.equals("")) {
			String sql="select count(*) from board";
			try (Connection con=DBConfig.getConnection();
					PreparedStatement pstat=con.prepareStatement(sql);
					ResultSet rs=pstat.executeQuery()){
				rs.next();
				recordTotalCount=rs.getInt(1);	
			} catch (Exception e) {
				// TODO: handle exception
			}
		}
		else if(type.equals("title")) {
			String sql="select count(*) from board where title like ?";
			try (Connection con=DBConfig.getConnection();
					PreparedStatement pstat=con.prepareStatement(sql);){
				pstat.setString(1, "%" + keyword + "%");
				try (ResultSet rs=pstat.executeQuery()){
					rs.next();
					recordTotalCount=rs.getInt(1);	
				} catch (Exception e) {
					// TODO: handle exception
				}
			
				
			} catch (Exception e) {
				// TODO: handle exception
			}
			
		} else if(type.equals("contents")) {
			String sql="select count(*) from board where contents like ?";
			try (Connection con=DBConfig.getConnection();
					PreparedStatement pstat=con.prepareStatement(sql);){
				pstat.setString(1, "%" + keyword + "%");
				try (ResultSet rs=pstat.executeQuery()){
					rs.next();
					recordTotalCount=rs.getInt(1);	
				} catch (Exception e) {
					// TODO: handle exception
				}
			
				
			} catch (Exception e) {
				// TODO: handle exception
			}
			
		} else if(type.equals("nickname")) {
			String sql="select count(*) from board b join members m on b.member_id =m.id where m.nickname=?";
			try (Connection con=DBConfig.getConnection();
					PreparedStatement pstat=con.prepareStatement(sql);){
				pstat.setString(1, keyword);
				try (ResultSet rs=pstat.executeQuery()){
					rs.next();
					recordTotalCount=rs.getInt(1);	
				} catch (Exception e) {
					// TODO: handle exception
				}
			
				
			} catch (Exception e) {
				// TODO: handle exception
			}
			
		}
		
		
		
		return recordTotalCount;
	}
	
	public void countUp(int seq) {
		String sql="update board set count= count+1 where seq=?";
		try (Connection con=DBConfig.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql)){
			pstat.setInt(1, seq);
			pstat.executeUpdate();
			
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
}
