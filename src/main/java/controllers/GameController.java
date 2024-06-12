package controllers;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import game.dao.GameDAO;
import game.dto.GameDTO;


@WebServlet("*.game")
public class GameController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		GameDAO dao = GameDAO.getInstance();
		Gson g = new Gson();
		
		String cmd= request.getRequestURI();
		System.out.println("확인중 :" + cmd);
		
		try {
			if(cmd.equals("/list.game")) {
				
				List<GameDTO> list = dao.getList();
				request.setAttribute("list", list);
				request.getRequestDispatcher("/views/game/gameList.jsp").forward(request, response);
				
			}else if(cmd.equals("/detail.game")) {
				
			    int seq = Integer.parseInt(request.getParameter("seq"));
//			    System.out.println(seq+ "확인");
			    GameDTO dto= dao.getDetail(seq);
			    request.setAttribute("dto", dto);
			    request.getRequestDispatcher("/views/game/gameDetail.jsp").forward(request, response);

			    
			    
			}else if(cmd.equals("/score.game")) {
				
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
