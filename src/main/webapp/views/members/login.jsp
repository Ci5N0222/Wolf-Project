<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>

<!-- icon -->
<script src="https://kit.fontawesome.com/1ee4acc8d4.js"
	crossorigin="anonymous"></script>

<!-- bootstrap -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>

<!-- Project local -->
<link rel="stylesheet" href="/css/style.css">
<link rel="stylesheet" href="/css/members.css">

<script src="/js/main.js"></script>

<style>
button {
	background: #f9a620;
	width: 100%;
	padding: 12px 15px;
	border: none;
	border-radius: 5px;
	color: white;
	font-size: 16px;
	cursor: pointer;
	transition: background 0.3s ease;
	font-family: 'Orbitron', sans-serif;
	text-transform: uppercase;
}

button:hover {
	background: #f9a620;
}
</style>

</head>


<body>
	<!-- container -->
	<div class="container-fluid d-flex flex-column">
		<div class="container text-center flex-grow-1 d-flex flex-column">
			<img src="/images/bg1.png" alt="" class="img_bg"> <img
				src="/images/bg3.png" alt="" class="img_bg bgs"> <img
				src="/images/bg3.png" alt="" class="img_bg bgs"> <img
				src="/images/bg3.png" alt="" class="img_bg bgs"> <img
				src="/images/bg3.png" alt="" class="img_bg bgs"> <img
				src="/images/bg3.png" alt="" class="img_bg bgs"> <img
				src="/images/bg3.png" alt="" class="img_bg bgs">
			<!-- nav -->
			<%@ include file="/views/include/header.jsp"%>


			<div class="login-container">
				<form action="/login.members" id="loginForm" method="post">
					<div class="centered-text">
						<h2>로그인</h2>
					</div>
					<div class="logininput">
						<div class="input-group">
							<input type="text" placeholder="아이디를 입력하세요." name="id" id="id">
						</div>
						<div class="input-group">
							<input type="password" placeholder="비밀번호를 입력하세요." name="pw"
								id="pw">
						</div>
						<div class="password-toggle">
							<label class="form-check-label" for="rememberid">아이디 저장</label> <input
								type="checkbox" id="rememberid"> <label
								class="form-check-label" for="togglePassword">비밀번호 표시</label> <input
								type="checkbox" id="togglePassword">
						</div>
						<div class="login-buttons">
							<button type="submit" id="login">로그인</button>
						</div>
						<div class="links">
							<a href="/views/members/signup.jsp">회원가입</a> <span>|</span> <a
								href="/views/members/findid.jsp">아이디찾기</a> <span>|</span> <a
								href="/views/members/findpw.jsp">비밀번호찾기</a>

						</div>
					</div>

				</form>
			</div>
			<div class="sun"></div>
			<!-- mode -->
			<div id="mode">
				<i class="fa-regular fa-lightbulb" style="display: none;"></i> <i
					class="fa-solid fa-lightbulb"></i>
			</div>
		</div>
	</div>


	<script>
				$(document).ready(function() {
								$("#loginForm")
										.submit(
												function(event) {
													event.preventDefault(); // 기본 제출 동작 방지

													let id = $("#id").val();
													let pw = $("#pw").val();
													if (id == "") {
														alert("ID를 입력해주세요.");
														return false;
													}
													if (pw == "") {
														alert("PassWord를 입력해주세요.");
														return false;
													}

													$
															.ajax({
																url : "/login.members",
																type : "POST",
																data : {
																	id : id,
																	pw : pw
																},
																dataType : "json",
																success : function(
																		response) {
																	if (response.success) {

																		location.href = "/index.jsp"; // 로그인 성공 시 메인 페이지로 이동
																	} else {
																		if (response.message) {
																			alert(response.message); // 등급이 3인 경우 메시지 출력
																			$(
																					"#id")
																					.val(
																							""); // ID 입력 필드 초기화
																			$(
																					"#pw")
																					.val(
																							""); // 비밀번호 입력 필드 초기화
																		} else {
																			alert("서버와의 통신에 실패하였습니다. 잠시 후 다시 시도해주세요.");
																		}
																	}
																},
																error : function() {
																	alert("아이디 또는 비밀번호가 잘못되었습니다. 다시 확인해 주세요.");
																	
																}
															});
												});

								$("#togglePassword")
										.on(
												"click",
												function() {
													let passwordField = $("#pw");
													let type = passwordField
															.attr("type") === "password" ? "text"
															: "password";
													passwordField.attr(
															"type", type);
												});
							});
			</script>
	<script src="/js/rememberid.js"></script>
</body>
</html>