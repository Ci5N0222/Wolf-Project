package controllers;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.plaf.basic.BasicMenuBarUI;

import com.google.gson.Gson;

import members.dao.MembersDAO;
import rank.dao.RankDAO;
import rank.dto.RankDTO;

@WebServlet("*.score")
public class ScoreController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cmd = request.getRequestURI();
		 
		Gson g = new Gson();
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("utf8"); 
		RankDAO dao = RankDAO.getInstance();
		HttpSession session = request.getSession();
		try {
			 if (cmd.equals("/rankselect.score")) {
	                int gameSeq = Integer.parseInt(request.getParameter("gameSeq"));
	                List<RankDTO> list = dao.selectRank(gameSeq);
	                String result = g.toJson(list);
	                response.getWriter().write(result);
	            }else if (cmd.equals("/myrank.score")) {
	                String nickname = (String) session.getAttribute("nickname");
	                if (nickname != null) {
	                    int gameSeq = Integer.parseInt(request.getParameter("gameSeq"));
	                    List<RankDTO> list = dao.myRank(nickname, gameSeq);
	                    String result = g.toJson(list);
	                    response.getWriter().write(result);
	                } else {
	                    response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
	                    response.getWriter().write("Unauthorized access");
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
