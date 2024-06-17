<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
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


<script src="https://code.jquery.com/jquery-3.7.1.js">
	
</script>
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Luckiest+Guy&family=Noto+Sans+KR:wght@100..900&display=swap')
	;

:root { -
	-bg-light: #ffd449; -
	-bg-dark: #14213D; -
	-bg-transparent: transparent; -
	-color-white: #eeeeee; -
	-color-black: #14213D; -
	-bg-nav: #f9a620; -
	-color-nav-icon: #14213D; -
	-color-nav-bg: #f9a620;
	font-size: 16px;
}

html, body {
	height: 100%;
	margin: 0;
	background-color: var(- -bg-dark);
	color: var(- -bg-black);
	color: var(- -color-black);
	overflow: hidden;
	/* 폰트 */
	font-family: "Noto Sans KR", sans-serif;
	font-family: "Luckiest Guy", cursive;
}

body.light {
	background-color: var(- -bg-light);
	color: var(- -bg-black);
}
/* 하단 원 */
.sun {
	position: absolute;
	width: 120%;
	height: 100%;
	background-color: var(- -color-nav-bg);
	box-shadow: 5px -5px 10px var(- -bg-light);
	border-radius: 50%;
	top: 40%;
	left: 50%;
	transform: translateX(-50%);
}
/* 모드 변경시 부드럽게 넘어가는 효과 */
.sun, .navi {
	transition: background-color 0.5s ease, box-shadow 0.5s ease;
}
/* img */
.img_bg {
	position: absolute;
	top: -60%;
	left: 0;
	width: 100%;
	object-fit: cover;
}

.bgs {
	animation: bg 1s ease-in Infinite Alternate;
	transition: all ease-in 0.2s;
	width: 50px;
}

.bgs:nth-child(1) {
	top: 15%;
	left: 80%;
}

.bgs:nth-child(2) {
	top: 20%;
	left: 80%;
	width: 40px;
}

.bgs:nth-child(3) {
	top: 15%;
	left: 20%;
}

.bgs:nth-child(4) {
	top: 27%;
	left: 70%;
	width: 20px;
}

.bgs:nth-child(5) {
	top: 12%;
	left: 50%;
}

.bgs:nth-child(6) {
	top: 12%;
	left: 80%;
	width: 20px;
}

@
keyframes bg { 0% {
	opacity: 1;
}

100


%
{
opacity


:


0
;


}
}
.container-fluid, .container, .main {
	height: 100%;
}
/* 메뉴 */
.navi {
	border: 1px solid white;
	z-index: 5;
	height: 10%;
	display: flex;
	align-items: center;
	background-color: var(- -bg-nav);
	padding: 0 3%;
	font-size: 20px;
	color: var(- -color-white);
	text-shadow: 1px 1px 1px gray;
	letter-spacing: 1px;
	border-radius: 40px 80px/80px 40px;
}

.navi i {
	font-size: 22px;
}

.navi>div {
	margin-top: 0;
}

.navi>div:nth-child(2) #wolfLogo {
	width: 100px;
	height: 100px;
}
/* 로고 */
.navi #wolfLogo>img {
	object-fit: cover;
	width: 100%;
	height: 100%;
}
/* 메뉴 버튼 */
.naviBtn {
	cursor: pointer;
	transition: all 0.3s ease-in-out;
}

.naviBtn:hover {
	opacity: 0.5;
}
/* -- main과 동일 -- */
/* 라이트 다크 mode */
#mode {
	cursor: pointer;
	position: absolute;
	bottom: 5%;
	right: 5%;
	background-color: var(- -bg-dark);
	width: 50px;
	height: 50px;
	display: flex;
	align-items: center;
	justify-content: center;
	border-radius: 50%;
	transition: all ease-in 0.2s;
	animation: ball 1s ease-in Infinite Alternate;
	border: double 1px rgba(255, 255, 255, 0.46);
}

@
keyframes ball { 0% {
	bottom: 5%;
}

95


%
{
width


:


50px
;


}
to {
	bottom: 8%;
	width: 50px;
	height: 60px
}

}
/* 모드 전환 버튼 호버 시 투명도 조정 */
#mode:hover {
	opacity: 0.8;
}

/* 모드 전환 버튼 아이콘 스타일 */
#mode i {
	font-size: 30px;
	color: var(—color-nav-bg);
}

body, html {
	margin: 0;
	padding: 0;
	width: 100%;
	height: 100%;
	display: flex;
	justify-content: center;
	align-items: center;
	font-family: 'Roboto', sans-serif;
	background-size: cover;
}

.overlay {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.7);
	z-index: -1;
}

.login-container {
	background: #14213D;
	padding: 40px;
	margin: auto;
	border-radius: 10px;
	box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);
	text-align: center;
	max-width: 400px;
	width: 100%;
	color: #fff;
	position: relative;
	z-index: 1;
	box-sizing: border-box;
}

.login-container h2 {
	margin-bottom: 20px;
	font-size: 32px;
	color: #f9a620;
	font-family: 'Orbitron', sans-serif;
	text-transform: uppercase;
	letter-spacing: 2px;
}

.input-group {
	margin-bottom: 20px;
	position: relative;
	display: flex;
	align-items: center;
}

                .password-toggle {
                    display: flex;
                    align-items: center;
                    color: white;
                    font-weight: bold;
                    margin-top: 10px;
                    width: 150px;
                }

                .password-toggle input[type="checkbox"] {
                    margin-left: 5px;
                    margin-bottom : 10px;
                    /* 체크박스 왼쪽 여백 */
                }


.input-group input {
	width: calc(100% - 30px);
	padding: 12px 15px;
	border: none;
	border-radius: 5px;
	background: rgba(255, 255, 255, 0.2);
	color: #fff;
	font-size: 16px;
	transition: background 0.3s ease;
	margin: 0 auto;
	display: block;
}

.input-group input::placeholder {
	color: white;
}

.input-group input:focus {
	outline: none;
	background: rgba(255, 255, 255, 0.3);
}

#togglePassword {
	color: white;
	display: block;
	margin-top: 10px;
	cursor: pointer;
}

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

.login-container::after {
	content: "";
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: url('https://example.com/wolf-overlay.png') no-repeat center
		center;
	background-size: contain;
	opacity: 0.1;
	z-index: -1;
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
	color: #f9a620;
	text-decoration: none;
}

.login-container .links span {
	margin-right: 5px;
	color: #f9a620;
	text-decoration: none;
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
                                        <input type="password" placeholder="비밀번호를 입력하세요." name="pw" id="pw">
                                    </div>
                                    <div class="password-toggle">
                                        비밀번호 표시 <input type="checkbox" id="togglePassword">
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
			<div class="sun"></div>
			<!-- mode -->
			<div id="mode">
				<i class="fa-regular fa-lightbulb" style="display: none;"></i> <i
					class="fa-solid fa-lightbulb"></i>
			</div>


			<script>
				$(document)
						.ready(
								function() {
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
																				alert("아이디 또는 비밀번호가 잘못되었습니다. 다시 확인해 주세요.");
																			}
																		}
																	},
																	error : function() {
																		alert("서버와의 통신에 실패하였습니다. 잠시 후 다시 시도해주세요.");
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
			<script src="/js/main.js"></script>
</body>
</html>