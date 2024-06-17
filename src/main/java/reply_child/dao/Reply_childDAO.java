package reply_child.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import commons.DBConfig;
import reply_child_dto.Reply_childDTO;

public class Reply_childDAO {
	
	private static Reply_childDAO instance;
	public static Reply_childDAO  getInstance() {
		if(instance==null) instance=new Reply_childDAO();
		return instance;
	}
	
	private Reply_childDAO() {}
	
	public Object[] insert(Reply_childDTO dto) {
		String sql="insert into reply_child values(reply_child_seq.nextval,?,?,?,sysdate)";
		Object[] result=new Object[2];
		try (Connection con=DBConfig.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql,new String[] {"seq","write_date"})){
			pstat.setString(1, dto.getMember_id());
			pstat.setString(2, dto.getContents());
			pstat.setInt(3, dto.getReply_seq());
			pstat.executeUpdate();
			
			try (ResultSet rs=pstat.getGeneratedKeys()){
				rs.next();
				result[0]=rs.getInt(1);
				result[1]=rs.getTimestamp(2);
				
			} catch (Exception e) {
				// TODO: handle exception
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return result;
	}
	
	public Object[] selectReply(int reply_seq) {
		String sql="select c.*, m.nickname from reply_child c join members m on c.member_id=m.id where reply_seq =? order by seq desc";
		Object[] result=new Object[2];
		List<Reply_childDTO> list =new ArrayList<>();
		ArrayList<String> nickname= new ArrayList<>();
		try (Connection con=DBConfig.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql)){
			
			pstat.setInt(1, reply_seq);

			
			try (ResultSet rs=pstat.executeQuery()){
				while(rs.next()) {
					int seq=rs.getInt(1);
					String member_id=rs.getString(2);
					String contents=rs.getString(3);
					Timestamp write_date=rs.getTimestamp(5);
					nickname.add(rs.getString(6));
					list.add(new Reply_childDTO(seq,member_id,contents,reply_seq,write_date));
				}
				
				
				
			} catch (Exception e) {
				// TODO: handle exception
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		result[0]=list;
		result[1]=nickname;
		
		return result;
	}
	
	public Object[] selectAll() {
		String sql="select c.*, m.nickname from reply_child c join members m on c.member_id=m.id order by seq desc";
		Object[] result=new Object[2];
		List<Reply_childDTO> list =new ArrayList<>();
		ArrayList<String> nickname= new ArrayList<>();
		try (Connection con=DBConfig.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql)){	
			try (ResultSet rs=pstat.executeQuery()){
				while(rs.next()) {
					int seq=rs.getInt(1);
					String member_id=rs.getString(2);
					String contents=rs.getString(3);
					int reply_seq=rs.getInt(4);
					Timestamp write_date=rs.getTimestamp(5);
					nickname.add(rs.getString(6));
					list.add(new Reply_childDTO(seq,member_id,contents,reply_seq,write_date));
				}
				
				
				
			} catch (Exception e) {
				// TODO: handle exception
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		result[0]=list;
		result[1]=nickname;
		
		return result;
	}
	
	public void delete(int seq) {
		String sql="delete from reply_child where seq=?";
		try (Connection con=DBConfig.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql)){
			pstat.setInt(1, seq);
			pstat.executeUpdate();
			
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	public void deleteBoard_seq(int Board_seq) {
		String sql="delete from (select r_c.*,r.board_seq from reply_child r_c join reply r on r_c.reply_seq=r.seq) where board_seq=?";
		try (Connection con=DBConfig.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql)){
			pstat.setInt(1, Board_seq);
			pstat.executeUpdate();
			
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	
	public String cancel(int seq) {
		String sql="select contents from reply_child where seq=?";
		String contents="";
		try (Connection con=DBConfig.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql)){
			pstat.setInt(1, seq);
			try(ResultSet rs=pstat.executeQuery()) {
				rs.next();
				contents=rs.getString(1);
			} catch (Exception e) {
				// TODO: handle exception
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return contents;
	}
	
	public boolean update(int seq,String contents) {
		String sql="update reply_child set contents=? , write_date= sysdate  where seq=?";
		
		try (Connection con=DBConfig.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql)){
			pstat.setString(1, contents);
			pstat.setInt(2, seq);
			if(pstat.executeUpdate()>0)return true;
			
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return false;
	}
	

}
