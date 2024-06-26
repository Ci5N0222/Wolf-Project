package controllers;

import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.dao.BoardDAO;
import commons.DBConfig;
import files.dao.FilesDAO;
import reply.dao.ReplyDAO;

/**
 * Servlet implementation class FilesController
 */
@WebServlet("*.files")
public class FilesController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session= request.getSession();
		String cmd = request.getRequestURI();
		
		BoardDAO boardDAO= BoardDAO.getInstance();
		FilesDAO filesDAO= FilesDAO.getInstance();
		ReplyDAO replyDAO= ReplyDAO.getInstance();
		
		try {
			if(cmd.equals("/delete.files")) {
				int seq=Integer.parseInt(request.getParameter("seq"));
				filesDAO.delete(seq);
			}
			else if(cmd.equals("/download.files")) {
				response.reset();

				String filepath = DBConfig.realPath+"files"; // 위치 확보
				String sysname = request.getParameter("sysname"); // 이름 확보
				String oriname = request.getParameter("oriname");
				System.out.println(filepath + ":" + sysname);
				File target = new File(filepath + "/" + sysname); // 위치랑 이름 결합해서 타겟파일 인스턴스 생성

				oriname = new String(oriname.getBytes("UTF8"), "ISO-8859-1");

				response.setHeader("Content-Disposition", "attachment;filename=\"" + oriname + "\"");

				byte[] fileContents = new byte[(int) target.length()];

				try (FileInputStream fis = new FileInputStream(target); // 타겟 파일에 스트림 연결 데이터 통신준비
						DataInputStream dis = new DataInputStream(fis);
						ServletOutputStream sos = response.getOutputStream();) { // 클라이언트에게 데이터를 보낼 수 있는 스트림 개방
					dis.readFully(fileContents);// 하드디스크에서 타켓파일 내용을 ram으로 복사
					sos.write(fileContents); // 내용전송
					sos.flush(); // 스트림 정리

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
