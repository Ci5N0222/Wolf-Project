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
        try {
            if (cmd.equals("/rankselect.score")) {
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
            else if (cmd.equals("/update.score")) {
            	String id = (String) session.getAttribute("WolfID");
            	if(id == "") {
            		// 로그인 안한 회원 DB 업데이트 필요 없음
            	} else {
            		
            		// 점수가 있을 시 업데이트
            			// 해당 페이지에 본인의 점수를 가져온다.
            			// 가져온 점수보다 현재 플레이한 점수가 높을 경우 업데이트
            		// 없을 시 인서트
            			// 해당 페이지에 본인의 점수가 없다면 인서트
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
