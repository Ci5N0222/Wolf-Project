<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Index</title>
<script src="https://code.jquery.com/jquery-3.7.1.js">
	
</script>
<style>
input {
	text-align: center;
}
</style>
</head>
<body>
	<c:choose>
		<c:when test="${WolfID != null }">

			<table border="1" align="center">
				<tr>
					<th colspan=4>${loginID }님환영합니다.</th>
				</tr>
				<tr>
					<td><button id="toboard">게시판으로</button>
					<td><button id="mypage">내정보</button></td>
					<td align="center"><button id="Logout">로그아웃</button></td>
					<td align="center"><button type="submit" id="memberout">회원탈퇴</button></td>
				</tr>
			</table>

			<script>
				$("#Logout").on("click", function() {
					location.href = "/logout.members";
				})
				$("#memberout").on("click", function() {
					location.href = "/memberout.members";
				})
				$("#mypage").on("click", function() {
					location.href = "/views/mypage/mypage.jsp";
				})
				$("#toboard").on("click",function(){
					location.href="/list.board";
				})
			</script>
		</c:when>
		<c:otherwise>


			<form action="/login.members" id="loginForm" method="post">
				<table border="1" align="center">
					<tr>
						<th>Login
					</tr>
					<tr>
						<td><input type="text" placeholder="input your id" name="id"></td>
					</tr>
					<tr>
						<td><input type="password" placeholder="input your pw"
							name="pw"></td>
					</tr>
					<tr>
						<td>
							<button type="submit" id="login">Login</button>
							<button type="button" id="signup">Sign up</button>
						</td>
					</tr>
				</table>
			</form>
		</c:otherwise>
	</c:choose>
	<script>
		$("#signup").on("click", function() {
			location.href = "/views/members/signup.jsp";
		})
	</script>
</body>
</html>