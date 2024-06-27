package controllers;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import admin.dao.AdminDAO;
import admin.dto.AdminDTO;
import board.dao.BoardDAO;
import board.dto.BoardDTO;
import commons.DBConfig;
import commons.EncryptionUitls;
import commons.PageConfig;
import files.dao.FilesDAO;
import files.dto.FilesDTO;
import game.dto.GameDTO;
import images.dao.ImagesDAO;
import members.dto.MembersDTO;
import service_center.dto.ServiceCenterDTO;

@WebServlet("*.admin")
public class AdminController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String cmd = request.getRequestURI();
		
		AdminDAO dao = AdminDAO.getInstance();
		BoardDAO boardDAO = BoardDAO.getInstance();
		ImagesDAO imagesDAO = ImagesDAO.getInstance();
		FilesDAO filesDAO = FilesDAO.getInstance();
		
		
		/** Admin login check **/ 
		boolean adminSession = false;
		if(request.getSession().getAttribute("WolfAdmin") != null) {
			adminSession = (boolean)request.getSession().getAttribute("WolfAdmin");
		}
		
		int image_code = 3;
		
		try {
			
			/** 메인 **/
			if(cmd.equals("/main.admin")) {
				if(!adminSession) response.sendRedirect("/page_login.admin");
				else {
					// 1. 남여 비율 대시보드
					int[] genderCount = dao.membersTotalCount();
					request.setAttribute("male", genderCount[1]);
					request.setAttribute("female", (genderCount[0] - genderCount[1]));
					
					// 2. 연령별 비율 대시보드
					List<AdminDTO.AdminAgeGroupDTO> ageList = dao.membersAgeCount();
					request.setAttribute("ageList", ageList);
					
					request.getRequestDispatcher("/views/admin/admin.jsp").forward(request, response);
				}
			}
			
			
			/** 로그인 **/
			else if(cmd.equals("/page_login.admin")) {
				request.getRequestDispatcher("/views/admin/admin_login.jsp").forward(request, response);
			}
			else if(cmd.equals("/login.admin")) {
				String admin_id = request.getParameter("admin_id");
				String admin_pw = request.getParameter("admin_pw");
				
				MembersDTO dto = dao.adminLogin(admin_id, EncryptionUitls.getSHA512(admin_pw));
				
				if(dto.getGrade() == 98 || dto.getGrade() == 99) {
					request.getSession().setAttribute("WolfID", admin_id);
					request.getSession().setAttribute("WolfNickname", dto.getNickname());
					request.getSession().setAttribute("WolfAvatar", dto.getAvatar());
					request.getSession().setAttribute("WolfAdmin", true);
					response.getWriter().append("ok");
				} else {
					response.getWriter().append("fail");
				}
			}
			
			
			/** 로그아웃 **/
			else if(cmd.equals("/logout.admin")) {
				request.getSession().invalidate();
				response.sendRedirect("/page_login.admin");
			}
			
			
// ============================================ [ 회원 ] =============================================
				
			/** 멤버 목록 조회 **/
			else if(cmd.equals("/members_list.admin")) {
				if(!adminSession) response.sendRedirect("/page_login.admin");
				else {
					
					String pcpage = request.getParameter("cpage");
					if(pcpage == null) pcpage = "1";
					int cpage = Integer.parseInt(pcpage);
					
					String grade = request.getParameter("grade");
					if(grade == null) grade = "0";
					
					List<MembersDTO> membersList = dao.getMemberList(
							Integer.parseInt(grade),
							cpage * PageConfig.recordCountPerPage - (PageConfig.recordCountPerPage - 1),
							cpage * PageConfig.recordCountPerPage);
					
					request.setAttribute("membersList", membersList);
					
					/** 페이징 **/
					request.setAttribute("cpage", cpage);
					request.setAttribute("recode_total_count", dao.getMemberTotalCount(Integer.parseInt(grade)));
					request.setAttribute("recode_count_per_page", PageConfig.recordCountPerPage);
					request.setAttribute("navi_count_per_page", PageConfig.naviCountPerPage);
					
					request.setAttribute("wpageName", "grade");
					request.setAttribute("wpage", Integer.parseInt(grade));
					
					
					request.getRequestDispatcher("views/admin/admin_members_list.jsp").forward(request, response);
				}
			}
			
			
			/** 특정 멤버 검색하기 **/
			else if(cmd.equals("/members_search.admin")) {
				if(!adminSession) response.sendRedirect("/page_login.admin");
				else {
					
					String id = request.getParameter("id");
					
					String pcpage = request.getParameter("cpage");
					if(pcpage == null) pcpage = "1";
					int cpage = Integer.parseInt(pcpage);
					
					List<MembersDTO> membersList = dao.getMemberSearch(
							cpage * PageConfig.recordCountPerPage - (PageConfig.recordCountPerPage - 1),
							cpage * PageConfig.recordCountPerPage,
							id);
					
					request.setAttribute("membersList", membersList);
					
					/** 페이징 **/
					request.setAttribute("cpage", cpage);
					request.setAttribute("recode_total_count", dao.getMemberSearchCount(id));
					request.setAttribute("recode_count_per_page", PageConfig.recordCountPerPage);
					request.setAttribute("navi_count_per_page", PageConfig.naviCountPerPage);
					
					request.getRequestDispatcher("views/admin/admin_members_list.jsp").forward(request, response);
				}
			}
			
			
			/** 멤버 정보 디테일 **/
			else if(cmd.equals("/members_detail.admin")) {
				if(!adminSession) response.sendRedirect("/page_login.admin");
				else {
					String id = request.getParameter("id");
					MembersDTO member = dao.getMemberInfo(id);
					
					request.setAttribute("member", member);
					request.getRequestDispatcher("/views/admin/admin_members_detail.jsp").forward(request, response);
				}
			}
			
			
			/** 멤버 정보 수정 **/
			else if(cmd.equals("/members_update.admin")) {
				if(!adminSession) response.sendRedirect("/page_login.admin");
				else {
					// 선택된 회원의 DTO 가져와서 수정할 수 있어야 됨
					String id = request.getParameter("id");
					String grade = request.getParameter("grade");
					int result = dao.memberGradeUpdate(id, Integer.parseInt(grade));
					
					if(result > 0) response.getWriter().append("ok");
					else  response.getWriter().append("fail");
				}
			}
			
			
			/** 멤버 탈퇴 **/
			else if(cmd.equals("/members_delete.admin")) {
				if(!adminSession) response.sendRedirect("/page_login.admin");
				else {
					// 선택된 회원의 DTO 가져와서 수정할 수 있어야 됨
					String id = request.getParameter("id");
					
					int result = dao.memberDelete(id);
					
					if(result > 0) response.getWriter().append("ok");
					else  response.getWriter().append("fail");
				}
			}
			
			
// ============================================ [ 게임 ] =============================================
			
			/** 서비스중인 게임 목록 **/
			else if(cmd.equals("/game_list.admin")) {
				if(!adminSession) response.sendRedirect("/page_login.admin");
				else {
					
					String pcpage = request.getParameter("cpage");
					if(pcpage == null) pcpage = "1";
					int cpage = Integer.parseInt(pcpage);
					
					String service = request.getParameter("service");
					if(service == null) service = "9";
					
					List<GameDTO> gameList = dao.getGameList(
							Integer.parseInt(service),
							cpage * PageConfig.adminGameListRecord - (PageConfig.adminGameListRecord - 1),
							cpage * PageConfig.adminGameListRecord);
					for(GameDTO dto: gameList) {
						String sysname = imagesDAO.getImageName(dto.getSeq(), image_code);
						if(sysname != null) {
							dto.setThumbnail("thumbnails/" + sysname);
						}	
					}
					
					request.setAttribute("gameList", gameList);
					
					/** 페이징 **/
					request.setAttribute("cpage", cpage);
					request.setAttribute("recode_total_count", dao.getGameTotalCount(Integer.parseInt(service)));
					request.setAttribute("recode_count_per_page", PageConfig.adminGameListRecord);
					request.setAttribute("navi_count_per_page", PageConfig.naviCountPerPage);
					
					request.setAttribute("wpageName", "service");
					request.setAttribute("wpage", Integer.parseInt(service));
					
					request.getRequestDispatcher("/views/admin/admin_game_list.jsp").forward(request, response);
				}
			}
			
			
			/** 게임 디테일 **/
			else if(cmd.equals("/game_detail.admin")) {
				if(!adminSession) response.sendRedirect("/page_login.admin");
				else {
					
					String seq = request.getParameter("seq");
					GameDTO game = dao.getGameInfo(Integer.parseInt(seq));
					request.setAttribute("beforeThumbnail", game.getThumbnail());
					
					String sysname = imagesDAO.getImageName(Integer.parseInt(seq), image_code);
					if(sysname != null) {
						game.setThumbnail("thumbnails/" + sysname);
					}
					
					request.setAttribute("game", game);
					request.getRequestDispatcher("/views/admin/admin_game_detail.jsp").forward(request, response);
				}
			}
			
			
			/** 게임 추가 **/
			else if(cmd.equals("/page_game_insert.admin")) {
				if(!adminSession) response.sendRedirect("/page_login.admin");
				else request.getRequestDispatcher("/views/admin/admin_game_insert.jsp").forward(request, response);
			}
			else if(cmd.equals("/game_insert.admin")) {
				if(!adminSession) response.sendRedirect("/page_login.admin");
				else {
					
					int maxSize = 1024 * 1024 * 10;
					String realPath = DBConfig.realPath+"thumbnails";
					File uploadPath = new File(realPath);
					
					if(!uploadPath.exists()) {
						uploadPath.mkdir();
					}
					
					MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "UTF8", new DefaultFileRenamePolicy());

					String title = multi.getParameter("game_title");
					String discription = multi.getParameter("game_discription");
					String contents = multi.getParameter("game_contents");
					String oriname = multi.getOriginalFileName("game_image");
					String sysname = multi.getFilesystemName("game_image");
					
					int seq = dao.adminGameInsert(title, discription, contents, oriname);
					if(seq > 0) {
						imagesDAO.GameThumbnailInsert(oriname, sysname, image_code, seq);
						response.sendRedirect("/game_list.admin");
					}
				}
			}
			
			
			/** 게임 수정 **/
			else if(cmd.equals("/game_update.admin")) {
				if(!adminSession) response.sendRedirect("/page_login.admin");
				else {
					
					int maxSize = 1024 * 1024 * 10;
					String realPath = DBConfig.realPath+"thumbnails";
					File uploadPath = new File(realPath);
					
					if(!uploadPath.exists()) {
						uploadPath.mkdir();
					}

					MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "UTF8", new DefaultFileRenamePolicy());
					
					String seq = multi.getParameter("game_seq");
					String title = multi.getParameter("game_title");
					String discription = multi.getParameter("game_discription");
					String contents = multi.getParameter("game_contents");
					String service = multi.getParameter("sevice_select");
					
					String oriname = multi.getOriginalFileName("game_image");
					String sysname = multi.getFilesystemName("game_image");
					
					int result = dao.adminGameUpdate(Integer.parseInt(seq), title, discription, contents, oriname, service);
					if(result > 0) {
						if(sysname != null) {
							
							imagesDAO.GameThumbnailDelete(image_code, Integer.parseInt(seq));
							imagesDAO.GameThumbnailInsert(oriname, sysname, image_code, Integer.parseInt(seq));
							
							String beforSysname = multi.getParameter("before_thumbnail");
							String[] beforeArr = beforSysname.split("/");
							String before = beforeArr[beforeArr.length-1];

							File fileToDelete = new File(uploadPath, before);
							if(fileToDelete.exists()) {
								fileToDelete.delete();
							}
						}
					}
					
					response.sendRedirect("/game_list.admin");
				}
			}
			
			
			/** 게임 삭제 **/
			else if(cmd.equals("/game_delete.admin")) {
				if(!adminSession) response.sendRedirect("/page_login.admin");
				else {
					
					String seq = request.getParameter("seq");
					int result = dao.adminGameDelete(Integer.parseInt(seq));
					
					if(result == 1) {
						response.getWriter().append("ok");
					} else {
						response.getWriter().append("fail");
					}
				}
			}

// ============================================ [ 게시판 ] =============================================
			
			/** 게시판 리스트( 공지, FAQ ) **/
			else if(cmd.equals("/notice_list.admin")) {
				if(!adminSession) response.sendRedirect("/page_login.admin");
				else {
					
					String pcpage = request.getParameter("cpage");
					if(pcpage == null) pcpage = "1";
					int cpage = Integer.parseInt(pcpage);
					
					String boardCode = request.getParameter("board_code");
					if(boardCode == null) boardCode = "2";

					List<AdminDTO.BoardListDTO> boardList = dao.getBoardList(
							Integer.parseInt(boardCode),
							cpage * PageConfig.recordCountPerPage - (PageConfig.recordCountPerPage - 1),
							cpage * PageConfig.recordCountPerPage);
					
					request.setAttribute("boardList", boardList);
					
					/** 페이징 **/
					request.setAttribute("cpage", cpage);
					request.setAttribute("recode_total_count", dao.getBoardTotalCount(Integer.parseInt(boardCode)));
					request.setAttribute("recode_count_per_page", PageConfig.recordCountPerPage);
					request.setAttribute("navi_count_per_page", PageConfig.naviCountPerPage);
					
					request.setAttribute("wpageName", "board_code");
					request.setAttribute("wpage", Integer.parseInt(boardCode));
					
					request.getRequestDispatcher("/views/admin/admin_notice_list.jsp").forward(request, response);
				}
			}

			/** 공지사항, FAQ 작성 **/
			else if(cmd.equals("/page_notice_insert.admin")) {
				if(!adminSession) response.sendRedirect("/page_login.admin");
				String code = request.getParameter("code");
				request.setAttribute("board_code", code);
				request.getRequestDispatcher("/views/admin/admin_notice_insert.jsp").forward(request, response);
			}
			else if(cmd.equals("/notice_insert.admin")) {
				if(!adminSession) response.sendRedirect("/page_login.admin");
				else {
					
					int maxSize = 1024 * 1024 * 10; // 10mb
					String realPath = DBConfig.realPath+"files";
					File uploadPath = new File(realPath);
					if (!uploadPath.exists()) {
						uploadPath.mkdir();// 메이크 디렉토리
					}
					
					MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "UTF8",
							new DefaultFileRenamePolicy());

					String title = multi.getParameter("title");
					String contents = multi.getParameter("contents");
					String boardCode = multi.getParameter("board_code");
					String member_id = (String)request.getSession().getAttribute("WolfID");
					
					BoardDTO dto = new BoardDTO(0, title, contents, 0, member_id, Integer.parseInt(boardCode), null, "N");
					int board_seq = boardDAO.insert(dto);
					//dao_files.insert(new FilesDTO(0, oriName, sysName, parent_seq));
					Enumeration<String> names = multi.getFileNames();
			        while(names.hasMoreElements()) {
			               String name = names.nextElement();
			               String oriname = multi.getOriginalFileName(name);
			               String sysname = multi.getFilesystemName(name);
			               System.out.println(name);
			               
			               if(oriname != null) {
			            	   filesDAO.insert(new FilesDTO(0, oriname, sysname, board_seq));
			               }
			        }
			        imagesDAO.updateTemp(board_seq);
			        String new_contents = boardDAO.board_contents(board_seq,Integer.parseInt(boardCode) );
			        System.out.println(new_contents);
			        String[] sysnames = boardDAO.findDeletedTags(new_contents);
			        ArrayList<String> fileList = imagesDAO.delete(board_seq, Integer.parseInt(boardCode), sysnames);
			        imagesDAO.deleteImageFile(DBConfig.realPath+"upload_images", fileList);
			        
			        response.sendRedirect("/detail.board?seq="+board_seq+"&target=&keyword=&board_code=" + Integer.parseInt(boardCode));
				}
				
			}
			
			
			/** QNA 게시판 리스트 **/
			else if(cmd.equals("/qna_list.admin")) {
				if(!adminSession) response.sendRedirect("/page_login.admin");
				else {
					// 내용 작성
					String pcpage = request.getParameter("cpage");
					if(pcpage == null) pcpage = "1";
					int cpage = Integer.parseInt(pcpage);
					
					String res = request.getParameter("res");
					if(res == null) res = "1";

					List<ServiceCenterDTO> boardList = dao.getQnaList(
							res,
							cpage * PageConfig.recordCountPerPage - (PageConfig.recordCountPerPage - 1),
							cpage * PageConfig.recordCountPerPage);
					
					request.setAttribute("boardList", boardList);
					
					/** 페이징 **/
					request.setAttribute("cpage", cpage);
					request.setAttribute("recode_total_count", dao.getQnaTotalCount(res));
					request.setAttribute("recode_count_per_page", PageConfig.recordCountPerPage);
					request.setAttribute("navi_count_per_page", PageConfig.naviCountPerPage);
					
					request.setAttribute("wpageName", "res");
					request.setAttribute("wpage", res);
					
					request.getRequestDispatcher("/views/admin/admin_qna_list.jsp").forward(request, response);
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
