package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

@WebServlet("*.service")
public class ServiceCenterController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String cmd = request.getRequestURI();
		Gson g = new Gson();
		
		try {
			
			/** login check **/
			if(cmd.equals("/check.service")) {
				if(request.getParameter("id") == "") response.getWriter().append("fail");
				else response.getWriter().append("ok");
			}
			
			/** Service Center Main **/
			else if(cmd.equals("/main.service")) {
				request.getRequestDispatcher("/views/service_center/service_center.jsp").forward(request, response);
			}
			
			/** Q & A list **/
			else if(cmd.equals("/qna_list.service")) {
				
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
