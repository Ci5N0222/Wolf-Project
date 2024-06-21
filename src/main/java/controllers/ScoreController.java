package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

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
               
                RankDTO userInfo = dao.getUserInfo(id, gameSeq);
                String json = g.toJson(userInfo);
                out.print(json);
                out.flush();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
