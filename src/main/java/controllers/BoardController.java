package controllers;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import board.dao.BoardDAO;
import board.dto.BoardDTO;
import commons.BoardConfig;
import files.dao.FilesDAO;
import files.dto.FilesDTO;
import reply.dao.ReplyDAO;

@WebServlet("*.board")
public class BoardController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session= request.getSession();
		String cmd = request.getRequestURI();
		
		BoardDAO boardDAO= BoardDAO.getInstance();
		FilesDAO filesDAO= FilesDAO.getInstance();
		ReplyDAO replyDAO= ReplyDAO.getInstance();
		List<BoardDTO> list = new ArrayList<>();
		
		try {
			if(cmd.equals("/list.board")) {
				String pcpage=request.getParameter("cpage");
				if(pcpage==null) pcpage="1";
				int cpage=Integer.parseInt(pcpage);
				Object boardList[] = boardDAO.select( BoardConfig.recordCountPerPage, cpage);
				
				request.setAttribute("list", boardList[0]);
				request.setAttribute("nickname", boardList[1]);//boardList[1]
				request.setAttribute("cpage", cpage);
				request.setAttribute("record_count_per_page", BoardConfig.recordCountPerPage);
				request.setAttribute("navi_count_per_page", BoardConfig.naviCountPerPage);
				request.setAttribute("record_total_count", boardDAO.getRecordCount());
				
				request.getRequestDispatcher("/views/board/board_view.jsp").forward(request, response);
				
			} else if(cmd.equals("/detail.board")) {
				int seq= Integer.parseInt(request.getParameter("seq"));
				Object boardList[] =boardDAO.selectBoard(seq);
				Object replyList[] =replyDAO.select(seq);
				List<FilesDTO> fileList=filesDAO.select(seq);
				
				
				request.setAttribute("board_dto", boardList[0]);
				request.setAttribute("board_nickname", boardList[1]);
				
				request.setAttribute("reply_list", replyList[0]);
				request.setAttribute("reply_nickname", replyList[1]);
			
				request.setAttribute("files_list", fileList);
				
				request.getRequestDispatcher("/views/board/board_detail.jsp").forward(request, response);
				
			} else if(cmd.equals("/insert.board")) {
				session.setAttribute("WolfID", "test1");
				int maxSize = 1024 * 1024 * 10; // 10mb
				String realPath = request.getServletContext().getRealPath("files");
				File uploadPath = new File(realPath);
				if (!uploadPath.exists()) {
					uploadPath.mkdir();// 메이크 디렉토리
				}
				MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "UTF8",
						new DefaultFileRenamePolicy());
				String oriName = multi.getOriginalFileName("file");// 원본이름
				String sysName = multi.getFilesystemName("file");// 서버에 저장되었을떄 이름
				String title=multi.getParameter("title");
				String contents=multi.getParameter("contents");
				String member_id= (String)session.getAttribute("WolfID");
				BoardDTO dto=new BoardDTO(0,title,contents,0,member_id,null);
				int board_seq= boardDAO.insert(dto);
				//dao_files.insert(new FilesDTO(0, oriName, sysName, parent_seq));
				filesDAO.insert(new FilesDTO(0, oriName, sysName, board_seq));
				
				response.sendRedirect("/list.board");
				
			} else if(cmd.equals("/delete.board")) {
				
			} else if(cmd.equals("/1.board")) {
				
			} else if(cmd.equals("/2.board")) {
				
			}
			
		} catch (Exception e) {
		
		}
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
