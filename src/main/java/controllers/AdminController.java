package controllers;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import admin.dao.AdminDAO;
import commons.EncryptionUitls;
import commons.PageConfig;
import game.dto.GameDTO;
import members.dto.MembersDTO;

@WebServlet("*.admin")
public class AdminController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String cmd = request.getRequestURI();
		
		AdminDAO dao = AdminDAO.getInstance();
		
		/** Admin login check **/ 
		boolean adminSession = false;
		if(request.getSession().getAttribute("WolfAdmin") != null) {
			adminSession = (boolean)request.getSession().getAttribute("WolfAdmin");
		}
		
		try {
			
			/** 메인 **/
			if(cmd.equals("/main.admin")) {
				if(!adminSession) response.sendRedirect("/page_login.admin");
				else {
					// 1. 남여 비율 대시보드
					int[] genderCount = dao.membersTotalCount();
					request.setAttribute("male", genderCount[1]);
					request.setAttribute("female", (genderCount[0] - genderCount[1]));
					
					// 2. 연령별 비율 대시보드
					
					request.getRequestDispatcher("/views/admin/admin.jsp").forward(request, response);
				}
			}
			
			
			/** 로그인 **/
			else if(cmd.equals("/page_login.admin")) {
				request.getRequestDispatcher("/views/admin/admin_login.jsp").forward(request, response);
			}
			else if(cmd.equals("/login.admin")) {
				String admin_id = request.getParameter("admin_id");
				String admin_pw = request.getParameter("admin_pw");
				
				int result = dao.adminLogin(admin_id, EncryptionUitls.getSHA512(admin_pw));
				if(result == 1) {
					request.getSession().setAttribute("WolfAdmin", true);
					response.getWriter().append("ok");
				} else {
					response.getWriter().append("fail");
				}
			}
			
			
			/** 로그아웃 **/
			else if(cmd.equals("/logout.admin")) {
				request.getSession().invalidate();
				response.sendRedirect("/page_login.admin");
			}
			
			
// ============================================ [ 회원 ] =============================================
				
			/** 멤버 목록 조회 **/
			else if(cmd.equals("/members_list.admin")) {
				if(!adminSession) response.sendRedirect("/page_login.admin");
				else {
					
					String pcpage = request.getParameter("cpage");
					if(pcpage == null) pcpage = "1";
					int cpage = Integer.parseInt(pcpage);
					
					List<MembersDTO> membersList = dao.getMemberList(
							cpage * PageConfig.recordCountPerPage - (PageConfig.recordCountPerPage - 1),
							cpage * PageConfig.recordCountPerPage);
					
					request.setAttribute("membersList", membersList);
					
					/** 페이징 **/
					request.setAttribute("cpage", cpage);
					request.setAttribute("recode_total_count", dao.getMemberTotalCount());
					request.setAttribute("recode_count_per_page", PageConfig.recordCountPerPage);
					request.setAttribute("navi_count_per_page", PageConfig.naviCountPerPage);
					
					request.getRequestDispatcher("views/admin/admin_members_list.jsp").forward(request, response);
				}
			}
			
			
			/** 멤버 정보 디테일 **/
			else if(cmd.equals("/members_detail.admin")) {
				if(!adminSession) response.sendRedirect("/page_login.admin");
				else {
					String id = request.getParameter("id");
					MembersDTO member = dao.getMemberInfo(id);
					
					request.setAttribute("member", member);
					request.getRequestDispatcher("/views/admin/admin_members_detail.jsp").forward(request, response);
				}
			}
			
			
			/** 멤버 정보 수정 **/
			else if(cmd.equals("/members_update.admin")) {
				if(!adminSession) response.sendRedirect("/page_login.admin");
				else {
					// 선택된 회원의 DTO 가져와서 수정할 수 있어야 됨
					String id = request.getParameter("id");
					String grade = request.getParameter("grade");
					
					int result = dao.memberGradeUpdate(id, Integer.parseInt(grade));
					
					if(result > 0) response.getWriter().append("ok");
					else  response.getWriter().append("fail");
				}
			}
			
			
// ============================================ [ 게임 ] =============================================
			
			/** 서비스중인 게임 목록 **/
			else if(cmd.equals("/game_list.admin")) {
				if(!adminSession) response.sendRedirect("/page_login.admin");
				else {
					
					String pcpage = request.getParameter("cpage");
					if(pcpage == null) pcpage = "1";
					int cpage = Integer.parseInt(pcpage);
					
					List<GameDTO> gameList = dao.getGameList(
							cpage * PageConfig.recordCountPerPage - (PageConfig.recordCountPerPage - 1),
							cpage * PageConfig.recordCountPerPage);
					
					request.setAttribute("gameList", gameList);
					
					/** 페이징 **/
					request.setAttribute("cpage", cpage);
					request.setAttribute("recode_total_count", dao.getGameTotalCount());
					request.setAttribute("recode_count_per_page", PageConfig.recordCountPerPage);
					request.setAttribute("navi_count_per_page", PageConfig.naviCountPerPage);
					
					request.getRequestDispatcher("/views/admin/admin_game_list.jsp").forward(request, response);
				}
			}
			
			
			/** 게임 디테일 **/
			else if(cmd.equals("/game_detail.admin")) {
				if(!adminSession) response.sendRedirect("/page_login.admin");
				else {
					String seq = request.getParameter("seq");
					GameDTO game = dao.getGameInfo(Integer.parseInt(seq));
					
					request.setAttribute("game", game);
					request.getRequestDispatcher("/views/admin/admin_game_detail.jsp").forward(request, response);
				}
			}
			
			
			/** 게임 추가 **/
			else if(cmd.equals("/page_game_insert.admin")) {
				if(!adminSession) response.sendRedirect("/page_login.admin");
				else request.getRequestDispatcher("/views/admin/admin_game_insert.jsp").forward(request, response);
			}
			else if(cmd.equals("/game_insert.admin")) {
				if(!adminSession) response.sendRedirect("/page_login.admin");
				else {
					
					int maxSize = 1024 * 1024 * 10;
					String realPath = request.getServletContext().getRealPath("thumbnails");
					File uploadPath = new File(realPath);
					
					if(!uploadPath.exists()) {
						uploadPath.mkdir();
					}
					
					MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "UTF8", new DefaultFileRenamePolicy());

					String title = multi.getParameter("game_title");
					String discription = multi.getParameter("game_discription");
					String contents = multi.getParameter("game_contents");
					String oriname = multi.getOriginalFileName("game_image");
					String sysname = multi.getFilesystemName("game_image");
					
					int seq = dao.adminGameInsert(title, discription, contents, oriname);
					System.out.println("admin game insert seq === "+ seq);
					if(seq > 0) {
						dao.adminGameThumbnailInsert(3, oriname, sysname, seq);
						response.sendRedirect("/game_list.admin");
					}
					
					
				}
			}
			
			
			/** 게임 수정 **/
			else if(cmd.equals("/game_update.admin")) {
				if(!adminSession) response.sendRedirect("/page_login.admin");
				else {
					
				}
			}
			
			
			/** 게임 삭제 **/
			else if(cmd.equals("/game_delete.admin")) {
				if(!adminSession) response.sendRedirect("/page_login.admin");
				else {
					
					String seq = request.getParameter("seq");
					int result = dao.adminGameDelete(Integer.parseInt(seq));
					
					if(result == 1) {
						response.getWriter().append("ok");
					} else {
						response.getWriter().append("fail");
					}
				}
			}

			
// ============================================ [ 게시판 ] =============================================
			
			/** 공지 게시판 글쓰기 **/
			else if(cmd.equals("/board_notice.admin")) {
				if(!adminSession) response.sendRedirect("/page_login.admin");
				else {
					
				}
			}
			
			/** QNA 게시판 답변 남기기 **/
			else if(cmd.equals("/board_qna.admin")) {
				if(!adminSession) response.sendRedirect("/page_login.admin");
				else {
					
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
