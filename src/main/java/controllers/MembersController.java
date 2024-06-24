package controllers;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import commons.EmailSender;
import commons.EncryptionUitls;
import members.dao.MembersDAO;
import members.dto.MembersDTO;
import oracle.net.aso.c;

@WebServlet("*.members")
public class MembersController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Gson g = new Gson();
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("utf8"); 
		// 클라이언트로 부터 전송되는 문자열에 대한 인코딩을 utf8 처리
		// request에서 값을 꺼내기 전에 처리해야만 함 
		String cmd = request.getRequestURI();

		MembersDAO dao = MembersDAO.getinstance();
		HttpSession session = request.getSession();
		try {
			if(cmd.equals("/signup.members")) {
				String id = request.getParameter("id");
				String pw = EncryptionUitls.getSHA512(request.getParameter("pw"));
				String name = request.getParameter("name");
				String nickname = request.getParameter("nickname");
				String phone = request.getParameter("phone");
				String email = request.getParameter("email");
				String gender = request.getParameter("gender");
				String birth = request.getParameter("birth");
				
				int result = dao.insert(new MembersDTO(id,pw,name,nickname,phone,email,gender,birth,1,null,null));
				response.sendRedirect("/");
				
			}else if(cmd.equals("/idcheck.members")) {
				String id = request.getParameter("id");
			    boolean result = dao.CheckById(id);
			    
			    response.getWriter().append(String.valueOf(result));
			    
			}else if(cmd.equals("/nicknamecheck.members")) {
				String nickname = request.getParameter("nickname");
			    boolean result = dao.CheckByNickname(nickname);
			    
			    response.getWriter().append(String.valueOf(result));
			    
			}else if(cmd.equals("/emailcheck.members")) {
				String email = request.getParameter("email");
				boolean result = dao.CheckByEmail(email);
				response.getWriter().append(String.valueOf(result));
			}
			else if (cmd.equals("/login.members")) {
			    String id = request.getParameter("id");
			    String pw = EncryptionUitls.getSHA512(request.getParameter("pw"));
			    
			    String[] result = dao.login(id, pw);

			    if (result != null && result.length > 0) {
			        int grade = dao.selectGrade(id);
			        if (grade == 3) {
			            // 등급이 3일 경우
			        	response.getWriter().write("{\"success\": false, \"message\": \"블랙리스트 회원은 로그인을 하실 수 없습니다.\"}");
			        }
			        else {
			            // 로그인 성공 시 세션에 정보 설정
			            session.setAttribute("WolfID", result[0]);
			            session.setAttribute("WolfNickname", result[1]);
			            session.setAttribute("WolfAvatar", result[2]);
			            if(grade == 98 || grade == 99) {
				               request.getSession().setAttribute("WolfAdmin", true);
				        }
			            response.getWriter().write("{\"success\": true}");
	               
			        }
			    } 
			
			}else if (cmd.equals("/checkLogin.members")) {
				String id = request.getParameter("id");
			    String pw = EncryptionUitls.getSHA512(request.getParameter("pw"));

			    // 회원 로그인 여부 확인
			    boolean result = dao.checkLogin(id, pw);

			    if (result) {
			        // 로그인 성공 시
			        session.setAttribute("ID", id);
			        response.getWriter().write("{\"success\": true}");
			    } else {
			        // 로그인 실패 시
			        response.getWriter().write("{\"success\": false}");
			    }
            
		         
		        }else if(cmd.equals("/logout.members")) {
				session.invalidate();
				response.sendRedirect("/index.jsp");

				/* 이메일 전송 */
			}else    if (cmd.equals("/sendEmail.members")) {
                String email = request.getParameter("email");
                String id = request.getParameter("id");
             
                try {
                    boolean result = dao.selectMemberByIdAndEmail(id, email);
                    if (result) { // 아이디와 이메일이 일치하는 회원이 있으면
                        String CertificationCode = generateRandomCode();
                        System.out.println(CertificationCode);
                        session.setAttribute("CertificationCode", CertificationCode);
                        EmailSender.sendEmail(email, "이메일 전송", "인증번호 : " + CertificationCode);
                        response.getWriter().append("true");
                    } else {
                        response.getWriter().append("false");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    response.getWriter().append("false");
                }
                /* 인증번호 확인 */
            } else if (cmd.equals("/CertificationCode.members")) {
                String userEnteredCode = request.getParameter("CertificationCode");
              
                String CertificationCode = (String) session.getAttribute("CertificationCode"); // 변경된 부분

                if (CertificationCode != null && CertificationCode.equals(userEnteredCode)) {
                    response.getWriter().append("true");
                } else {
                    response.getWriter().append("false");
                }
                /* 인증번호가 맞을 시 비밀번호 변경 */
            } else if (cmd.equals("/changePassword.members")) {
                String id = request.getParameter("id"); // 이메일 받아오기
                String newPassword = EncryptionUitls.getSHA512(request.getParameter("newPassword")); // 새 비밀번호 받아오기
                String userEnteredCode = request.getParameter("CertificationCode"); // 인증 코드 받아오기

                String CertificationCode = (String) session.getAttribute("CertificationCode"); // 세션에서 인증 코드 가져오기

                if (CertificationCode != null && CertificationCode.equals(userEnteredCode)) { // 인증 코드 확인
                    int result = 0;
                    try {
                        result = dao.updatePassword(id, newPassword); // 비밀번호 업데이트
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    if (result > 0) {
                        
                        response.getWriter().append("비밀번호가 성공적으로 변경되었습니다!");
                        

                    } else {
                        response.getWriter().append("비밀번호 변경 실패!");
                    }
                } else {
                    response.getWriter().append("인증 코드가 일치하지 않습니다!");
                }
                /* 아이디 찾기 */
            }else if (cmd.equals("/selectId.members")) {
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String id = request.getParameter("id");
                String userId = dao.selectID(name, email);
                if(userId != null) {
                	response.getWriter().write("회원님의 아이디는 : " + userId + "입니다.");
                	
                }else {
                	boolean checkname = dao.checkName(name);
                	boolean checkemail = dao.CheckByEmail(email);
                	
                	if(!checkname ) {
                		  response.getWriter().write("이름을 잘못 입력하셨습니다.");
                	}else if(!checkemail) {
                		  response.getWriter().write("이메일을 잘못 입력하셨습니다.");
                	}else {
                		  response.getWriter().write("존재하지 않는 회원입니다.");
                	}
                }
                
            }else if (cmd.equals("/emailSend.members")) {
                String email = request.getParameter("email");
                
             
                try {
                    boolean result = dao.selectMemberByEmail(email);
                    if (!result) { // 이메일이 중복되지 않았을 경우
                        String CertificationCode = generateRandomCode();
                        System.out.println(CertificationCode);
                        session.setAttribute("CertificationCode", CertificationCode);
                        EmailSender.sendEmail(email, "이메일 전송", "인증번호 : " + CertificationCode);
                        response.getWriter().append("true");
                    } else {
                        response.getWriter().append("false");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    response.getWriter().append("false");
                }
			
			
            }
            }catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
    private String generateRandomCode() {
        String chars = "0123456789";
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 6; i++) {
            int index = (int) (Math.random() * chars.length());
            sb.append(chars.charAt(index));
        }
        return sb.toString();
    }
}


