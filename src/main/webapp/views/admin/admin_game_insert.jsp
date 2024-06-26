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
<title>Wolf-Admin</title>
<link rel="icon" href="/images/favicon.png">

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
        	<h1 class="admin-main-title">Game Insert</h1>
			<div class="admin-game-form">
				<form action="/game_insert.admin" method="post" id="admin_game_insert" enctype="multipart/form-data">
					<div class="preview">
						<img id="imagePreview" src="" alt="이미지 미리보기" width="300" style="display: none;">
					</div>
					<div class="file-btn">
						<input type="file" id="admin_game_thumbnail" name="game_image" accept="image/*">
						<button type="button" id="imagePreviewBtn" onclick="previewImageDelete(false, null)" style="display: none;">X</button>
					</div>
					
					<div class="admin-game-insert-title">
						<p>게임명</p>
						<input type="text" id="game_title" name="game_title">
					</div>
					
					<div class="admin-game-insert-discription">
						<p>요약 설명</p>
						<div id="div_game_discription" contenteditable="true"></div>
					</div>
					
					<div class="admin-game-insert-contents">
						<p>상세 설명</p>
						<div id="div_game_contents" contenteditable="true"></div>
					</div>
					<div class="admin_game_insert_btn">
						<button type="submit">작성</button>
						<button type="button" onclick="location.href='/game_list.admin'">취소</button>
					</div>
					<input type="hidden" id="game_discription" name="game_discription">
					<input type="hidden" id="game_contents" name="game_contents">
				</form>
			</div>
	        
        </section>

    </main>
</body>
</html>