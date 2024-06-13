package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import reply_child.dao.Reply_childDAO;
import reply_child_dto.Reply_childDTO;

/**
 * Servlet implementation class Reply_childController
 */
@WebServlet("*.reply_child")
public class Reply_childController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session= request.getSession();
		String cmd = request.getRequestURI();
		PrintWriter pw= response.getWriter();
		Gson g= new Gson();
		//BoardDAO boardDAO= BoardDAO.getInstance();
		//FilesDAO filesDAO= FilesDAO.getInstance();
		//ReplyDAO replyDAO= ReplyDAO.getInstance();
		Reply_childDAO reply_childDAO= Reply_childDAO.getInstance();
		//List<BoardDTO> list = new ArrayList<>();
		
	       // 현재 시간을 가져옵니다.
    

		
		try {
			if(cmd.equals("/insert.reply_child")) {
				String contents=request.getParameter("contents");
				int reply_seq=Integer.parseInt(request.getParameter("reply_seq"));
				
				String member_id=(String)session.getAttribute("WolfID");
				Object[] reply_child_dto=reply_childDAO.insert(new Reply_childDTO(0,member_id,contents,reply_seq,null));
			        
			     // 현재 시간을 가져옵니다.
			        Timestamp timestamp = (Timestamp)reply_child_dto[1];
			        
			        // Timestamp를 LocalDateTime으로 변환합니다.
			        LocalDateTime localDateTime = timestamp.toLocalDateTime();
			        
			        // DateTimeFormatter 객체를 생성하고 원하는 포맷을 지정합니다.
			        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd HH:mm");
			        
			        // LocalDateTime 객체를 포맷에 맞게 문자열로 변환합니다.
			    String formattedDateTime = localDateTime.format(formatter);
				reply_child_dto[1]=formattedDateTime;
				String result=g.toJson(reply_child_dto);
				System.out.println(result);
				pw.append(result);
			}
			else if(cmd.equals("/delete.reply_child")) {
				int seq=Integer.parseInt(request.getParameter("seq"));
				reply_childDAO.delete(seq);
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

}
