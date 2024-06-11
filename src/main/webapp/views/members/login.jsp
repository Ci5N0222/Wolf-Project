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

	<script>
		$("#signup").on("click", function() {
			location.href = "/views/members/signup.jsp";
		})
	</script>
</body>
</html>