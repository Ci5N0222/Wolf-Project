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
		request.setCharacterEncoding("utf-8");
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
	
				if(login_id==null) {
					System.out.println("로그인을 해주세요");
					response.sendRedirect("/index.jsp");
				}
				String target=request.getParameter("target");
				String keyword=request.getParameter("keyword");
				Object boardList[]=new Object[2];
				String pcpage=request.getParameter("cpage");
				if(pcpage==null) pcpage="1";
				int cpage=Integer.parseInt(pcpage);
		
				if(target==null||keyword.equals("")||target.equals("")) {
					boardList = boardDAO.selectAll( PageConfig.recordCountPerPage, cpage,PageConfig.board);
					request.setAttribute("record_total_count", boardDAO.getRecordCount("","",PageConfig.board));
					
				}
				else {
					boardList = boardDAO.selectType( PageConfig.recordCountPerPage, cpage,PageConfig.board,target,keyword);
					request.setAttribute("record_total_count", boardDAO.getRecordCount(target,keyword,PageConfig.board));
				}
			
				
				request.setAttribute("target",target);
				request.setAttribute("keyword",keyword);
				request.setAttribute("list", boardList[0]);
				request.setAttribute("board_nickname_list", boardList[1]);//boardList[1]
				request.setAttribute("cpage", cpage);
				request.setAttribute("record_count_per_page", PageConfig.recordCountPerPage);
				request.setAttribute("navi_count_per_page", PageConfig.naviCountPerPage);
				
				
				request.getRequestDispatcher("/views/board/board_view.jsp").forward(request, response);
				
			} else if(cmd.equals("/detail.board")) {
				int seq= Integer.parseInt(request.getParameter("seq"));
				String target=request.getParameter("target");
				String keyword=request.getParameter("keyword");
				boardDAO.countUp(seq);
				Object boardList[] =boardDAO.selectBoard(seq,PageConfig.board);
				Object replyList[] =replyDAO.select(seq);
				Object reply_childList[]=reply_childDAO.selectAll();
				List<FilesDTO> fileList=filesDAO.select(seq);
				
				System.out.println();
				
				
				request.setAttribute("target",target);
				request.setAttribute("keyword",keyword);
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

				String title=multi.getParameter("title");
				String contents=multi.getParameter("contents");
				String member_id= (String)session.getAttribute("WolfID");
				BoardDTO dto=new BoardDTO(0,title,contents,0,member_id,PageConfig.board,null);
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
				response.sendRedirect("/list.board");
				
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
				
			} else if(cmd.equals("/upload_images.board")) {
				int maxSize = 1024 * 1024 * 10; // 10mb
				String Path = "upload_images";
				String realPath = getServletContext().getRealPath(Path);
				System.out.println(realPath);
				File uploadPath = new File(realPath);
				if (!uploadPath.exists()) {
					uploadPath.mkdir();// 메이크 디렉토리
				}
				MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "UTF8",
						new DefaultFileRenamePolicy());
				Enumeration<String> names = multi.getFileNames();
				int parent_seq = Integer.parseInt(multi.getParameter("board_seq"));
				String member_id= (String)session.getAttribute("WolfID");
				 while(names.hasMoreElements()) {
		               String name = names.nextElement();
		               String oriname = multi.getOriginalFileName(name);
		               String sysname = multi.getFilesystemName(name);
		               //System.out.println(oriname);
		               
		             
		               File imageFile = new File(realPath + "/" + sysname);
				       BufferedImage image = null;
				       int width=0;
				       int height=0;
				        try {
				            image = ImageIO.read(imageFile);
				        } catch (IOException e) {
				            e.printStackTrace();
				        }

				        if (image != null) {
				            width = image.getWidth();
				            height = image.getHeight();
				            //System.out.println(width );
				            //System.out.println(height );

				       
				        }
				        JsonObject obj =new JsonObject();
						obj.addProperty("width", width);
						obj.addProperty("height", height);
						obj.addProperty("url", "/upload_images/"+sysname);
						
						//JsonArray jsonArray = new JsonArray();
				        //jsonArray.add(obj);
						pw.append(obj.toString());
						pw.flush(); // 버퍼에 남아있는 데이터 출력
					    pw.close(); // PrintWriter 닫기
					
					   String check=multi.getParameter("check");
					  if(oriname != null && check!=null) {
		            	   imagesDAO.insert(new ImagesDTO(0,oriname,sysname,PageConfig.board,parent_seq,member_id));
		               }
					  else {
						  // 파일 삭제
						   if (imageFile.exists()) {
							   if (imageFile.delete()) {
						         System.out.println("파일 삭제 성공");
							   } else {
						         System.out.println("파일 삭제 실패");
							   }
						    } else {
						    	System.out.println("파일이 존재하지 않습니다.");
						 	}
					  }
					    
				        
		        }
				  
				
			        
				 			
			}
			
		} catch (Exception e) {
		
		}
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
