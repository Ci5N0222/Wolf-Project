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

import board.dao.BoardDAO;
import commons.DBConfig;
import commons.EncryptionUitls;
import commons.PageConfig;
import game.dao.GameDAO;
import images.dao.ImagesDAO;
import images.dto.ImagesDTO;
import members.dao.MembersDAO;
import members.dto.MembersDTO;
import mypage.dao.MypageDAO;
import mypage.dto.GameScoreDTO;
import mypage.dto.MypageDTO;

@WebServlet("*.mypage")
public class MypageController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		
		GameDAO gDAO = GameDAO.getInstance();
		MembersDAO mDAO = MembersDAO.getinstance();
		MypageDAO pDAO = MypageDAO.getinstance();
		ImagesDAO iDAO =ImagesDAO.getInstance();
		BoardDAO bDAO = BoardDAO.getInstance();
		
		HttpSession session = request.getSession();
		Gson g = new Gson();
		PrintWriter pw= response.getWriter();
		
		String cmd= request.getRequestURI();
		
		try {
			/** 마이페이지 메인 화면 **/
			if(cmd.equals("/main.mypage")) {
				String nickName = (String)session.getAttribute("WolfNickname");
				
				request.getRequestDispatcher("/views/mypage/mypage.jsp").forward(request, response);				
			
				/** 마이페이지 내 정보 조회 **/
			} else if(cmd.equals("/selectMember.mypage")) {
				String loginID = (String)session.getAttribute("WolfID");
				MembersDTO dto = mDAO.selectMember(loginID);
				
				request.setAttribute("member", dto);
				request.getRequestDispatcher("/views/mypage/updateInfo.jsp").forward(request, response);

				
				/** 내 정보 수정 **/
			} else if (cmd.equals("/update.mypage")) {
				String action = request.getParameter("action");
			    if ("defaultAvatar".equals(action)) {    
			    		pw.append("success"); 
			        
			    } else {
				//--- 파일 업로드
				String id = (String)session.getAttribute("WolfID");
				int maxSize = 1024 * 1024 * 10; // 10MB 사이즈 제한
				String realPath = DBConfig.realPath+id; // 파일이 저장될 위치
				System.out.println(realPath);
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

				}
				
				String name = multi.getParameter("name");
				String nickname = multi.getParameter("nickname");
				String phone = multi.getParameter("phone");
				String email = multi.getParameter("email");
				String avatar ="";
				String deleteSysname=iDAO.selectMypageAvatar(id);
				
				if(sysName == null) {
					if(multi.getParameter("defaultCheck").equals("true")) {
						if (!deleteSysname.equals("")) {
				            File imageFile = new File(realPath + "/" + deleteSysname);
				            if (imageFile.exists()) {
				                if (imageFile.delete()) {
				                    System.out.println("파일 삭제 성공");
				                } else {
				                    System.out.println("파일 삭제 실패");
				                }
				            } else {
				                System.out.println("파일이 존재하지 않습니다.");
				            }
				        }
						avatar=null;
						iDAO.deleteMypageAvatar(id);
					}
					else {
						avatar = (String)session.getAttribute("WolfAvatar");
					}
					
				} else {
					avatar = "/"+id + "/" + sysName;
					File imageFile = new File(realPath + "/" + deleteSysname);
					 if (imageFile.exists()) {
						   if (imageFile.delete()) {
					         System.out.println("파일 삭제 성공");
					         
						   } else {
					         System.out.println("파일 삭제 실패");
						   }
					 }else {
					    System.out.println("파일이 존재하지 않습니다.");
					 }
				}
			
				if(deleteSysname.equals("")) {
					iDAO.insert(new ImagesDTO(0,oriName,sysName,2,0,id));
				}
				else {
					iDAO.updateMypage(oriName, sysName, id);
				}
				
				MembersDTO dto = new MembersDTO(id, null, name, nickname, phone, email, null, null, 0, avatar, null);
				mDAO.edit(dto);
				
				request.getSession().setAttribute("WolfAvatar", avatar);
				request.getSession().setAttribute("WolfNickname", nickname);
				response.sendRedirect("/selectMember.mypage");

			    }
			    
				/** 현재 비밀번호 체크 **/
			} else if(cmd.equals("/pwCheck.mypage")){

				String id = (String)session.getAttribute("WolfID");
				String current_password = EncryptionUitls.getSHA512(request.getParameter("current_password"));
				
				boolean result = mDAO.isPWExist(id, current_password);
				
				response.setContentType("text/html; charset=UTF-8");			
				if(result) response.getWriter().append("ok");
				else response.getWriter().append("fail");
				
				
				/** 비밀번호 변경 **/
			} else if(cmd.equals("/pwUpdate.mypage")){

				String id = (String)session.getAttribute("WolfID");
				String new_password = EncryptionUitls.getSHA512(request.getParameter("new_password"));
				
				int result = mDAO.updatePW(id, new_password);
				
				response.setContentType("text/html; charset=UTF-8");			
				if(result > 0) response.getWriter().append("ok");
				else response.getWriter().append("fail");
				
				
				/** 마이페이지 게임플레이 정보 조회 **/
			} else if(cmd.equals("/mypageGameList.mypage")) {
				String id = (String)session.getAttribute("WolfID");
				
				System.out.println(id);
				List<GameScoreDTO> result = gDAO.gameList(id);
				System.out.println(result.size());
				
				for(GameScoreDTO dto : result) {
					String sysname = iDAO.getImageName(dto.getGame_seq(), 3);
					if(sysname != null) {
						dto.setThumbnail("thumbnails/" + sysname);
					}	
				}
				
				request.setAttribute("result", result);
				request.getRequestDispatcher("/views/mypage/myGameList.jsp").forward(request, response);

				
				/** 내 게시글 조회 **/
			} else if(cmd.equals("/myList.mypage")) {
				
				String id = (String) request.getSession().getAttribute("WolfID");
				String pcpage = request.getParameter("cpage");
				if(pcpage == null) pcpage = "1";
				int cpage = Integer.parseInt(pcpage);
				
				List<MypageDTO.BoardListDTO> boardList = pDAO.myBoardList(
						id,
						cpage * PageConfig.recordCountPerPage - (PageConfig.recordCountPerPage - 1),
						cpage * PageConfig.recordCountPerPage);
				
				request.setAttribute("list", boardList);

				request.setAttribute("cpage", cpage);
				request.setAttribute("recode_total_count", pDAO.myBoardTotalCount(id));
				request.setAttribute("recode_count_per_page", PageConfig.recordCountPerPage);
				request.setAttribute("navi_count_per_page", PageConfig.naviCountPerPage);
				

				request.getRequestDispatcher("/views/mypage/myList.jsp").forward(request, response);
				
				/** 회원 탈퇴 **/
			} else if(cmd.equals("/delete.mypage")) {
				
				String id = (String)session.getAttribute("WolfID");
			    String inputPw = EncryptionUitls.getSHA512(request.getParameter("password"));

			    boolean isValid = mDAO.isPWExist(id, inputPw);
			    
			    response.setContentType("text/html; charset=UTF-8");
			    
			    if(isValid) {
			    		mDAO.deleteMember(id);
			    		response.getWriter().append("ok");
			    }
				else {
					response.getWriter().append("fail");
				}
			}
			
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
