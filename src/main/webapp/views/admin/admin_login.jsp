<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- JSTL Core -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Wolf</title>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
 
<!-- icon -->
<script src="https://kit.fontawesome.com/1ee4acc8d4.js" crossorigin="anonymous"></script>

<!-- Project local -->
<link rel="stylesheet" href="/css/admin.css">
<script src="/js/admin.js"></script>

</head>
<body>
    <main class="admin-container">
        <div class="admin-login-form">
            <h2>관리자 로그인</h2>
            <input type="text" name="admin_id" id="admin_id" placeholder=" ID를 입력하세요" />
            <input type="password" name="admin_pw" id="admin_pw" placeholder=" Password를 입력하세요" />
            <button onclick="adminLogin()">로그인</button>
        </div>
    </main>
	
	
	<script>
		function adminLogin(){
			if($("#admin_id").val() === "") {
				alert("ID를 입력하세요");
				return false;
			}
			if($("#admin_pw").val() === ""){
				alert("Password를 입력하세요");
				return false;
			}
			
			$.ajax({
				url: "/login.admin",
				method: "post",
				data: {
					admin_id : $("#admin_id").val(),
					admin_pw : $("#admin_pw").val()
				}
			})
			.done(function(res){
				if(res === "ok"){
					location.href = "/main.admin";
				} else {
					alert("비밀번호와 아이디를 확인해주세요.");
				}
			});
		}

	</script>
	
</body>
</html>