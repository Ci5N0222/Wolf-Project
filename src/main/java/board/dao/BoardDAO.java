package board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Iterator;
import org.jsoup.Jsoup;
import java.util.List;


import java.util.regex.Pattern;
import java.util.regex.Matcher;


import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import board.dto.BoardDTO;
import commons.DBConfig;

public class BoardDAO {
private static BoardDAO instance;
	
	public static BoardDAO  getInstance() {
		if(instance==null) instance=new BoardDAO();
		return instance;
	}
	
	private BoardDAO() {}
	
	public int insert(BoardDTO dto) throws Exception{
		String sql="insert into board values(board_seq.nextval,?,?,0,?,?,sysdate,?)";
		int seq=0;
		try (Connection con=DBConfig.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql,new String[] {"seq"})){
			pstat.setString(1, dto.getTitle());
			pstat.setString(2, dto.getContents());
			pstat.setString(3, dto.getMember_id());
			pstat.setInt(4, dto.getBoard_code());
			pstat.setString(5, dto.getSecret());
			
			pstat.executeUpdate();
			try (ResultSet rs=pstat.getGeneratedKeys()){
				rs.next();
				seq=rs.getInt(1);
			}
		} 
		return seq;
	}
	
	
	public Object[] selectAll (int recordCountPerPage,int cpage,int board_code)throws Exception{
		String sql="SELECT a.*,m.nickname FROM (SELECT  board.*, ROW_NUMBER() OVER (ORDER BY seq DESC) AS rown FROM board where board_code=?)a join members m on m.id=a.member_id WHERE rown between ? and ?";
		List<BoardDTO> list=new ArrayList<>();
		Object [] boardList=new Object[2];
		ArrayList<String> nickname=new ArrayList<>();
		try (Connection con=DBConfig.getConnection(); 
				PreparedStatement pstat=con.prepareStatement(sql);){
			pstat.setInt(1, board_code);
			pstat.setInt(2, cpage*recordCountPerPage - (recordCountPerPage-1));
			pstat.setInt(3, cpage*recordCountPerPage);
		
			try(ResultSet rs=pstat.executeQuery()) {
				while(rs.next()) {		
					int seq=rs.getInt(1);
					String title=rs.getString(2);
					String contents=rs.getString(3);
					int count =rs.getInt(4);
					String member_id=rs.getString(5);
					Timestamp write_date=rs.getTimestamp(7);
					String secret=rs.getString(8);
					nickname.add(rs.getString(10));
					BoardDTO dto=new BoardDTO(seq,title,contents,count,member_id,board_code,write_date,secret);
					list.add(dto);
				}
				boardList[0]= list;
				boardList[1]= nickname;
				
				return boardList;
			} 
			
			
			
		} 
		
		
	}
	
	public Object[] selectType(int recordCountPerPage,int cpage,int board_code,String target,String keyword) throws Exception{
		List<BoardDTO> list=new ArrayList<>();
	
		Object [] boardList=new Object[2];
		ArrayList<String> nickname=new ArrayList<>();
		
		if(target.equals("title")) {
			String sql="	SELECT * FROM (SELECT c.*, ROW_NUMBER() OVER (ORDER BY seq DESC) AS rown FROM (SELECT * FROM (select b.*,m.nickname from board b join members m on b.member_id =m.id where REGEXP_REPLACE(b.title, '<[^>]+>', '') like ?))c where board_code=?)a WHERE rown between ? and ?";
			try (Connection con=DBConfig.getConnection();
					PreparedStatement pstat=con.prepareStatement(sql);){
				pstat.setString(1, "%" + keyword + "%");
				pstat.setInt(2, board_code);
				pstat.setInt(3, cpage*recordCountPerPage - (recordCountPerPage-1));
				pstat.setInt(4, cpage*recordCountPerPage);
				
				
				try(ResultSet rs=pstat.executeQuery()) {
					while(rs.next()) {
						int seq=rs.getInt(1);
						String title=rs.getString(2);
						String contents=rs.getString(3);
						int count =rs.getInt(4);
						String member_id=rs.getString(5);
						Timestamp write_date=rs.getTimestamp(7);
						String secret=rs.getString(8);
						nickname.add(rs.getString(9));		
						BoardDTO dto=new BoardDTO(seq,title,contents,count,member_id,board_code,write_date,secret);
						list.add(dto);
						
					}
				} 
			}
		} else if(target.equals("contents")) {
			String sql="SELECT * FROM (SELECT c.*, ROW_NUMBER() OVER (ORDER BY seq DESC) AS rown FROM (SELECT * FROM (select b.*,m.nickname from board b join members m on b.member_id =m.id where REGEXP_REPLACE(b.contents, '<[^>]+>', '') like ?))c where board_code=? )a WHERE rown between ? and ? ";
			try (Connection con=DBConfig.getConnection();
					PreparedStatement pstat=con.prepareStatement(sql);){
				pstat.setString(1, "%" + keyword + "%");
				pstat.setInt(2, board_code);
				pstat.setInt(3, cpage*recordCountPerPage - (recordCountPerPage-1));
				pstat.setInt(4, cpage*recordCountPerPage);
				
			
				try(ResultSet rs=pstat.executeQuery()) {
					while(rs.next()) {
						int seq=rs.getInt(1);
						String title=rs.getString(2);
						String contents=rs.getString(3);
						int count =rs.getInt(4);
						String member_id=rs.getString(5);
						Timestamp write_date=rs.getTimestamp(7);
						String secret=rs.getString(8);
						nickname.add(rs.getString(9));
				
						BoardDTO dto=new BoardDTO(seq,title,contents,count,member_id,board_code,write_date,secret);
						list.add(dto);
					}
					
				} 
			} 
			
		} else if(target.equals("nickname")) {
			String sql="SELECT * FROM (SELECT c.*, ROW_NUMBER() OVER (ORDER BY seq DESC) AS rown FROM (SELECT * FROM (select b.*,m.nickname from board b join members m on b.member_id =m.id where m.nickname=?))c where board_code=?)a WHERE rown between ? and ?";
			try (Connection con=DBConfig.getConnection();
					PreparedStatement pstat=con.prepareStatement(sql);){
				pstat.setString(1, keyword);
				pstat.setInt(2, board_code);
				pstat.setInt(3, cpage*recordCountPerPage - (recordCountPerPage-1));
				pstat.setInt(4, cpage*recordCountPerPage);
				
			
				try(ResultSet rs=pstat.executeQuery()) {
					while (rs.next()) {
						int seq=rs.getInt(1);
						String title=rs.getString(2);
						String contents=rs.getString(3);
						int count =rs.getInt(4);
						String member_id=rs.getString(5);
						Timestamp write_date=rs.getTimestamp(7);
						String secret=rs.getString(8);
						nickname.add(rs.getString(9));
						BoardDTO dto=new BoardDTO(seq,title,contents,count,member_id,board_code,write_date,secret);
						list.add(dto);
					}
				} 
			} 
			
		}
		
		
		boardList[0]= list;
		boardList[1]= nickname;

		return boardList;
	}
	
	
	public Object[] selectBoard (int seq) throws Exception{
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
					int board_code=rs.getInt(6);
					Timestamp write_date=rs.getTimestamp(7);
					String secret=rs.getString(8);
					nickname=rs.getString(9);
					dto=(new BoardDTO(seq,title,contents,count,member_id,board_code,write_date,secret));
			} 
		} 
		
		boardList[0]=dto;
		boardList[1]= nickname;
		return boardList;
	}
	
	public void delete(int seq,int board_code)throws Exception {
		String sql="delete from board where seq=?";
		try (Connection con=DBConfig.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql)){
			pstat.setInt(1, seq);
			pstat.executeUpdate();
		} 
	}
	
	public void deleteMember(String member_id) throws Exception{
		String sql="delete from board where member_id=?";
		try (Connection con=DBConfig.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql)){
			pstat.setString(1, member_id);
		}
	}
	
	public boolean update(BoardDTO dto)throws Exception {
		String sql="update board set title=?,contents=? , secret=? ,write_date=sysdate where seq=? and board_code=?";
		boolean check=false;
		try (Connection con=DBConfig.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql)){
			pstat.setString(1, dto.getTitle());
			pstat.setString(2, dto.getContents());
			pstat.setString(3, dto.getSecret());
			pstat.setInt(4, dto.getSeq());
			pstat.setInt(5, dto.getBoard_code());		
			if(pstat.executeUpdate()>0)check=true;;		
			
		}
		
		return check;
	}
	
	public int getRecordCount(String type,String keyword,int board_code) throws Exception{
		int recordTotalCount=0;
		if(type.equals("")) {
			String sql="select count(*) from board where board_code=?";
			try (Connection con=DBConfig.getConnection();
					PreparedStatement pstat=con.prepareStatement(sql);){
				pstat.setInt(1, board_code);
				try (ResultSet rs=pstat.executeQuery()){
					rs.next();
					recordTotalCount=rs.getInt(1);	
				} 
				
			}
		}
		else if(type.equals("title")) {
			String sql="select count(*) from board where REGEXP_REPLACE(title, '<[^>]+>', '') like ? and board_code=?";
			try (Connection con=DBConfig.getConnection();
					PreparedStatement pstat=con.prepareStatement(sql);){
				pstat.setString(1, "%" + keyword + "%");
				pstat.setInt(2, board_code);
				try (ResultSet rs=pstat.executeQuery()){
					rs.next();
					recordTotalCount=rs.getInt(1);	
				} 
			
				
			}
			
		} else if(type.equals("contents")) {
			String sql="select count(*) from board where REGEXP_REPLACE(contents, '<[^>]+>', '') like ? and board_code=?";
			try (Connection con=DBConfig.getConnection();
					PreparedStatement pstat=con.prepareStatement(sql);){
				pstat.setString(1, "%" + keyword + "%");
				pstat.setInt(2, board_code);
				try (ResultSet rs=pstat.executeQuery()){
					rs.next();
					recordTotalCount=rs.getInt(1);	
				} 
			
				
			} 
			
		} else if(type.equals("nickname")) {
			String sql="select count(*) from board b join members m on b.member_id =m.id where m.nickname=? and board_code=?";
			try (Connection con=DBConfig.getConnection();
					PreparedStatement pstat=con.prepareStatement(sql);){
				pstat.setString(1, keyword);
				pstat.setInt(2, board_code);
				try (ResultSet rs=pstat.executeQuery()){
					rs.next();
					recordTotalCount=rs.getInt(1);	
					
				}
				
			} 
			
		}
		
		
		
		return recordTotalCount;
	}
	
	public void countUp(int seq) throws Exception{
		String sql="update board set count= count+1 where seq=?";
		try (Connection con=DBConfig.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql)){
			pstat.setInt(1, seq);
			pstat.executeUpdate();
			
		} 
	}
	
	public  String[] findDeletedTags(String originalHtml)throws Exception {
		Document doc = Jsoup.parse(originalHtml);
	    Elements imgTags = doc.select("img");
	    ArrayList<String> sysnames=new ArrayList<>();

	    // img 태그들에 대해 처리합니다.
	    for (Element imgTag : imgTags) {
	        String src = imgTag.attr("src");
	        //System.out.println(src);
	        String regex = "upload_images/(.+)"; // 여기에 적절한 정규 표현식을 넣어야 합니다.
	        Pattern pattern = Pattern.compile(regex);
	        Matcher matcher = pattern.matcher(src);
	        
	        if (matcher.find()) {
	            String matchedString = matcher.group(1);
	            //System.out.println("매칭된 문자열: " + matchedString);
	            sysnames.add(matchedString);
	        }
	    }
	    if(sysnames.size()==0) {
	    	sysnames.add("0");
	    }
	    String[] result=new String[sysnames.size()];
	    int i=0;
	    for (String string : sysnames) {
			result[i++]=string;
		}

	    return result;
	}
	
	
	public String board_contents(int seq) throws Exception{
		String sql="select contents from board where seq=?";
		String contents="";
		try (Connection con=DBConfig.getConnection();
				PreparedStatement pstat=con.prepareStatement(sql)){
			pstat.setInt(1, seq);
			try (ResultSet rs=pstat.executeQuery()){
				rs.next(); 
				contents=rs.getString(1);
				
			} 
			
		} 
		return contents;
	}
	
	
	
	
	public void dumidata() throws Exception{
		String sql="insert into board values(board_seq.nextval,?,?,0,?,?,sysdate,?)";
		for (int i = 0; i < 150; i++) {
			try (Connection con=DBConfig.getConnection();
					PreparedStatement pstat=con.prepareStatement(sql)){
				pstat.setString(1, "test"+i);
				pstat.setString(2, "test"+i);
				pstat.setString(3, "haram0704");
				pstat.setInt(4, 1);
				pstat.setString(5, "N");
				pstat.executeUpdate();	
				
			} 
		}	
	}
	
}
