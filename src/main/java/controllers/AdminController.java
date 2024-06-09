package controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.plaf.synth.SynthOptionPaneUI;

import admin.dao.AdminDAO;
import commons.EncryptionUitls;


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
				System.out.println("Admin page start");
				
				// 로그인된 세션이 없다면 로그인 페이지로 강제 이동
				if(adminSession) response.sendRedirect("/views/admin/admin_login.jsp");
				else {
					// 메인 페이지 대시 보드 기능 작성
					// 1. 남여 비율 대시보드
					int[] genderCount = dao.membersTotalCount();
					System.out.println("남성 유저 수 ===== " + genderCount[1]);
					System.out.println("여성 유저 수 ===== " + (genderCount[0] - genderCount[1]));
					
					request.setAttribute("male", genderCount[1]);
					request.setAttribute("female", (genderCount[0] - genderCount[1]));
					request.getRequestDispatcher("admin.jsp").forward(request, response);
					
				}
			}
			
			/** 로그인 **/
			else if(cmd.equals("/login.admin")) {
				System.out.println("Admin login start");
				
				String admin_id = request.getParameter("admin_id");
				String admin_pw = request.getParameter("admin_pw");
				
				System.out.println("관리자 ID ===== " + admin_id);
				
				int result = dao.adminLogin(admin_id, admin_pw);
				if(result == 1) {
					request.getSession().setAttribute("WolfAdmin", true);
					response.sendRedirect("/main.admin");
				} else {
					// 로그인 실패
				}
				
			}
			
			/** 로그아웃 **/
			else if(cmd.equals("/logout.admin")) {
				
				// 세션 종료
				request.getSession().invalidate();
				response.sendRedirect("/views/admin/admin_login.jsp");
				 
			}
			
			/** 멤버 목록 조회 **/
			else if(cmd.equals("test1")) {
				
			}
			
			/** 멤버 정보 수정 **/
			else if(cmd.equals("test1")) {
				
			}
			
			/** 게임 데이터 추가 **/
			else if(cmd.equals("test1")) {
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
