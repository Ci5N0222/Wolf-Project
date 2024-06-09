package controllers;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import game.dao.GameDAO;
import game.dto.GameDTO;


@WebServlet("*.game")
public class GameController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		GameDAO dao = GameDAO.getInstance();
		
		String cmd= request.getRequestURI();
		System.out.println("확인중 :" + cmd);
		
		try {
			if(cmd.equals("/list.game")) {
				
				List<GameDTO> list = dao.getList();
				request.setAttribute("list", list);
				request.getRequestDispatcher("/game.jsp").forward(request, response);
				
			}else if(cmd.equals("/detail.game")) {
				
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
