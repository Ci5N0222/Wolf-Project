<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
<script src="https://code.jquery.com/jquery-3.7.1.js">
	
</script>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f5f5f5;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	margin: 0;
}

.centered-text {
	text-align: center;
}

.login-container {
	width: 300px;
	margin: 0 auto;
	border: 1px solid #ccc;
	padding: 20px;
}

.login-container input[type="text"], .login-container input[type="password"]
	{
	width: 100%;
	padding: 10px;
	margin-bottom: 10px;
	box-sizing: border-box;
	background-color: #2f2f2f;
	border: 1px solid #444;
	color: #fff;
}

.login-container button {
	width: 100%;
	padding: 10px;
	box-sizing: border-box;
	margin: 0 auto;
	background-color: #1f5c99;
	border: none;
	border-radius: 4px;
	color: #fff;
	cursor: pointer;
	transition: background-color 0.3s;
}

.login-container button:hover {
	background-color: #144272;
}

.login-container .login-buttons {
	display: flex;
	justify-content: center;
	margin-top: 20px;
}

.login-container .login-buttons button {
	width: 100%;
}

.login-container .links {
	text-align: center;
	margin-top: 20px;
}

.login-container .links a {
	margin-right: 10px;
	color: #1f5c99;
	text-decoration: none;
}

.login-container .links span {
	margin-right: 5px;
	color: #1f5c99;
	text-decoration: none;
}

.login-container .logininput {
	padding: 30px;
	background-color: #1f1f1f;
}
.togglePasswordLabel {
    color: white;
}
</style>
</head>
<body>

	<div class="login-container">
		<form action="/login.members" id="loginForm" method="post">
			<div class="centered-text">
				<h2>로그인</h2>
			</div>
			<div class="logininput">
				<div>
					<input type="text" placeholder="아이디를 입력하세요." name="id" id="id">
				</div>
				<div>
					<input type="password" placeholder="비밀번호를 입력하세요." name="pw" id="pw">
                    <input type="checkbox" id="togglePassword">
					 <label for="togglePassword" class="togglePasswordLabel">비밀번호 표시</label>
				</div>
				<div class="login-buttons">
					<button type="submit" id="login">로그인</button>
				</div>
				<div class="links">
					<a href="/views/members/signup.jsp">회원가입</a> <br> <a
						href="/views/members/findid.jsp">아이디찾기</a> <span>|</span> <a
						href="/views/members/findpw.jsp">비밀번호찾기</a>
				</div>
			</div>
		</form>
	</div>

	<script>
		$("#togglePassword").on("click", function() {
			console.log("aaa");
			// #togglePassword 요소에 클릭 이벤트를 바인딩합니다.

			let passwordField = $("#pw");
			// 변수 passwordField에는 id가 "pw"인 요소(jQuery 객체)가 할당됩니다.

			let type;
			if (passwordField.attr("type") === "password") {
				type = "text";
			} else {
				type = "password";
			}
			// passwordField의 type 속성이 "password"인지 확인합니다.
			// 만약 "password"이면 변수 type에 "text"를 할당하고,
			// 그렇지 않으면 "password"를 할당합니다.

			passwordField.attr("type", type);
			// passwordField의 type 속성을 변수 type의 값으로 설정합니다.
			// 이로써 비밀번호 입력 필드의 텍스트 표시/숨기기가 토글됩니다.
		});
		
		
		$("#login").on("click", function() {
			console.log("aaa");
			let id = $("#id").val();
			let password = $("#pw").val();
			if (id == "") {
				alert("아이디를 입력하세요!");
				return false;
			}
			if (password == "") {
				alert("비밀번호를 입력하세요!");
				return false;
			}
			$.ajax({
			    url: "/checkLogin.members",
			    method: "POST",
			    data: { id: id, pw: password },
			    dataType: "json"
			})
			.done(function(resp) {
			    if (resp.success) {
			        
			        location.href = "/index.jsp"; 
			    } else {
			        alert("아이디 또는 비밀번호가 잘못되었습니다. 다시 확인해 주세요.");
			    }
			})
			});
		
		
		
	</script>
</body>
</html>