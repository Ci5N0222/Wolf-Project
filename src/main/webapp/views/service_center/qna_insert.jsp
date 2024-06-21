<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- JSTL Core -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!--  MDN에 나와있는 모바일 최적화된 사이트들이 포함하고 있다는 코드 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>First-Project</title>
<!-- 부트스트랩 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>

<!-- tinymce -->
<script src="https://cdn.tiny.cloud/1/9bewfouem96jjnfvuu236yinb3kp53xruh2gkkz3pkfnkw6c/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

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
<link rel="stylesheet" href="/css/service.css">
<script src="/js/service.js"></script>
<script src="/js/tinymce.js"></script>

</head>
<body>
	<!-- container -->
	<div class="container-fluid d-flex flex-column">
		<div class="container text-center flex-grow-1 d-flex flex-column">
			<img src="/images/bg1.png" alt="" class="img_bg"> 
			<img src="/images/bg3.png" alt="" class="img_bg bgs"> 
			<img
				src="/images/bg3.png" alt="" class="img_bg bgs"> 
				<img src="/images/bg3.png" alt="" class="img_bg bgs"> 
				<img src="/images/bg3.png" alt="" class="img_bg bgs"> 
				<img src="/images/bg3.png" alt="" class="img_bg bgs"> 
				<img src="/images/bg3.png" alt="" class="img_bg bgs">
			<!-- nav -->
			<%@ include file="/views/include/header.jsp"%>

			<!-- 컨텐츠 -->
			<div id="serivce-title"
				class="d-flex align-items-center justify-content-center my-3">
				<div>
					문의 작성하기
				</div>
			</div>

			<!-- main -->
			<main class="service-main">
				<form action="/qna_insert.service" id="fileform" method="post" enctype="multipart/form-data">
					<div class="service-qna-insert">
						<div class="qna-insert-title">
							<input type="text" name="title" placeholder="글 제목을 입력하세요">
						</div>
						<div id="contents"></div>
			            <div id="files"></div>
			            <div class="qna-insert-btn">
			            	<button class="btn">작성완료</button>        
		                    <button type="button" onclick="location.href='/qna_list.service'">취소</button>
			            </div>
			            <input type="hidden" name="board_code" value="${board_code}">
					</div>
				</form>
				
			</main>
			
			<main class="M_main">
				
			</main>
		</div>

		<div class="sun"></div>
		<!-- mode -->
		<div id="mode">
			<i class="fa-regular fa-lightbulb" style="display: none;"></i> <i
				class="fa-solid fa-lightbulb"></i>
		</div>
	</div>
	<script src="/js/main.js"></script>
</body>
</html>