package controllers;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import board.dao.BoardDAO;
import commons.DBConfig;
import commons.PageConfig;
import files.dao.FilesDAO;
import images.dao.ImagesDAO;
import images.dto.ImagesDTO;
import reply.dao.ReplyDAO;
import reply_child.dao.Reply_childDAO;


@WebServlet("*.images")
public class ImagesController extends HttpServlet {
	
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
			if(cmd.equals("/upload.images")) {
				int maxSize = 1024 * 1024 * 10; // 10mb
				String Path = "upload_images";
				String realPath = DBConfig.realPath+Path;
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
			else if(cmd.equals("/delete.images")) {
				String board_code=request.getParameter("board_code");
				int image_code=Integer.parseInt(board_code);
				ArrayList<String> fileList=imagesDAO.delete(image_code);
				imagesDAO.deleteImageFile(DBConfig.realPath+"upload_images", fileList);	
				pw.append("success");
				
				
			}
			else if(cmd.equals("/detail_cancel.images")) {
				int board_code=Integer.parseInt(request.getParameter("board_code"));
				int board_seq=Integer.parseInt(request.getParameter("board_seq"));
				String new_contents=boardDAO.board_contents(board_seq);
		        System.out.println(new_contents);
		        String[] sysnames=boardDAO.findDeletedTags(new_contents);
		        ArrayList<String> fileList= imagesDAO.delete(board_seq, board_code, sysnames);
		        imagesDAO.deleteImageFile(DBConfig.realPath+"upload_images", fileList);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		doGet(request, response);
	}

}
