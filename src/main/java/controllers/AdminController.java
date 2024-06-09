package controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("*.admin")
public class AdminController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String cmd = request.getRequestURI();
		
		// Admin login 여부 확인
		boolean adminSession = (boolean) request.getSession().getAttribute("WolfAdmin");
		
		try {
			
			/** 메인 **/
			if(cmd.equals("/admin")) {
				System.out.println("Admin page start");
				
				// 로그인된 세션이 없다면
				if(adminSession) response.sendRedirect("admin_login.jsp");
				else {
					// 메인 페이지 대시 보드 기능 작성
				}
			}
			
			/** 로그인 **/
			else if(cmd.equals("test1")) {
				
				int result = 1;	// dao.adminLogin 성공 시
				if(result == 1) request.getSession().setAttribute("WolfAdmin", true);
				 
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
