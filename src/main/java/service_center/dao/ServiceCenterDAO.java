package service_center.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import commons.DBConfig;
import service_center.dto.ServiceCenterDTO;

public class ServiceCenterDAO {

	private ServiceCenterDAO() {}
	
	private static ServiceCenterDAO instance;
	
	public static ServiceCenterDAO  getInstance() {
		if(instance == null) instance = new ServiceCenterDAO();
		return instance;
	}
	
	
	/**
	 * 문의 게시판에 글 작성시 QNA 테이블에 데이터를 추가하는 메서드
	 * @param boardSeq
	 * @return
	 * @throws Exception
	 */
	public int qnaResInsert(int boardSeq) throws Exception {
		String sql = "insert into qna values(qna_seq.nextval, ?, 'N')";
		
		try(Connection con = DBConfig.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql)){
			pstat.setInt(1, boardSeq);
			
			return pstat.executeUpdate();
		}
	}
	
	
	/**
	 * 문의 게시판 답변 작성시 QNA RES가 'Y'(답변 완료)로 변경되는 메서드
	 * @param boardSeq
	 * @return
	 * @throws Exception
	 */
	public int qnaResUpdate(int boardSeq) throws Exception {
		String sql = "update qna set res_ok = 'Y' where board_seq = ?";
		
		try(Connection con = DBConfig.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql)){
			pstat.setInt(1, boardSeq);
			
			return pstat.executeUpdate();
		}
	}
	
	
	/**
	 * 해당 회원의 문의 내역 개수를 반환하는 메서드
	 * @param id
	 * @param res (문의 OK 여부 [0: 전체, Y: 답변완료, N:대기중])
	 * @return
	 * @throws Exception
	 */
	public int getQnaTotalCount(String id, String res) throws Exception {
		String sql = "";
		if(res.equals("0")) {
			sql = "select count(*) from board where board_code = 3 and member_id = ?";
		} else {
			sql = "select count(*) from board b join qna q on b.seq = q.board_seq where board_code = 3 and member_id = ? and res_ok = ?";
		}
		
		try(Connection con = DBConfig.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql)){
			pstat.setString(1, id);
			if(!res.equals("0")) pstat.setString(2, res);
			
			try(ResultSet rs = pstat.executeQuery()){
				rs.next();
				
				return rs.getInt(1);
			}
		}
	}
	
	
	/**
	 * 해당 회원의 문의 내역을 반환하는 메서드
	 * @param res (문의 OK 여부 [0: 전체, Y: 답변완료, N:대기중])
	 * @param id
	 * @param start
	 * @param end
	 * @return
	 * @throws Exception
	 */
	public List<ServiceCenterDTO> getMyQnaList(String id, String res, int start, int end) throws Exception {
		String sql = "";
		if(res.equals("0")) {
			sql = "SELECT b.*, q.res_ok, m.nickname FROM (select board.*, row_number() over(order by seq desc) rown FROM board WHERE board_code = 3 AND member_id = ?) b LEFT JOIN qna q  ON b.seq = q.board_seq JOIN members m ON m.id = b.member_id WHERE rown BETWEEN ? AND ?";
		} else {
			sql = "SELECT b.*, q.res_ok, m.nickname FROM (select board.*, row_number() over(order by seq desc) rown FROM board WHERE board_code = 3 AND member_id = ?) b LEFT JOIN qna q  ON b.seq = q.board_seq JOIN members m ON m.id = b.member_id WHERE (q.res_ok = ? OR q.res_ok IS NULL) AND rown BETWEEN ? AND ?";
		}
		
		try(Connection con = DBConfig.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql)){
			if(res.equals("0")) {
				pstat.setString(1, id);
				pstat.setInt(2, start);
				pstat.setInt(3, end);
			} else {
				pstat.setString(1, id);
				pstat.setString(2, res);
				pstat.setInt(3, start);
				pstat.setInt(4, end);
			}
			
			try(ResultSet rs = pstat.executeQuery()){
				List<ServiceCenterDTO> list = new ArrayList<>();
				
				while(rs.next()) {
					int seq = rs.getInt("seq");
					String title = rs.getString("title");
					String contents = rs.getString("contents");
					int count = rs.getInt("count");
					String memberId = rs.getString("member_id");
					int boardCode = rs.getInt("board_code");
					Timestamp writeDate = rs.getTimestamp("write_date");
					String secret = rs.getString("secret");
					String resOk = rs.getString("res_ok");
					String nickName = rs.getString("nickname");
					
					list.add(new ServiceCenterDTO(seq, title, contents, count, memberId, boardCode, writeDate, secret, resOk, nickName));
				}
				
				return list;
			}
		}
	}
	
	
	/**
	 * 문의 사항의 디테일을 반환하는메서드
	 * @param code
	 * @param idx
	 * @return
	 * @throws Exception
	 */
	public ServiceCenterDTO getMyQnaDetail(int code, int idx) throws Exception {
		String sql = "SELECT b.*, q.res_ok, m.nickname FROM board b JOIN qna q  ON b.seq = q.board_seq JOIN members m ON m.id = b.member_id WHERE board_code = ? AND b.seq = ?";
		
		try(Connection con = DBConfig.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql)){
			pstat.setInt(1, code);
			pstat.setInt(2, idx);
				
			try(ResultSet rs = pstat.executeQuery()){
				if(rs.next()) {
					int seq = rs.getInt("seq");
					String title = rs.getString("title");
					String contents = rs.getString("contents");
					int count = rs.getInt("count");
					String memberId = rs.getString("member_id");
					int boardCode = rs.getInt("board_code");
					Timestamp writeDate = rs.getTimestamp("write_date");
					String secret = rs.getString("secret");
					String resOk = rs.getString("res_ok");
					String nickName = rs.getString("nickname");
					
					return new ServiceCenterDTO(seq, title, contents, count, memberId, boardCode, writeDate, secret, resOk, nickName);
				} else {
					
					return null;
				}
			}
		}
	}
	
	
	/**
	 * 문의 글을 삭제하는 메서드
	 * @param code
	 * @param idx
	 * @return
	 * @throws Exception
	 */
	public int qnaDelete(int code, int idx) throws Exception {
		String sql = "delete from board where board_code = ? and seq = ?";
		
		try(Connection con = DBConfig.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql)){
			pstat.setInt(1, code);
			pstat.setInt(2, idx);
			
			return pstat.executeUpdate();
		}
	}
	
	
	/**
	 * FAQ 목록의 개수를 반환하는 메서드
	 * @return
	 * @throws Exception
	 */
	public int getFaqTotalCount() throws Exception {
		String sql ="select count(*) from board where board_code = 4";

		try(Connection con = DBConfig.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql)){

			try(ResultSet rs = pstat.executeQuery()){
				rs.next();

				return rs.getInt(1);
			}
		}
	}


	/**
	 * FAQ 목록을 반환하는 메서드
	 * @param start
	 * @param end
	 * @return
	 * @throws Exception
	 */
	public List<ServiceCenterDTO> getFaqList(int start, int end) throws Exception {
		String sql = "SELECT a.*,m.nickname FROM (SELECT  board.*, ROW_NUMBER() OVER (ORDER BY seq DESC) AS rown FROM board where board_code=4)a join members m on m.id=a.member_id WHERE rown between ? and ?";

		try(Connection con = DBConfig.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql)){
			pstat.setInt(1, start);
			pstat.setInt(2, end);

			try(ResultSet rs = pstat.executeQuery()){
				List<ServiceCenterDTO> list = new ArrayList<>();

				while(rs.next()) {
					int seq = rs.getInt("seq");
					String title = rs.getString("title");
					String contents = rs.getString("contents");
					int count = rs.getInt("count");
					String memberId = rs.getString("member_id");
					int boardCode = rs.getInt("board_code");
					Timestamp writeDate = rs.getTimestamp("write_date");
					String nickName = rs.getString("nickname");

					list.add(new ServiceCenterDTO(seq, title, contents, count, memberId, boardCode, writeDate, null, null, nickName));
				}
				return list;
			}
		}
	}
	
	

}

