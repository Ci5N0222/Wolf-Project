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
				// 로그인된 세션이 없다면 로그인 페이지로 강제 이동
				if(!adminSession) response.sendRedirect("/views/admin/admin_login.jsp");
				else {
					// 1. 남여 비율 대시보드
					int[] genderCount = dao.membersTotalCount();
					
					request.setAttribute("male", genderCount[1]);
					request.setAttribute("female", (genderCount[0] - genderCount[1]));
					request.getRequestDispatcher("/views/admin/admin.jsp").forward(request, response);
					
				}
			}
			
			
			/** 로그인 **/
			else if(cmd.equals("/login.admin")) {
				String admin_id = request.getParameter("admin_id");
				String admin_pw = request.getParameter("admin_pw");
				
				int result = dao.adminLogin(admin_id, EncryptionUitls.getSHA512(admin_pw));
				if(result == 1) {
					request.getSession().setAttribute("WolfAdmin", true);
					response.getWriter().append("ok");
				} else {
					// result == 2 // 로그인 실패 (존재하지 않는 아이디)
					// result == 3 // 로그인 실패 (비밀번호 틀림)
					response.getWriter().append("fail");
				}
			}
			
			
			/** 로그아웃 **/
			else if(cmd.equals("/logout.admin")) {
				// 세션 종료
				request.getSession().invalidate();
				response.sendRedirect("/views/admin/admin_login.jsp");
			}
			
			
			/** 멤버 목록 조회 **/
			else if(cmd.equals("/memberslist.admin")) {
				List<MembersDTO> membersList = dao.getMemberList();
				request.setAttribute("membersList", membersList);
				request.getRequestDispatcher("views/admin/admin_members_list.jsp").forward(request, response);
			}
			
			
			/** 멤버 정보 수정 **/
			else if(cmd.equals("membersupdate.admin")) {
				
			}
			
			
			/** 서비스중인 게임 목록 **/
			else if(cmd.equals("gamelist.admin")) {
				List<GameDTO> gameList = dao.getGameList();
				request.setAttribute("gameList", gameList);
				request.getRequestDispatcher("admin_game_list.jsp").forward(request, response);
			}
			
			
			/** 게임 데이터 추가 **/
			else if(cmd.equals("addgame.admin")) {
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
