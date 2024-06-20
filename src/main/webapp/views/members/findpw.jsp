<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
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
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 찾기 </title>
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
body {
	
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	margin: 0;
}
#container {
font-family: Arial, sans-serif;
    background: #14213D;
    padding: 2px;
    margin: auto;
    border-radius: 10px;
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);
    text-align: center;
    max-width: 400px;
    width: 100%;
    color: #f9a620;
    position: relative;
    z-index: 1;
    box-sizing: border-box;
    height: auto;
    transition: height 0.5s ease; /* 높이 변경 애니메이션 효과 */
}
            h2 {
        	margin-top:25px;
            text-align: center;
        }
        form {
            margin-top: 20px;
        }
		 label {
            display: block;
            margin-right:220px;
            
            margin-bottom: 5px;
        }
        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: 70%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }
        #passwordMismatch {
            margin-top: 10px;
        }
       button {
       		margin-top:20px;
            margin-bottom:20px;
            width: 70%;
            padding: 10px;
            background: #f9a620;
            color: #fff;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }
        button:hover {
            background-color: #f9a620;
        }
        #Result {
            margin-top: 10px;
            text-align: center;
        }
        #passwordChangeForm {
            display: none;
        }

	 .pwcheck {
        margin-left: 55px; /* 새 비밀번호 확인 라벨의 왼쪽 여백 조정 */
    }
		#newpw{
			margin-left: 20px;
		}

    </style>
</head>
<body>
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

    <div id="container">
        <h2>비밀번호 찾기</h2>
        <div id="Result"></div>
        <form id="sendEmailForm" action="/sendEmail.members" method="post">
            <label for="id" >아이디</label>
            <input type="text" id="id" name="id" placeholder="ID를 입력해주세요.">
            <label for="email" >이메일</label>
            <input type="email" id="email" name="email" placeholder="Emali을 입력해주세요.">
            <button type="submit">인증번호 발송</button>
        </form>
        
        <form id="passwordChangeForm" action="/changePassword.members" method="post">
            <label for="CertificationCode" id="code" >인증번호</label>
            <input type="text" id="CertificationCode" name="CertificationCode"  placeholder="인증번호를 입력해주세요">
            <div id="timer"></div>
            <button id="CertificationCodeBtn" type="button">인증번호 확인</button>
            <div id="passwordFields" style="display: none;">
                <label for="newPassword" id="newpw">새 비밀번호</label>
                <input type="password" id="newPassword" name="newPassword" placeholder="새 비밀번호를 입력해주세요">
                <label for="confirmNewPassword" class="pwcheck">새 비밀번호 확인  </label>
                <input type="password" id="confirmNewPassword" name="confirmNewPassword" placeholder="새 비밀번호를 확인해주세요.">
                <div id="passwordMismatch" style="display: none; color: red;">
                    비밀번호가 일치하지 않습니다!
                </div>
                <button id="changePasswordBtn" type="button" name="changePasswordBtn">비밀번호 변경</button>
            </div>
        </form>
    </div>
    	<div class="sun"></div>
			<!-- mode -->
			<div id="mode">
				<i class="fa-regular fa-lightbulb" style="display: none;"></i> <i
					class="fa-solid fa-lightbulb"></i>
			</div>

    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script>
    $(document).ready(function() {
        var timerInterval; // 타이머를 저장할 변수

        $('#sendEmailForm').submit(function(e) {
            e.preventDefault();
            
            if($("#id").val()==""){
            	alert("아이디를 입력해주세요.");
            	return false;
            }
            	
            if($("#email").val()==""){
            	alert("이메일을 입력해주세요.")
            	return false;
            }
            
            
            var formData = {
                id: $('#id').val(),
                email: $('#email').val()
            };

            $.ajax({
                url: '/sendEmail.members',
                type: 'POST',
                data: formData,
                success: function(data) {
                    if (data === 'true') {
                        startTimer(); // 인증 코드 발송 성공 시 타이머 시작
                        $('#passwordChangeForm').show();
                        $('#sendEmailForm').hide();
                        $('#email').prop('disabled', true); // 이메일 입력 필드 비활성화
                    } else {
                        alert('아이디와 이메일이 일치하지 않습니다.');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Error:', error);
                }
            });
        });

        $('#CertificationCodeBtn').click(function() {
            var formData = $('#passwordChangeForm').serialize();
            
            $.ajax({
                url: '/CertificationCode.members',
                type: 'POST',
                data: formData,
                success: function(data) {
                    if (data === 'true') {
                        alert('인증에 성공하였습니다.');
                        $('#passwordFields').show();
                        $('#CertificationCodeBtn').hide();
                        $('#CertificationCode').prop('disabled', true); // 인증번호 입력 필드 비활성화
                    } else {
                        alert('인증에 실패하였습니다.')
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Error:', error);
                }
            });
        });

        $('#changePasswordBtn').click(function() {
            var newPassword = $('#newPassword').val();
            var confirmPassword = $('#confirmNewPassword').val();
            var id = $('#id').val();
            var CertificationCode = $('#CertificationCode').val(); // 인증 코드 가져오기
            
            if (newPassword !== confirmPassword) {
                $('#passwordMismatch').show();
                return;
            } else {
                $('#passwordMismatch').hide();
            }

            var formData = {
                id: id,
                newPassword: newPassword,
                CertificationCode: CertificationCode
            };

            $.ajax({
                url: '/changePassword.members',
                type: 'POST',
                data: formData,
                success: function(data) {
                    alert("비밀번호가 성공적으로 변경 되었습니다.")
                    location.href = '/views/members/login.jsp';
                },
                error: function(xhr, status, error) {
                    console.error('Error:', error);
                }
            });
        });

        // 타이머 시작 함수
        function startTimer() {
            var duration = 300; // 5분을 초 단위로 설정 (3 * 60)

            var timerElement = $('#timer'); // 타이머가 표시될 요소

            var startTime = Math.floor(Date.now() / 1000); // 현재 시간을 초로 변환

            timerInterval = setInterval(function() {
                var currentTime = Math.floor(Date.now() / 1000); // 현재 시간을 초로 변환
                var elapsedSeconds = currentTime - startTime;
                var remainingSeconds = duration - elapsedSeconds;

                if (remainingSeconds <= 0) {
                    clearInterval(timerInterval); // 타이머 중지
                    timerElement.text("시간 초과");
                    $('#passwordChangeForm').hide();
                    $('#sendEmailForm').show();
                    $('#email').prop('disabled', false); // 이메일 입력 필드 활성화
                } else {
                    var minutes = Math.floor(remainingSeconds / 60);
                    var seconds = remainingSeconds % 60;
                    var timerText = ('0' + minutes).slice(-2) + ':' + ('0' + seconds).slice(-2);
                    timerElement.text(timerText);
                }
            }, 1000);
        }
    });

    </script>
        <script src="/js/main.js"></script>
</body>
</html>
