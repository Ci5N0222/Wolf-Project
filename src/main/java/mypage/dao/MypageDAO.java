package mypage.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import admin.dto.AdminDTO;
import commons.DBConfig;
import mypage.dto.MypageDTO;

public class MypageDAO {
	public static MypageDAO instance;

	public synchronized static MypageDAO getinstance() {
		if (instance == null) {
			instance = new MypageDAO();
		}
		return instance;
	}

	private MypageDAO() {
	}
	
	/**
	 * 사용자의 아바타 이미지 이름
	 * @param id
	 * @return
	 */
	public String avatar(String id) {
		String sql="select avatar from members where id=?";
		String avatar="";
		
		try (Connection con =DBConfig.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql)){
			
			pstat.setString(1, id);
		
			try (ResultSet rs =pstat.executeQuery()){
				rs.next();
				avatar=rs.getString(1);
				
			} catch (Exception e) {
				// TODO: handle exception
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return avatar;
	}
	
	public void updateAvatar(String id) {
		String sql="update members set avatar=null where id=?";
		
		try (Connection con =DBConfig.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql)){
			
			pstat.setString(1, id);
		
			
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	
	
	/**
	 * 내 게시글의 개수를 반환하는 메서드
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public int myBoardTotalCount(String id) throws Exception {
		String sql = "select count(*) from board where board_code = 1 and member_id = ?";
				
		try(Connection con = DBConfig.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql)){
			pstat.setString(1, id);
			try(ResultSet rs = pstat.executeQuery()){
				rs.next();
				
				return rs.getInt(1);
			}
		}
	}
	
	
	/**
	 * 내 게시글을 반환하는 메서드
	 * @param id
	 * @param start
	 * @param end
	 * @return
	 * @throws Exception
	 */
	public List<MypageDTO.BoardListDTO> myBoardList(String id, int start, int end) throws Exception {
		String sql = "select a.*,m.nickname nickname from (select board.*, row_number() over(order by seq desc) rown from board where board_code = 1 AND member_id = ?) a join members m on m.id=a.member_id where rown between ? and ?";
		
		
		try(Connection con = DBConfig.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql)){
			pstat.setString(1, id);
			pstat.setInt(2, start);
			pstat.setInt(3, end);
			
			try(ResultSet rs = pstat.executeQuery()){
				List<MypageDTO.BoardListDTO> list = new ArrayList<>();
				
				while(rs.next()) {
					int seq = rs.getInt("seq");
					String title = rs.getString("title");
					String contents = rs.getString("contents");
					int count = rs.getInt("count");
					String memberId = rs.getString("member_id");
					String nickName = rs.getString("nickname");
					int boardCode = rs.getInt("board_code");
					Timestamp writeDate = rs.getTimestamp("write_date");
					
					list.add(new MypageDTO.BoardListDTO(seq, title, contents, count, memberId, nickName, boardCode, writeDate));
				}
				
				return list;
			}
		}
	}
	

}
