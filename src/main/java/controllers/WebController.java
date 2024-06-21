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

@WebServlet("*.web")
public class WebController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String cmd = request.getRequestURI();
		
		GameDAO gameDAO = GameDAO.getInstance();
		
		Gson g = new Gson();
		
		try {
			
			if(cmd.equals("/home.web")) {
				List<GameDTO> gameList = gameDAO.getList();
				String result = "{\"result\": \"ok\", \"data\": "+ g.toJson(gameList)+"}";
				response.getWriter().append(result);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
