<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- JSTL Core -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>First-Project</title>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
 
<!-- icon -->
<script src="https://kit.fontawesome.com/1ee4acc8d4.js" crossorigin="anonymous"></script>

<!-- Project local -->
<link rel="stylesheet" href="css/style.css">
<script src="js/main.js"></script>

</head>
<body>
	<h2>관리자 로그인</h2>
	<form action="/login.admin" method="post">
		<input type="text" name="admin_id" placeholder="ID를 입력하세요" />
		<input type="password" name="admin_pw" placeholder="Password를 입력하세요" />
		<button type="submit">로그인</button>
	</form>
	
</body>
</html>