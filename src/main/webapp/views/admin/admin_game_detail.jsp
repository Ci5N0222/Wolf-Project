<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- JSTL Core -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- JSTL Fmt -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
<link rel="stylesheet" href="/css/admin.css">
<script src="/js/admin.js"></script>

</head>
<body>
	<main class="admin-container">
        <%@ include file="/views/include/admin_side.jsp" %>
        
        <section class="admin-main-form">
        	<h1 class="admin-main-title">Game Info</h1>
        	<div class="admin-game-form">
        	
        		<c:choose>
        			<c:when test="${game.thumbnail != null}">
        			<div>
        			</div>
        				<!-- <img src="/${game.thumbnail}" width="500" alt="게임 섬네일 이미지"> -->
        				<img src="/images/default-game.png" width="500" alt="게임 섬네일 이미지">
        			</c:when>
        			<c:otherwise>
        				<img src="/images/default-game.png" width="500" alt="게임 섬네일 이미지">	
        			</c:otherwise>
        		</c:choose>
   				
   				<p>${game.title}</p>
   				
   				<div class="admin-game-discription">
   					${game.contents}
   				</div>
	        	<div class="admin-game-btn">
	        		<button onclick="adminGameEdit()">수정</button>
			        <button onclick="adminGameDelete(${game.seq})">삭제</button>
			        <button onclick="location.href='/game_list.admin'">목록</button>
	        	</div>
	        	<div class="admin-game-update-btn">
	        		<button onclick="amdinGameUpdate()">확인</button>
			        <button onclick="location.reload()">취소</button>
	        	</div>
		        
        	</div>

        </section>

    </main>
</body>
</html>