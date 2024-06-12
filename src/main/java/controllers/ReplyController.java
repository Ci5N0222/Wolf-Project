package controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.dao.BoardDAO;
import files.dao.FilesDAO;
import reply.dao.ReplyDAO;
import reply.dto.ReplyDTO;

/**
 * Servlet implementation class ReplyController
 */
@WebServlet("*.reply")
public class ReplyController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session= request.getSession();
		String cmd = request.getRequestURI();
		
		BoardDAO boardDAO= BoardDAO.getInstance();
		FilesDAO filesDAO= FilesDAO.getInstance();
		ReplyDAO replyDAO= ReplyDAO.getInstance();
		List<ReplyDTO> list = new ArrayList<>();
		
		if(cmd.equals("/insert.reply")) {
			String contents=request.getParameter("contents");
			String member_id=request.getParameter("member_id");
			int board_seq=Integer.parseInt( request.getParameter("board_seq"));
			replyDAO.insert(new ReplyDTO(0,member_id,contents,board_seq,null));
			response.sendRedirect("/detail.board?seq="+board_seq);
			
		} else if(cmd.equals("/delete.reply")) {
			int seq=Integer.parseInt(request.getParameter("seq"));
			int board_seq=Integer.parseInt(request.getParameter("board_seq"));	
			replyDAO.delete(seq);
			
			
		} else if(cmd.equals("/update.reply")) {
			int seq=Integer.parseInt(request.getParameter("seq"));
			int board_seq=Integer.parseInt(request.getParameter("board_seq"));
			String contents =request.getParameter("contents");
			replyDAO.update(new ReplyDTO(seq,null,contents,0,null));

			
		} else if(cmd.equals("/3.reply")) {
			
		} else if(cmd.equals("/4.reply")) {
			
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
