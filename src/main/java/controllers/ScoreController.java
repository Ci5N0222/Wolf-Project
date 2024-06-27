package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import game_score.dao.GameScoreDAO;
import rank.dao.RankDAO;
import rank.dto.RankDTO;

@WebServlet("*.score")
public class ScoreController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cmd = request.getRequestURI();
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        Gson g = new Gson();
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8"); 
        RankDAO dao = RankDAO.getInstance();
        HttpSession session = request.getSession();
        
        GameScoreDAO gameScoreDAO = GameScoreDAO.getInstance();
        
        try {
            if (cmd.equals("/rankselect.score")) {
            	String id = request.getParameter("id");
                int gameSeq = Integer.parseInt(request.getParameter("gameSeq"));
                List<RankDTO> rankList = dao.selectRank(gameSeq);
                String json = g.toJson(rankList);
                out.print(json);
                out.flush();
            } else if (cmd.equals("/userinfo.score")) {
            	 int gameSeq = Integer.parseInt(request.getParameter("gameSeq"));
                 String id = (String) session.getAttribute("WolfID");
                 String nickname = (String)session.getAttribute("WolfNickname");
                 RankDTO userInfo = dao.getUserInfo(id, gameSeq);

                 // 사용자 정보가 없을 경우 처리
                 if (userInfo == null) {
                     userInfo = new RankDTO();  // 빈 RankDTO 객체 생성
                    userInfo.setNickname(nickname);
                 }

                 String json = g.toJson(userInfo);
                 response.getWriter().write(json);
            }
            
            /** 게임 종료 시 스코어 저장 **/
            else if (cmd.equals("/save.score")) {
	    		String id = (String) session.getAttribute("WolfID");
	    		int seq = Integer.parseInt(request.getParameter("seq"));
	    		int score = Integer.parseInt(request.getParameter("score"));
        		String state = request.getParameter("state");
	    		
        		int result = 0;
        		if(state.equals("update")) {
        			result = gameScoreDAO.gameScoreUpdate(score, id, seq);
        		} else if(state.equals("insert")) {
        			result = gameScoreDAO.gameScoreInsert(score, id, seq);
        		}
        		
        		if(result > 0) {
        			response.getWriter().append(request.getParameter("score"));
        		} else {
        			response.getWriter().append("0");
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
