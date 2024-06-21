package controllers;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import commons.PageConfig;
import service_center.dao.ServiceCenterDAO;
import service_center.dto.ServiceCenterDTO;

@WebServlet("*.service")
public class ServiceCenterController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");

		String cmd = request.getRequestURI();
		
		ServiceCenterDAO dao = ServiceCenterDAO.getInstance();
		
		try {
			
			/** login check **/
			if(cmd.equals("/check.service")) {
				if((String)request.getSession().getAttribute("WolfID") == "") response.getWriter().append("fail");
				else response.getWriter().append("ok");
			}
			
			/** Service Center Main **/
			else if(cmd.equals("/main.service")) {
				request.getRequestDispatcher("/views/service_center/service_center.jsp").forward(request, response);
			}
			
			/** Q & A list **/
			else if(cmd.equals("/qna_list.service")) {
				String id = (String)request.getSession().getAttribute("WolfID");
				if(id == "") response.sendRedirect("/views/members/login.jsp");
				else {
					
					System.out.println("id === " + id);
					String pcpage = request.getParameter("cpage");
					if(pcpage == null) pcpage = "1";
					int cpage = Integer.parseInt(pcpage);
					
					String res = request.getParameter("res");
					if(res == null) res = "0";
					
					List<ServiceCenterDTO> qnaList = dao.getMyQnaList(
							id,
							res,
							cpage * PageConfig.recordCountPerPage - (PageConfig.recordCountPerPage - 1),
							cpage * PageConfig.recordCountPerPage);
					
					request.setAttribute("qnaList", qnaList);
					
					/** 페이징 **/
					request.setAttribute("cpage", cpage);
					request.setAttribute("recode_total_count", dao.getQnaTotalCount(id, res));
					request.setAttribute("recode_count_per_page", PageConfig.recordCountPerPage);
					request.setAttribute("navi_count_per_page", PageConfig.naviCountPerPage);
					
					request.setAttribute("wpageName", "res");
					request.setAttribute("wpage", res);
					
					request.getRequestDispatcher("/views/service_center/qna_list.jsp").forward(request, response);
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
