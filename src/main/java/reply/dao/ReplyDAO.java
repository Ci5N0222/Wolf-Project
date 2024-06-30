package reply.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import commons.DBConfig;
import reply.dto.ReplyDTO;

public class ReplyDAO {
	private static ReplyDAO instance;
	
	public static ReplyDAO  getInstance() {
		if(instance==null) instance=new ReplyDAO();
		return instance;
	}
	
	private ReplyDAO() {}
	
	public void insert(ReplyDTO dto) throws Exception {
		String sql="insert into reply values(reply_seq.nextval,?,?,?,sysdate)";
		try (Connection con=DBConfig.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql)){
			pstat.setString(1, dto.getMember_id());
			pstat.setString(2, dto.getContents());
			pstat.setInt(3, dto.getBoard_seq());
			pstat.executeUpdate();
			
		}
		
	}
	
	public void delete(int seq) throws Exception{
		String sql="delete from reply where seq=?";
		try (Connection con=DBConfig.getConnection();
				PreparedStatement pstat= con.prepareStatement(sql)){
			pstat.setInt(1, seq);
			pstat.executeUpdate();
			
		} 
	}
	
	public void deleteBoard_seq(int board_seq) throws Exception{
		String sql="delete from reply where board_seq=?";
		try (Connection con=DBConfig.getConnection();
				PreparedStatement pstat= con.prepareStatement(sql)){
			pstat.setInt(1, board_seq);
			pstat.executeUpdate();
			
		}
	}
	
	public void update(ReplyDTO dto) throws Exception{
		String sql="update reply set contents=?, write_date=sysdate where seq=?";
		try (Connection con=DBConfig.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql)){
			pstat.setString(1, dto.getContents());
			pstat.setInt(2, dto.getSeq());
			pstat.executeUpdate();
			
		} 
	}
	
	public Object[] select(int board_seq) throws Exception{
		Object [] replyList=new Object[2];
		String sql="select r.*, m.nickname from reply r join members m on r.member_id = m.id where r.board_seq=? order by seq desc";
		List<ReplyDTO> list =new ArrayList<>();
		ArrayList<String> nickname=new ArrayList<>();
		
		try (Connection con=DBConfig.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql)){
			pstat.setInt(1, board_seq);
			try(ResultSet rs=pstat.executeQuery()) {
				while(rs.next()) {
					int seq=rs.getInt(1);
					String member_id=rs.getString(2);
					String contents=rs.getString(3);
					Timestamp write_date =rs.getTimestamp(5);
					 nickname.add(rs.getString(6));
					list.add(new ReplyDTO(seq,member_id,contents,board_seq,write_date));
				}
			} 
		} 
		
		replyList[0]=list;
		replyList[1]=nickname;
		
		
		return replyList;
		
	}
	public String cancel(int seq) throws Exception{
		String sql="select contents from reply where seq=?";
		String contents="";
		try (Connection con=DBConfig.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql)){
			pstat.setInt(1, seq);
			try(ResultSet rs=pstat.executeQuery()) {
				rs.next();
				contents=rs.getString(1);
			} 
			
		} 
		return contents;
	}
}
