package controllers;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import game.dao.GameDAO;
import mypage.dto.GameScoreDTO;

@WebServlet("*.mypage")
public class MypageController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		GameDAO dao = GameDAO.getInstance();
		Gson g = new Gson();
		
		HttpSession session = request.getSession();
		
		String cmd= request.getRequestURI();
		System.out.println("확인중 :" + cmd);
		
		try {
			
			if(cmd.equals("/selectMember.mypage")) {
				
				
			} else if(cmd.equals("/")) {
				
				
				/* 마이페이지 게임플레이 정보 조회 */
			} else if(cmd.equals("/mypageGameList.mypage")) {
				String id = (String)session.getAttribute("WolfID");
				
				List<GameScoreDTO> result = dao.gameList(id);
				System.out.println(result.size());
				
				request.setAttribute("result", result);
				request.getRequestDispatcher("/views/mypage/myGameList.jsp").forward(request, response);

			}
			
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
