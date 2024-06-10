<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
 <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

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

#container {
	display: flex;
	/* Flex Container로 설정 */
	flex-direction: column;
	/* 세로 방향으로 정렬 */
	align-items: flex-start;
	/* 왼쪽 정렬 */
	width: 500px;
	padding: 20px;
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

#membership {
	text-align: center;
	font-size: 24px;
	font-weight: bold;
	margin-bottom: 20px;
}

input[type="text"], input[type="password"] {
	width: calc(100% - 20px);
	padding: 10px;
	margin: 10px 0;
	border: 1px solid #ccc;
	border-radius: 4px;
	font-size: 16px;
}

#idCheck, #nicknameCheck {
	padding: 10px 20px;
	margin: 10px 0;
	border: none;
	border-radius: 4px;
	background-color: dodgerblue;
	color: white;
	font-size: 16px;
	cursor: pointer;
}

button:hover {
	background-color: #0056b3;
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
	background-color: forestgreen;
	color: white;
	font-size: 16px;
	cursor: pointer;
}

#warn {
	display: flex;
	justify-content: flex-start;
	align-items: center;
	color: red;
	flex-direction: column;
	margin: auto;
	width: 100%;
	/* 전체 너비 */
	max-width: 500px;
	/* 최대 너비 */
	padding: 0 20px;
	/* 좌우 여백 */
}
</style>
</head>

<body>


	<!-- 절대경로 지정법 : /signup.members - > http://localhost/signup.members -->
	<!-- 상대경로 지정법 : signup.members - > http://localhost/현재위치/signup.members -->
	<div id="container">
		<div id="membership">회원가입</div>
		<form action="/signup.members" id="joinform">
		<div class="form-group">
                <input type="text" class="form-control" id="id" name="id" placeholder="아이디" >
                <button type="button" id="idCheck">중복 확인</button>
            </div>
            <div id="msg"></div>


            <div class="form-group">
                <input type="password" class="form-control" id="pw" name="pw" placeholder="비밀번호" >
            </div>
            <div id="msg2"></div>
            <div class="form-group">
                <input type="password" class="form-control" id="pwc" name="pwc" placeholder="비밀번호 확인">
                <div id="message"></div>
                </div>
            <div class="form-group">
                <input type="text" class="form-control" id="name" name="name" placeholder="이름" >
            </div>
            <div id="msg1"></div>
            <div class="form-group">
                <input type="text" class="form-control" id="nickname" name="nickname" placeholder="닉네임" >
            </div>
            <button type="button" id="nicknameCheck">중복 확인</button>
            <div class="form-group">
                <input type="text" class="form-control" id="phone" name="phone" placeholder="전화번호" >
            </div>
            <div id="message1"></div>
            <div class="form-group">
                <input type="email" class="form-control" id="email" name="email" placeholder="이메일" >
            </div>
            <div id="msg3"></div>

            <div class="form-group">
                <select class="form-control" id="gender" name="gender">
                    <option value="M">남성</option>
                    <option value="F">여성</option>
                </select>
            </div>

            <div class="form-group">
                <input type="text" class="form-control" id="birth" name="birth" placeholder="YYMMDD">
            </div>

			<button type="submit" id="enterbtn">가입하기</button>
			<button type="button" id="back">돌아가기</button>
		</form>
	</div>
	<script>
		
		$("#idCheck").on("click",function(){
		    if($("#id").val()==""){
		        alert("ID를 먼저 입력해주세요.");
		        return;
		    }
			$.ajax({
				url:"/idcheck.members",
				data:{
					id:$("#id").val()
				}
			}).done(function(resp){
				if(resp=="true"){
					alert("이미 사용중인 ID 입니다.");
				}else{
					alert("사용가능한 ID 입니다.");
				}
			})
		})
		$("#nicknameCheck").on("click",function(){
		    if($("#nickname").val()==""){
		        alert("닉네임을 먼저 입력해주세요.");
		        return;
		    }
			$.ajax({
				url:"/nicknamecheck.members",
				data:{
					nickname:$("#nickname").val()
				}
			}).done(function(resp){
				if(resp=="true"){
					alert("이미 사용중인 닉네임 입니다.");
				}else{
					alert("사용가능한 닉네임 입니다.");
				}
			})
		})
		
		$("#back").on("click", function() {
			location.href = "/index.jsp";
		})

		$("#pwc").on("keyup", function() {
			let pw = $("#pw").val();
			let pwc = $("#pwc").val();
			let message = $("#message");
			if (pw == pwc) {
				message.text("패스워드 일치").css("color", "dodgerblue");
			} else {
				message.text("패스워드 불일치").css("color", "red");
			}

		})
		$("#postcode").on("click", function() {
			new daum.Postcode({
				oncomplete : function(data) {

					let address = data.jibunAddress;
					let postcode = data.zonecode;

					$("#post").val(postcode);
					$("#address1").val(address);

				}
			}).open();
		})
		$("#id").on("keyup", function() {
			let id = $("#id").val()
			let msg = $("#msg");
			let regex = /^[a-z0-9_]{8,}$/;
			let result = regex.test(id);
			if (result) {
				msg.text("사용할 수 있는 형식의 ID입니다.").css("color", "dodgerblue");
			} else if(!result){
				msg.text("사용할 수 없는 형식의 ID입니다").css("color", "red");
			} 

		});
		$("#name").on("keyup", function() {
			let name = $("#name").val();
			let msg1 = $("#msg1");
			let regex = /^[가-힣]{2,5}$/g;
			let result = regex.test(name);
			if (result) {
				msg1.text("올바른 이름입니다.").css("color", "dodgerblue");
			} else {
				msg1.text("올바르지 않은 이름입니다.").css("color", "red");
			}
		})
		$("#pw").on("keyup", function() {
			let pw = $("#pw").val();
			let msg2 = $("#msg2");
			let regex = /(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}/;
			let result = regex.test(pw);
			if (result) {
				msg2.text("올바른 형식입니다.").css("color", "dodgerblue");
			} else {
				msg2.text("올바르지 않은 형식입니다.").css("color", "red");
			}

		});

		$("#phone").on("keyup ", function() {
			let phone = $("#phone").val();
			let message1 = $("#message1");
			let regex = /^01[0,1,7]-?[\d]{4}-?[\d]{4}$/;

			let result = regex.test(phone);
			if (result) {
				message1.text("올바른 입력").css("color", "dodgerblue");
			} else {
				message1.text("전화번호 다시 입력").css("color", "red");
			}

		})
		$("#email").on("keyup", function() {
			let email = $("#email").val();
			let msg3 = $("#msg3");

			let regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
			let result = regex.test(email);
			if (result) {
				msg3.text("올바른 입력").css("color", "dodgerblue");
			} else {
				msg3.text("이메일 다시 입력").css("color", "red");
			}

		})
		$("#joinform").on("submit", function() {
			// return false; // e.preventDefault();
			if ($("#id").val() == "") {
				alert("ID를 먼저 입력해주세요.");
				return false;

			}
			else {
				let id = $("#id").val()
				let msg = $("#msg");
				let regex = /^[a-z0-9_]{8,}$/;
				let result = regex.test(id);
				if (!result) {
					alert("사용할 수 없는 형식의 ID입니다")
					return false;
				}

			}

			if ($("#name").val() == "") {
				alert("이름을 입력해주세요.")
				return false;
			} else {
				let name = $("#name").val();
				let msg1 = $("#msg1");
				let regex = /^[가-힣]{2,5}$/g;
				let result = regex.test(name);
				if (!result) {
					alert("올바르지 않은 형식의 이름입니다.")
					return false;
				}

			}
			if ($("#pw,pwc").val() == "") {
				alert("PW를 입력 해주세요");
				return false;

			} else {
				let pw = $("#pw").val();
				let msg2 = $("#msg2");
				let regex = /(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}$/;
				let result = regex.test(pw);
				if (!result) {
					alert("올바르지않은 형식의 PW 입니다.")
					return false;
				}

			}

		});


</script>

</body>

</html>