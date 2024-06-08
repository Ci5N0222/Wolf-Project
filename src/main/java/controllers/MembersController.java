package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import commons.EncryptionUitls;
import members.dao.*;
import members.dto.*;

@WebServlet("*.members")
public class MembersController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Gson g = new Gson();
		request.setCharacterEncoding("utf8"); 
		// 클라이언트로 부터 전송되는 문자열에 대한 인코딩을 utf8 처리
		// request에서 값을 꺼내기 전에 처리해야만 함 
		String cmd = request.getRequestURI();

		MemberDAO dao = MemberDAO.getinstance();
		HttpSession session = request.getSession();
		try {
			if(cmd.equals("/signup.members")) {
				String id = request.getParameter("id");
				String pw = EncryptionUitls.getSHA512(request.getParameter("pw"));
				String name = request.getParameter("name");
				String nickname = request.getParameter("nickname");
				String phone = request.getParameter("phone");
				String email = request.getParameter("email");
				String gender = request.getParameter("gender");
				String birth = request.getParameter("birth");
				
				int result = dao.insert(new MemberDTO(id,pw,name,nickname,phone,email,gender,birth,1,null,null));
				response.sendRedirect("/index.jsp");
			}else if(cmd.equals("/idcheck.members")) {
				String id = request.getParameter("id");
			    boolean result = dao.CheckById(id);
			    
			    response.getWriter().append(String.valueOf(result));
			} else if (cmd.equals("/login.members")) {

				String id = request.getParameter("id");
				String pw = EncryptionUitls.getSHA512(request.getParameter("pw"));

				boolean result = dao.login(id, pw);
				if (result) {
					
					session.setAttribute("WolfID", id);
					
				}
				response.sendRedirect("/index.jsp");

			} else if(cmd.equals("/logout.members")) {
				session.invalidate();
				response.sendRedirect("/index.jsp");
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
