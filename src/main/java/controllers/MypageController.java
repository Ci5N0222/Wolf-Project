package controllers;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import commons.EncryptionUitls;
import game.dao.GameDAO;
import members.dao.MembersDAO;
import members.dto.MembersDTO;
import mypage.dto.GameScoreDTO;

@WebServlet("*.mypage")
public class MypageController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		
		GameDAO gDAO = GameDAO.getInstance();
		MembersDAO mDAO = MembersDAO.getinstance();

		HttpSession session = request.getSession();
		Gson g = new Gson();
		
		String cmd= request.getRequestURI();
		System.out.println("확인중 :" + cmd);
		
		try {
			
			/* 마이페이지 내 정보 조회 */
			if(cmd.equals("/selectMember.mypage")) {
				String loginID = (String)session.getAttribute("WolfID");
				MembersDTO dto = mDAO.selectMember(loginID);
				
				request.setAttribute("member", dto);
				request.getRequestDispatcher("/views/mypage/updateInfo.jsp").forward(request, response);

				/* 내 정보 수정 */
			} else if (cmd.equals("/update.mypage")) {
				//--- 파일 업로드
				int maxSize = 1024 * 1024 * 10; // 10MB 사이즈 제한
				String realPath = request.getServletContext().getRealPath("files"); // 파일이 저장될 위치
				File uploadPath = new File(realPath); // 저장 위치 폴더를 파일 인스턴스로 생성

				if (!uploadPath.exists()) { // 파일 업로드 할 폴더가 존재하지 않는다면
					uploadPath.mkdir(); // 폴더를 만들겠다.
				}
				MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "UTF8",
						new DefaultFileRenamePolicy());
				
				Enumeration<String> names = multi.getFileNames();
				String sysName="";
				String oriName="";
				oriName = new String(oriName.getBytes("UTF8"), "ISO-8859-1");
				while(names.hasMoreElements()) {
					
					String name = names.nextElement();
					 oriName= multi.getOriginalFileName(name); // 원본 파일 이름
					sysName = multi.getFilesystemName(name); // 서버에 저장된 파일의 이름

					System.out.println(sysName);
				}
				
				response.reset(); // 기존에 response가 가지고 있는 내용을 리셋하는 작업
				response.setHeader("Content-Disposition", "attachment;filename=\""+oriName+"\"");
				
				String id = (String)session.getAttribute("WolfID");
				String name = multi.getParameter("name");
				String nickname = multi.getParameter("nickname");
				String phone = multi.getParameter("phone");
				String email = multi.getParameter("email");
				String avatar = realPath + "/" + sysName;

				MembersDTO dto = new MembersDTO(id, null, name, nickname, phone, email, null, null, 0, avatar, null);

				mDAO.edit(dto);

				response.sendRedirect("/select.members");

				/* 비밀번호 변경 */
			} else if(cmd.equals("/pwUpdate.mypage")){

				String id = (String)session.getAttribute("WolfID");
				String current_password = EncryptionUitls.getSHA512(request.getParameter("current_password"));
				
				boolean result = mDAO.isPWExist(id, current_password);
				
				response.setContentType("text/html; charset=UTF-8");			

				PrintWriter pw = response.getWriter();
				
				if(result) { // db에 pw있다면 변경
					id = (String)session.getAttribute("WolfID");
					String new_password = EncryptionUitls.getSHA512(request.getParameter("new_password"));
					String confirm_password = EncryptionUitls.getSHA512(request.getParameter("confirm_password"));
					
					if(new_password.equals(confirm_password)) {
						mDAO.updatePW(id, new_password);
						pw.append("true");
						
					} else {
						System.out.println("확인 비밀번호 불일치");
						pw.append("false1");
					}
					
				} else {
					pw.append("false2");
					System.out.println("현재 비밀번호 오류");
				}				
				
				/* 마이페이지 게임플레이 정보 조회 */
			} else if(cmd.equals("/mypageGameList.mypage")) {
				String id = (String)session.getAttribute("WolfID");
				
				List<GameScoreDTO> result = gDAO.gameList(id);
				System.out.println(result.size());
				
				request.setAttribute("result", result);
				request.getRequestDispatcher("/views/mypage/myGameList.jsp").forward(request, response);

				
				/* 문의내역 조회 */
			} else if(cmd.equals("/myPost.mypage")) {
				
				
				/* 회원 탈퇴 */
			} else if(cmd.equals("/delete.mypage")) {
				
				
			}
			
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
