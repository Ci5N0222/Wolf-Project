<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
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

<script src="https://kit.fontawesome.com/1ee4acc8d4.js" crossorigin="anonymous"></script>

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

.overlay {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.7);
	z-index: -1;
}

body {
	
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	margin: 0;
}

#signupcontainer {
font-family: Arial, sans-serif;
	background: #14213D;
	padding: 2px;
	margin: auto;
	border-radius: 10px;
	box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);
	text-align: center;
	max-width: 600px;
	width: 100%;
	color: #f9a620;
	position: relative;
	z-index: 1;
	box-sizing: border-box;
	
	
}


#membership {
	text-align: center;
	font-size: 24px;
	font-weight: bold;
	margin-bottom: 20px;
}

.form-group {
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 2px;
}
	label{
		flex:1;
		margin-right: 10px;
	}
	    #pw1,#birth1,#phone1,#code{
      
        margin-right: 380px; 

    }
	.pwc2{
		margin-right: 350px;
	}
	#id1,#name1{
		margin-right: 410px;
	}
	#email1,#nickname1{
		margin-right: 400px;
	}

    .form-group input[type="text"], .form-group input[type="email"]{
		width: 60%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 16px;
    }
	.form-group input[type="text"]#CertificationCode{
		 width: 52%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 16px;
	}
    .form-group input[type="password"]
   {
        width: 75%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 16px;
    }
	.form-group input[type="text"]#birth,#phone,#name {
    width: 75%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 16px;
}
	
    .form-group button {

        padding: 10px 20px;
        border: none;
        border-radius: 4px;
        background: #f9a620;
        color: white;
        font-size: 16px;
        cursor: pointer;
    }

#idCheck, #nicknameCheck,#emailCode {
	
	padding: 10px 10px;
	margin: 10px 0 ;
	border: none;
	border-radius: 4px;
	background: #f9a620;
	color: white;
	font-size: 16px;
	cursor: pointer;
}

button:hover {
	background: #f9a620;
}

.input-group {
	display: flex;
	align-items: center;
}

.input-group input[type="text"] {
	flex: 1;
	margin-right: 10px;
}

button {
	padding: 10px 20px;
	margin: 10px 0;
	border: none;
	border-radius: 4px;
	background: #f9a620;
	color: white;
	font-size: 16px;
	cursor: pointer;
}

.form-check {
    display: flex;
    align-items: center;
    margin-right:40px;
    
    
}

.form-check-input {
    margin-right: 20px; /* 체크박스와 라벨 사이의 간격 제거 */
    
}

.form-check-label {
    margin-right: 30px; /* 라벨의 왼쪽 여백 제거 */
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
			<div id="signupcontainer">
				<div id="membership">회원가입</div>
				<form action="/signup.members" id="joinform">
					<label for="id" id="id1">아이디</label>
					<div class="form-group">
						<input type="text" class="form-control" id="id" name="id"
							placeholder="소문자와 숫자만 사용가능 최소 8자 이상 입력">
						<button type="button" id="idCheck">중복 확인</button>
					</div>
					<div id="msg"></div>

					<label for="pw" id="pw1">비밀번호</label>
					<div class="form-group">
						<input type="password" class="form-control" id="pw" name="pw"
							placeholder="알파벳 대,소문자 숫자 1개씩 포함 8자 이상 입력">
					</div>
					<div id="msg2"></div>
					<label for="pwc" class="pwc2">비밀번호 확인</label>
					<div class="form-group">
						<input type="password" class="form-control" id="pwc" name="pwc"
							placeholder="비밀번호 확인">
					</div>
						<div id="message"></div>
					    <label for="name" id="name1">이름</label>
					<div class="form-group">
						<input type="text" class="form-control" id="name" name="name"
							placeholder="한글로 2글자부터 5자 사이 입력">
					</div>
					
					<label for="nickname" id="nickname1">닉네임</label>
					<div class="form-group">
						<input type="text" class="form-control" id="nickname"
							name="nickname" placeholder="닉네임">
						<button type="button" id="nicknameCheck">중복 확인</button>
					</div>
					<label for="phone" id="phone1">전화번호</label>
					<div class="form-group">
						<input type="text" class="form-control" id="phone" name="phone"
							placeholder="전화번호">
					</div>
					
					<label for="email" id="email1">이메일</label>
					<div class="form-group">
						<input type="email" class="form-control" id="email" name="email"
							placeholder="example@example.com 같은 형식으로 입력">
							<button type="button" id="emailCode">인증 하기</button>
					</div>
					 <label for="CertificationCode" id="code" style="display: none;">인증번호</label>
						<div class="form-group" id="certificationCodeGroup" style="display: none;">
   						 <input type="text" id="CertificationCode" name="CertificationCode" placeholder="인증번호를 입력해주세요">
   						 <button id="CertificationCodeBtn" type="button">인증번호 확인</button>
					</div>
					
					<div class="form-group">
						
						<div class="form-check">
						
								<label class="form-check-label"	for="male">남</label>
							<input class="form-check-input" type="checkbox" value="M"
								id="male" name="gender"> 
						</div>
						<div class="form-check">
						
								<label class="form-check-label" for="female">여</label>
							<input class="form-check-input" type="checkbox" value="F"
								id="female" name="gender"> 
						</div>
					</div>

					<label for="birth" id="birth1">생년월일</label>
					<div class="form-group">
						<input type="text" class="form-control" id="birth" name="birth" placeholder="YYYYMMDD">
					</div>

					<button type="submit" id="enterbtn">가입하기</button>
					<button type="button" id="back">돌아가기</button>
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
									let idCheckFlag = false;
									let nicknameCheckFlag = false;
									let emailCheckFlag = false;
									$("#male").on("click", function() {
										$("#female").prop("checked", false);
									});

									$("#female").on("click", function() {
										$("#male").prop("checked", false);
									});
									$("#emailCode").on("click", function() {
										if ($("#email").val() == "") {
											alert("이메일을 먼저 입력해주세요.");
											return;
										}
										let email = $("#email").val();
										

									    let regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
										let result = regex.test(email);
										if (!result) {
											alert("사용할 수 없는 형식의 이메일입니다");
											return false;
										}
										$.ajax({
											url : "/emailcheck.members",
											data : {
												email : $("#email").val()
											}
										}).done(function(resp) {
											if (resp == "true") {
												alert("이미 사용중인 이메일 입니다.");
											} else {
												$.ajax({
													url:"/emailSend.members",
													data:{
														email:$("#email").val()
														}
												}).done(function(res){
													if(res=="true"){
														 alert("이메일로 인증번호가 전송되었습니다.");
														 $("#code").show();
							                                $("#certificationCodeGroup").show();
													}else{
														alert("이메일 전송에 실패하였습니다.");
													}
												});
											}
										});
									});
									$('#CertificationCodeBtn').on("click", function() {
							            if($("#CertificationCode").val() == ""){
							            	alert("인증번호를 입력해주세요.");
							            }
							            
							            $.ajax({
							                url: '/CertificationCode.members',
							                
							                data: {
							                	CertificationCode:$("#CertificationCode").val()
							                }
										}).done(function(res){
											if(res=="true"){
												 alert("인증에 성공하였습니다.");
												 emailCheckFlag = true;
												 $('#CertificationCode').prop('disabled', true);
											}else{
												alert("인증에 실패하였습니다.");
											}
										});
									});

									
									$("#idCheck").on("click", function() {
										if ($("#id").val() == "") {
											alert("ID를 먼저 입력해주세요.");
											return;
										}
										let id = $("#id").val();
										
										let regex = /^[a-z0-9_]{8,}$/;
										let result = regex.test(id);
										if (!result) {
											alert("사용할 수 없는 형식의 ID입니다");
											return false;
										}
										$.ajax({
											url : "/idcheck.members",
											data : {
												id : $("#id").val()
											}
										}).done(function(resp) {
											if (resp == "true") {
												alert("이미 사용중인 ID 입니다.");
											} else {
												alert("사용가능한 ID 입니다.");
												idCheckFlag = true;
											}
										});
									});

									$("#nicknameCheck").on("click", function() {
										if ($("#nickname").val() == "") {
											alert("닉네임을 먼저 입력해주세요.");
											return;
										}
										$.ajax({
											url : "/nicknamecheck.members",
											data : {
												nickname : $("#nickname").val()
											}
										}).done(function(resp) {
											if (resp == "true") {
												alert("이미 사용중인 닉네임 입니다.");
											} else {
												alert("사용가능한 닉네임 입니다.");
												nicknameCheckFlag = true;
											}
										});
									});
								
									$("#nickname").on("keyup", function() {
										nicknameCheckFlag = false;
									});

									$("#back").on("click", function() {
										location.href = "/index.jsp";
									});

								

									

									

									

		



									$("#joinform")
											.on(
													"submit",
													function(event) {
														event.preventDefault();

														if (!idCheckFlag) {
															alert("ID 중복확인을 해주세요.");
															return false;
														}
														if (!nicknameCheckFlag) {
															alert("닉네임 중복확인을 해주세요.");
															return false;
														}
														if (!emailCheckFlag){
															alert("이메일 인증을 해주세요.");
															return false;
														}

														if ($("#id").val() == "") {
															alert("ID를 먼저 입력해주세요.");
															return false;
														} else {
															let id = $("#id")
																	.val();
															
															let regex = /^[a-z0-9_]{8,}$/;
															let result = regex
																	.test(id);
															if (!result) {
																alert("사용할 수 없는 형식의 ID입니다");
																return false;
															}
														}

														if ($("#pw").val() == ""
																|| $("#pwc")
																		.val() == "") {
															alert("PW를 입력 해주세요");
															return false;
														} else {
															let pw = $("#pw")
																	.val();
															
															let regex = /(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}$/;
															let result = regex
																	.test(pw);
															if (!result) {
																alert("올바르지 않은 형식의 PW 입니다.");
																return false;
															}
														}
														if ($("#name").val() == "") {
															alert("이름을 입력해주세요.");
															return false;
														} else {
															let name = $(
																	"#name")
																	.val();
															
															let regex = /^[가-힣]{2,5}$/;
															let result = regex
																	.test(name);
															if (!result) {
																alert("올바르지 않은 형식의 이름입니다.");
																return false;
															}
														}

														if ($("#nickname")
																.val() == "") {
															alert("닉네임을 입력 해주세요.");
															return false;
														}


													
														if (!$("#male").is(
																":checked")
																&& !$("#female")
																		.is(
																				":checked")) {
															alert("성별을 선택 해주세요.");
															return false;

														}
	
												
														
												  

												        this.submit();
												    });
												
											});
			</script>
			<script src="/js/main.js"></script>
</body>

</html>
