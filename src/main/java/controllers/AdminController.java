package controllers;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import admin.dao.AdminDAO;
import commons.EncryptionUitls;
import game.dto.GameDTO;
import members.dto.MembersDTO;

@WebServlet("*.admin")
public class AdminController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String cmd = request.getRequestURI();
		
		AdminDAO dao = AdminDAO.getInstance();
		
		// Admin login 여부 확인
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
			
			
			/** 멤버 목록 조회 **/
			else if(cmd.equals("/members_list.admin")) {
				if(!adminSession) response.sendRedirect("/views/admin/admin_login.jsp");
				else {
					List<MembersDTO> membersList = dao.getMemberList();
					request.setAttribute("membersList", membersList);
					request.getRequestDispatcher("views/admin/admin_members_list.jsp").forward(request, response);
				}
			}
			
			
			/** 멤버 정보 수정 **/
			else if(cmd.equals("/members_update.admin")) {
				if(!adminSession) response.sendRedirect("/views/admin/admin_login.jsp");
				else {
					// 선택된 회원의 DTO 가져와서 수정할 수 있어야 됨
				}
			}
			
			
			/** 서비스중인 게임 목록 **/
			else if(cmd.equals("/game_list.admin")) {
				if(!adminSession) response.sendRedirect("/views/admin/admin_login.jsp");
				else {
					List<GameDTO> gameList = dao.getGameList();
					request.setAttribute("gameList", gameList);
					request.getRequestDispatcher("/views/admin/admin_game_list.jsp").forward(request, response);
				}
			}
			
			/** 게임 디테일 **/
			else if(cmd.equals("/game_detail.admin")) {
				
			}
			
			/** 게임 데이터 추가 **/
			else if(cmd.equals("/game_insert.admin")) {
				
			}
			
			/** 게임 데이터 수정 **/
			else if(cmd.equals("/game_update.admin")) {
				
			}
			
			/** 게임 데이터 삭제 **/
			else if(cmd.equals("/game_delete.admin")) {
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
