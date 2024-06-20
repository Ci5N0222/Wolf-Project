package controllers;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import board.dao.BoardDAO;
import board.dto.BoardDTO;
import commons.PageConfig;
import files.dao.FilesDAO;
import files.dto.FilesDTO;
import images.dao.ImagesDAO;
import images.dto.ImagesDTO;
import reply.dao.ReplyDAO;
import reply_child.dao.Reply_childDAO;

@WebServlet("*.board")
public class BoardController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		HttpSession session= request.getSession();
		String cmd = request.getRequestURI();
		PrintWriter pw= response.getWriter();
		Gson g= new Gson();
		
		BoardDAO boardDAO= BoardDAO.getInstance();
		FilesDAO filesDAO= FilesDAO.getInstance();
		ReplyDAO replyDAO= ReplyDAO.getInstance();
		Reply_childDAO reply_childDAO= Reply_childDAO.getInstance();
		ImagesDAO imagesDAO = ImagesDAO.getInstance();
		
		
		try {
			if(cmd.equals("/list.board")) {
				String login_id= (String)session.getAttribute("WolfID");
				
				if(request.getSession().getAttribute("WolfAdmin")==null) {
					if(login_id==null) {
						System.out.println("로그인을 해주세요");
						response.sendRedirect("/index.jsp");
					}
				}
				else {
					if(!(boolean)request.getSession().getAttribute("WolfAdmin")) {
						System.out.println("로그인을 해주세요");
						response.sendRedirect("/index.jsp");
					}
				}
				
					
				
				
				
				int board_code=0;
				if(request.getParameter("board_code")==null) board_code=PageConfig.board;
				else board_code=Integer.parseInt(request.getParameter("board_code"));
				
				String target=request.getParameter("target");
				String keyword=request.getParameter("keyword");
				Object boardList[]=new Object[2];
				String pcpage=request.getParameter("cpage");
				if(pcpage==null) pcpage="1";
				int cpage=Integer.parseInt(pcpage);
				
				

		
				if(target==null||keyword.equals("")||target.equals("")) {
					boardList = boardDAO.selectAll( PageConfig.recordCountPerPage, cpage,board_code);
					request.setAttribute("record_total_count", boardDAO.getRecordCount("","",board_code));
					System.out.println("검색안할떄");
				}
				else {
					boardList = boardDAO.selectType( PageConfig.recordCountPerPage, cpage,board_code,target,keyword);
					request.setAttribute("record_total_count", boardDAO.getRecordCount(target,keyword,board_code));
				}
			
				
				request.setAttribute("target",target);
				request.setAttribute("keyword",keyword);
				request.setAttribute("list", boardList[0]);
				request.setAttribute("board_nickname_list", boardList[1]);//boardList[1]
				request.setAttribute("cpage", cpage);
				request.setAttribute("record_count_per_page", PageConfig.recordCountPerPage);
				request.setAttribute("navi_count_per_page", PageConfig.naviCountPerPage);
				request.setAttribute("board_code",board_code);
				
				request.getRequestDispatcher("/views/board/board_view.jsp").forward(request, response);
				
			} else if(cmd.equals("/detail.board")) {
				int seq= Integer.parseInt(request.getParameter("seq"));
				String target=request.getParameter("target");
				String keyword=request.getParameter("keyword");
				int board_code=Integer.parseInt(request.getParameter("board_code"));
				boardDAO.countUp(seq);
				Object boardList[] =boardDAO.selectBoard(seq,PageConfig.board);
				Object replyList[] =replyDAO.select(seq);
				Object reply_childList[]=reply_childDAO.selectAll();
				List<FilesDTO> fileList=filesDAO.select(seq);
				
				System.out.println();
				
				
				request.setAttribute("target",target);
				request.setAttribute("keyword",keyword);
				request.setAttribute("board_code",board_code);
				request.setAttribute("board_dto", boardList[0]);
				request.setAttribute("board_nickname", boardList[1]);
				
				request.setAttribute("reply_list", replyList[0]);
				request.setAttribute("reply_nickname_list", replyList[1]);
			
				request.setAttribute("files_list", fileList);
				
				request.setAttribute("reply_child_list",reply_childList[0] );
				request.setAttribute("reply_child_nickname",reply_childList[1] );
				
				request.getRequestDispatcher("/views/board/board_detail.jsp").forward(request, response);
				
			} else if(cmd.equals("/insert.board")) {
				//session.setAttribute("WolfID", "test1");
				int maxSize = 1024 * 1024 * 10; // 10mb
				String realPath = request.getServletContext().getRealPath("files");
				File uploadPath = new File(realPath);
				if (!uploadPath.exists()) {
					uploadPath.mkdir();// 메이크 디렉토리
				}
				MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "UTF8",
						new DefaultFileRenamePolicy());
				int board_code=Integer.parseInt(multi.getParameter("board_code"));
				if(board_code==2||board_code==4)response.sendRedirect("/index.jsp");
				else {
					String title=multi.getParameter("title");
					String contents=multi.getParameter("contents");
					String member_id= (String)session.getAttribute("WolfID");
					BoardDTO dto=new BoardDTO(0,title,contents,0,member_id,board_code,null);
					int board_seq= boardDAO.insert(dto);
					//dao_files.insert(new FilesDTO(0, oriName, sysName, parent_seq));
					Enumeration<String> names = multi.getFileNames();
			        while(names.hasMoreElements()) {
			               String name = names.nextElement();
			               String oriname = multi.getOriginalFileName(name);
			               String sysname = multi.getFilesystemName(name);
			               System.out.println(name);
			               
			               if(oriname != null) {
			            	   filesDAO.insert(new FilesDTO(0, oriname, sysname, board_seq));
			               }
			        }
			        imagesDAO.updateTemp(board_seq);
			        String new_contents=boardDAO.board_contents(board_seq);
			        System.out.println(new_contents);
			        String[] sysnames=boardDAO.findDeletedTags(new_contents);
			        ArrayList<String> fileList= imagesDAO.delete(board_seq, board_code, sysnames);
			        imagesDAO.deleteImageFile(request.getServletContext().getRealPath("upload_images"), fileList);
			        
					response.sendRedirect("/list.board");
				}
				
				
			} else if(cmd.equals("/delete.board")) {
				int seq=Integer.parseInt(request.getParameter("seq"));
				reply_childDAO.deleteBoard_seq(seq);
				replyDAO.deleteBoard_seq(seq);
				filesDAO.deleteBoard_seq(seq);
				boardDAO.delete(seq,PageConfig.board);
				response.sendRedirect("/list.board");
				
			} else if(cmd.equals("/update.board")) {
				//session.setAttribute("WolfID", "test1");
				
				int maxSize = 1024 * 1024 * 10; // 10mb
				String realPath = request.getServletContext().getRealPath("files");
				File uploadPath = new File(realPath);
				if (!uploadPath.exists()) {
					uploadPath.mkdir();// 메이크 디렉토리
				}
				MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "UTF8",
						new DefaultFileRenamePolicy());
				
				String array=multi.getParameter("array");
				Gson gson=new Gson();
				int[] intArray = gson.fromJson(array, int[].class);
				for (int i : intArray) {
					filesDAO.delete(i);
				}
				int seq=Integer.parseInt(multi.getParameter("seq"));
				String title =multi.getParameter("title");
				String contents=multi.getParameter("contents");
				String member_id= (String)session.getAttribute("WolfID");
				int count =Integer.parseInt(multi.getParameter("count"));
				boardDAO.update(new BoardDTO(seq,title,contents,count,member_id,PageConfig.board,null),PageConfig.board);
				Enumeration<String> names = multi.getFileNames();
		        while(names.hasMoreElements()) {
		               String name = names.nextElement();
		               String oriname = multi.getOriginalFileName(name);
		               String sysname = multi.getFilesystemName(name);
		               System.out.println(name);
		               
		               if(oriname != null) {
		            	   filesDAO.insert(new FilesDTO(0, oriname, sysname, seq));
		               }
		        }
		        String new_contents=boardDAO.board_contents(seq);
		        System.out.println(new_contents);
		        String[] sysnames=boardDAO.findDeletedTags(new_contents);
		        ArrayList<String> fileList= imagesDAO.delete(seq, PageConfig.board, sysnames);
		        imagesDAO.deleteImageFile(request.getServletContext().getRealPath("upload_images"), fileList);
				response.sendRedirect("/detail.board?seq="+seq);
				
			} else if(cmd.equals("/1.board")) {
				
			}
			
		} catch (Exception e) {
		
		}
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
