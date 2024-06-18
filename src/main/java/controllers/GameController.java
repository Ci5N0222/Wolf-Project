package controllers;

import java.io.Console;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.jasper.tagplugins.jstl.core.ForTokens;

import com.google.gson.Gson;

import game.dao.GameDAO;
import game.dao.ScoreDAO;
import game.dto.GameDTO;
import game.dto.ScoreDTO;
import images.dao.ImagesDAO;


@WebServlet("*.game")
public class GameController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		GameDAO dao = GameDAO.getInstance();
		ImagesDAO imagesDAO = ImagesDAO.getInstance();
		ScoreDAO scoreDAO = ScoreDAO.getInstance();
		Gson g = new Gson();
		
		String cmd= request.getRequestURI();
		System.out.println("확인중 :" + cmd);
		
		try {
			if(cmd.equals("/list.game")) {
				
				List<GameDTO> list = dao.getList();
				
				// image_cdoe 3 == thumbnail
				int image_code = 3;
				
				// 서버에서 thumbnail 경로 추가
				for(GameDTO game : list) {
					String sysname = imagesDAO.getImageName(game.getSeq(), image_code);
					if(sysname.equals("none")) {
						game.setThumbnail(sysname);
					} else {
						game.setThumbnail("thumbnails/" + sysname);
					}
				}
				
				request.setAttribute("list", list);
				request.getRequestDispatcher("/views/game/gameList.jsp").forward(request, response);
				
			}else if(cmd.equals("/detail.game")) {
				
			    int seq = Integer.parseInt(request.getParameter("seq"));
			    GameDTO dto = dao.getDetail(seq);
			    
			    // image_cdoe 3 == thumbnail
			    int image_code = 3;
			    
			    // 서버에서 thumbnail 경로 추가
			    String sysname = imagesDAO.getImageName(seq, image_code);
			    if(sysname.equals("none")) {
			    	dto.setThumbnail(sysname);
				} else {
					dto.setThumbnail("thumbnails/" + sysname);
				}
			    
			    request.setAttribute("dto", dto);
			    request.getRequestDispatcher("/views/game/gameDetail.jsp").forward(request, response);
			    
			}else if(cmd.equals("/gameview.game")) {
				String game_seq= request.getParameter("seq");
				
				List <ScoreDTO> list= scoreDAO.gameList(Integer.parseInt(game_seq));
				request.setAttribute("list", list);
				request.getRequestDispatcher("/views/game/game.jsp").forward(request, response);
				
				
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
