package controllers;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import board.dao.BoardDAO;
import board.dto.BoardDTO;
import commons.PageConfig;
import files.dao.FilesDAO;
import files.dto.FilesDTO;
import images.dao.ImagesDAO;
import service_center.dao.ServiceCenterDAO;
import service_center.dto.ServiceCenterDTO;

@WebServlet("*.service")
public class ServiceCenterController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");

		String cmd = request.getRequestURI();
		
		ServiceCenterDAO dao = ServiceCenterDAO.getInstance();
		BoardDAO boardDAO = BoardDAO.getInstance();
		FilesDAO filesDAO = FilesDAO.getInstance();
		ImagesDAO imagesDAO = ImagesDAO.getInstance();
		
		try {
			
			/** login check **/
			if(cmd.equals("/check.service")) {
				if((String)request.getSession().getAttribute("WolfID") == "") response.getWriter().append("fail");
				else response.getWriter().append("ok");
			}
			
			/** 고객센터 메인 페이지 **/
			else if(cmd.equals("/main.service")) {
				request.getRequestDispatcher("/views/service_center/service_center.jsp").forward(request, response);
			}
			
			/** Q & A 목록 **/
			else if(cmd.equals("/qna_list.service")) {
				String id = (String)request.getSession().getAttribute("WolfID");
				if(id == "") response.sendRedirect("/views/members/login.jsp");
				else {
					
					String pcpage = request.getParameter("cpage");
					if(pcpage == null) pcpage = "1";
					int cpage = Integer.parseInt(pcpage);
					
					String res = request.getParameter("res");
					if(res == null) res = "0";
					
					List<ServiceCenterDTO> qnaList = dao.getMyQnaList(
							id,
							res,
							cpage * PageConfig.recordCountPerPage - (PageConfig.recordCountPerPage - 1),
							cpage * PageConfig.recordCountPerPage);
					
					request.setAttribute("qnaList", qnaList);
					
					/** 페이징 **/
					request.setAttribute("cpage", cpage);
					request.setAttribute("recode_total_count", dao.getQnaTotalCount(id, res));
					request.setAttribute("recode_count_per_page", PageConfig.recordCountPerPage);
					request.setAttribute("navi_count_per_page", PageConfig.naviCountPerPage);
					
					request.setAttribute("wpageName", "res");
					request.setAttribute("wpage", res);
					
					request.getRequestDispatcher("/views/service_center/qna_list.jsp").forward(request, response);
				}
			}
			
			/** Q & A 작성 **/
			else if(cmd.equals("/page_qna_insert.service")) {
				String id = (String)request.getSession().getAttribute("WolfID");
				if(id == "") response.sendRedirect("/views/members/login.jsp");
				else {
					request.getRequestDispatcher("/views/service_center/qna_insert.jsp").forward(request, response);
				}
			}
			else if(cmd.equals("/qna_insert.service")) {
				String id = (String)request.getSession().getAttribute("WolfID");
				if(id == "") response.sendRedirect("/views/members/login.jsp");
				else {
	
					int maxSize = 1024 * 1024 * 10; // 10mb
					String realPath = request.getServletContext().getRealPath("files");
					File uploadPath = new File(realPath);
					
					if (!uploadPath.exists()) {
						uploadPath.mkdir();// 메이크 디렉토리
					}
					
					MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "UTF8", new DefaultFileRenamePolicy());
					
					String secret = "";
					if(multi.getParameter("secret") == null) secret = "Y";
					else secret=multi.getParameter("secret");
					
					String title = multi.getParameter("title");
					String contents = multi.getParameter("contents");
					String member_id = (String)request.getSession().getAttribute("WolfID");
					int board_code = 3;
					
					BoardDTO dto = new BoardDTO(0, title, contents, 0, member_id, board_code ,null, secret);
					int board_seq = boardDAO.insert(dto);

					int result = dao.qnaResInsert(board_seq);
					
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
			        
					response.sendRedirect("/list.board?board_code="+board_code);
					
				}
			}
			
			/** FAQ 목록 **/
			else if(cmd.equals("/faq_list.service")) {
				String id = (String)request.getSession().getAttribute("WolfID");
				if(id == "") response.sendRedirect("/views/members/login.jsp");
				else {

					String pcpage = request.getParameter("cpage");
					if(pcpage == null) pcpage = "1";
					int cpage = Integer.parseInt(pcpage);
					List<ServiceCenterDTO> faqList = dao.getFaqList(
							cpage * PageConfig.recordCountPerPage - (PageConfig.recordCountPerPage - 1),
							cpage * PageConfig.recordCountPerPage);

					request.setAttribute("faqList", faqList);

					/** 페이징 **/
					request.setAttribute("cpage", cpage);
					request.setAttribute("recode_total_count", dao.getFaqTotalCount());
					request.setAttribute("recode_count_per_page", PageConfig.recordCountPerPage);
					request.setAttribute("navi_count_per_page", PageConfig.naviCountPerPage);

					request.getRequestDispatcher("/views/service_center/faq_list.jsp").forward(request, response);
				}
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}