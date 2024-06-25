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
    <title>아이디 찾기</title>
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
	padding: 15px;
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
    
        }
.container h2 {
	margin-top:40px;
	margin-bottom: 10px;
	font-size: 32px;
	color: #f9a620;
	font-family: 'Orbitron', sans-serif;
	text-transform: uppercase;
	letter-spacing: 2px;
}
        form {
            margin-top: 20px;
        }
        label {
            display: block;
            margin-right:230px;
            margin-bottom: 5px;
        }
        input[type="text"] {
            width: 70%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 3px;
            
        }
        #Certification {
            
            width: 70%;
            padding: 10px;
            background: #f9a620;
            color: #fff;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }
        button:hover {
            background: #f9a620;
        }
		.container .links {
		text-align: center;
		margin-top: 20px;
		
		}
		.container .links a {
		margin-right: 10px;
		color: #f9a620;
		text-decoration: none;
		}
		.container .links span {
		margin-right: 5px;
		color: #f9a620;
		text-decoration: none;
		}
		/* 모바일 메뉴 */ @media all and (max-width: 767px) { 
	.wolf {
		display: block;
	}
	
	.navi {
		display: none;
	}
	
	.m_navi {
		display: block;
	}
	
	.container-fluid {
		padding: 0;
	}
	
	.container {
		padding: 0;
	}
	
	/* 햄버거 */
	.navbar {
		box-shadow: 0px 1px 5px white;
	}
	
	.navbar div {
		width: 50px;
		width: 50px;
		height: 50px;
		line-height: 50px;
		margin: 0 2%;
	} }
.wolf {display: none;}


 @media all and (min-width:768px) and (max-width: 1023px) {
	.wolf {
		display: block;
	}
	
	#wolfLogo {
		display: none;
	}}
    </style>
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
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
        <h2>아이디 찾기</h2>
        <form id="findIdForm" method="post">
            <label for="name">이름:</label>
            <input type="text" id="name" name="name" required>
            <label for="email">이메일:</label>
            <input type="text" id="email" name="email" required>
            <button type="button" id="Certification">아이디 찾기</button><br>

            <div class="links">
							 <a	href="/views/members/login.jsp">로그인</a> <span>|</span> 
							<a href="/views/members/signup.jsp">회원가입</a> <span>|</span>
							 <a	href="/views/members/findpw.jsp">비밀번호찾기</a>
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
        $("#Certification").on("click", function() {
            if ($("#name").val() === "") {
                alert("이름을 입력해주세요.");
                return false;
            }
            if ($("#email").val() === "") {
                alert("이메일을 입력해주세요.");
                return false;
            } else {
				let email = $("#email").val();
				let regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
				let result = regex.test(email);
				if (!result) {
					alert("올바르지 않은 형식의 이메일입니다.");
					return false;
				}
				
            }

            var formData = {
                name: $("#name").val(),
                email: $("#email").val()
            };

            $.ajax({
                url: '/selectId.members',
                type: 'POST',
                data: formData,
                success: function(response) {
                	console.log("Response:", response); 
                	if (response.startsWith("회원님의 아이디는 : ")) {
                        alert(response);
                        let userId = response.substring(13);
                        window.location.href = "/views/members/login.jsp";
                    } else {
                        alert(response);
                    }
                    
                    
                },
                error: function(xhr, status, error) {
                    console.error('Error:', error);
                    alert("An error occurred. Please try again.");
                }
            });
        });
        $("#back").on("click",function(){
        	location.href = "/views/members/login.jsp";
        })
       
    </script>
    <script src="/js/main.js"></script>
</body>
</html>
