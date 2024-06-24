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
        <%@ include file="/views/include/admin_side.jsp" %>
        
        <section class="admin-main-form">
        	<h1 class="admin-main-title">Game Info</h1>
        	<div class="admin-game-form">
        	
	        	<form action="/game_update.admin" method="post" id="admin_game_update" enctype="multipart/form-data">
		        	<div class="game-update-preview">
						<c:choose>
		        			<c:when test="${game.thumbnail != null}">
		        				<img id="imagePreview" src="/${game.thumbnail}" alt="게임 섬네일 이미지">
		        			</c:when>
		        			<c:otherwise>
		        				<img id="imagePreview" src="/images/default-game.png" alt="게임 섬네일 이미지">	
		        			</c:otherwise>
		        		</c:choose>
					</div>
					<div class="file-btn">
						<input type="file" id="admin_game_thumbnail" class="admin_game_update_thumbnail" name="game_image" accept="image/*">
						<button type="button" id="imagePreviewBtn" onclick="previewImageDelete(true, '${game.thumbnail}')" style="display: none;">X</button>
					</div>
					
					<select id="sevice_select" name="sevice_select">
				        <option value="0">서비스 정지</option>
				        <option value="1">서비스 진행중</option>
				    </select>
					
					<div class="admin-game-insert-title">
						<p>Title</p>
						<input type="text" id="game_title" name="game_title" value="${game.title}" readonly>
					</div>
					
					<div class="admin-game-insert-discription">
						<p>Discription</p>
						<div id="div_game_discription" contenteditable="false">${game.discription}</div>
					</div>
					
					<div class="admin-game-insert-contents">
						<p>Contents</p>
						<div id="div_game_contents" contenteditable="false">${game.contents}</div>
					</div>
					
					<input type="hidden" name="game_seq" value="${game.seq}">
					<input type="hidden" name="game_discription" id="game_discription">
					<input type="hidden" name="game_contents" id="game_contents">
					<input type="hidden" name="before_thumbnail_name" value="${beforeThumbnail}">
					<input type="hidden" name="before_thumbnail" id="before_thumbnail" value="${game.thumbnail}">
					
		        	<div class="admin-game-btn">
		        		<button type="button" onclick="adminGameEdit(${game.service_code})">수정</button>
				        <button type="button" onclick="adminGameDelete(${game.seq})">삭제</button>
				        <button type="button" onclick="location.href='/game_list.admin'">목록</button>
		        	</div>
		        	<div class="admin-game-update-btn">
		        		<button type="submit">확인</button>
				        <button type="button" onclick="location.reload()">취소</button>
		        	</div>
	        	</form>
        	
        	</div>
        </section>

    </main>
</body>
</html>