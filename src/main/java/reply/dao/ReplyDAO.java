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

import reply.dto.ReplyDTO;

public class ReplyDAO {
	private static ReplyDAO instance;
	
	public static ReplyDAO  getInstance() {
		if(instance==null) instance=new ReplyDAO();
		return instance;
	}
	
	private ReplyDAO() {}
	
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		DataSource db = (DataSource) ctx.lookup("java:comp/env/jdbc/oracle");
		return db.getConnection();
	}
	
	public void insert(ReplyDTO dto) {
		String sql="insert into reply values(reply_seq.nextval,?,?,?,sysdate)";
		try (Connection con=this.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql)){
			pstat.setString(1, dto.getMember_id());
			pstat.setString(2, dto.getContents());
			pstat.setInt(3, dto.getBoard_seq());
			pstat.executeUpdate();
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	}
	
	public Object[] select(int board_seq) {
		Object [] replyList=new Object[2];
		String sql="select r.*, m.nickname from reply r join members m on r.member_id = m.id where r.board_seq=?";
		List<ReplyDTO> list =new ArrayList();
		String nickname="";
		try (Connection con=this.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql)){
			pstat.setInt(1, board_seq);
			try(ResultSet rs=pstat.executeQuery()) {
				while(rs.next()) {
					int seq=rs.getInt(1);
					String member_id=rs.getString(2);
					String contents=rs.getString(3);
					Timestamp write_date =rs.getTimestamp(5);
					 nickname=rs.getString(6);
					list.add(new ReplyDTO(seq,member_id,contents,board_seq,write_date));
				}
			} catch (Exception e) {
				// TODO: handle exception
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		replyList[0]=list;
		replyList[1]=nickname;
		
		
		return replyList;
		
	}
}
