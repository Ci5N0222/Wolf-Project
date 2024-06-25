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



<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>아이디 찾기</title>
<!-- Project local -->
<link rel="stylesheet" href="/css/style.css">
<link rel="stylesheet" href="/css/members.css">
<script src="/js/main.js"></script>
<style>

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
	margin-top: 40px;
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
	margin-right: 230px;
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
				<h2>아이디 찾기</h2>
				<form id="findIdForm" method="post">
					<label for="name">이름:</label> <input type="text" id="name"
						name="name" required> <label for="email">이메일:</label> <input
						type="text" id="email" name="email" required>
					<button type="button" id="Certification">아이디 찾기</button>
					<br>

					<div class="links">
						<a href="/views/members/login.jsp">로그인</a> <span>|</span> <a
							href="/views/members/signup.jsp">회원가입</a> <span>|</span> <a
							href="/views/members/findpw.jsp">비밀번호찾기</a>
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

</body>
</html>
