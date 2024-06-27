<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- JSTL Core -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!--  MDN에 나와있는 모바일 최적화된 사이트들이 포함하고 있다는 코드 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Wolf</title>
<link rel="icon" href="/images/favicon.png">
<!-- 부트스트랩 -->
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

<!-- Project local -->
<link rel="stylesheet" href="/css/style.css">
<link rel="stylesheet" href="/css/service.css">
<script src="/js/main.js"></script>

</head>
<body>
	<!-- container -->
	<div class="container-fluid d-flex flex-column">
		<div class="container text-center flex-grow-1 d-flex flex-column">
			<img src="/images/bg1.png" alt="" class="img_bg"> 
			<img src="/images/bg3.png" alt="" class="img_bg bgs"> 
			<img src="/images/bg3.png" alt="" class="img_bg bgs"> 
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
					My "QnA" List
				</div>
			</div>

			<!-- board contents -->
			<main class="service-main">
				<form class="service-contents" action="" method="post">
					<div class="service-contents-title">
						<input type="text" id="qna_title" name="title" value="제목" readonly>
					</div>
					<div class="service-contents-board">
						<div class="service-contents-info-box">
							<div class="service-contents-info-box-col-2">작성자 : test</div>
							<div class="service-contents-info-box-col-1"> 조회수 : 5 </div>
							<div class="service-contents-info-box-col-2">작성일 : 2024-06-26 </div>
						</div>
						<div class="service-contents-form">
							내용
						</div>
						<div class="service-contents-edit">
							edit 기능
						</div>
						<div class="service-contents-board-btn">
							<button type="button" id="qna_list" onclick="location.href='/qna_list.service'">목록으로</button>
							<button type="button" id="qna_edit" onclick="qnaEditForm()">수정하기</button>
							<button type="button" id="qna_delete" onclick="qnaDelete()">삭제하기</button>
							<button id="qna_ok">확인</button>
							<button type="button" id="qna_cancel" onclick="location.reload()">취소</button>
						</div>
					</div>
				</form>
			</main>
			
			<!-- board reply -->
			<main class="service-main">
				<!-- board reply insert -->
				<section class="service-reply">
					<div class="service-reply-title">
						댓글작성
					</div>
					<div class="service-reply-info">
						<div class="service-reply-writer-avater">
							이미지
						</div>
						<div class="service-reply-writer">
							작성자(ID...)
						</div>
					</div>
					<div class="service-reply-contents">
						<div class="service-reply-contents-board">
							내용
						</div>
						<div class="service-reply-contents-btn">
							<button>작성하기</button>
						</div>
					</div>
				</section>
			</main>
			
			<!-- board reply -->
			<main class="service-main">
				<section class="service-reply-list">
					<div class="service-reply-info">
						<div class="service-reply-writer-avater">
							이미지
						</div>
						<div class="service-reply-writer">
							작성자(ID...)
						</div>
						<div class="service-reply-write-date">
							(2024-06-26)
						</div>
						<div class="service-reply-info-btn">
							<button>수정</button>
							<button>삭제</button>
						</div>
					</div>
					<div class="service-reply-contents">
						<div class="service-reply-list-contents">
							내용
						</div>
					</div>
				</section>
				
				<section class="service-reply-list">
					<div class="service-reply-info">
						<div class="service-reply-writer-avater">
							이미지
						</div>
						<div class="service-reply-writer">
							작성자(ID...)
						</div>
						<div class="service-reply-write-date">
							(2024-06-26)
						</div>
					</div>
					<div class="service-reply-contents">
						<div class="service-reply-list-contents">
							내용
						</div>
					</div>
				</section>
				
				<section class="service-reply-list">
					<div class="service-reply-info">
						<div class="service-reply-writer-avater">
							이미지
						</div>
						<div class="service-reply-writer">
							작성자(ID...)
						</div>
						<div class="service-reply-write-date">
							(2024-06-26)
						</div>
					</div>
					<div class="service-reply-contents">
						<div class="service-reply-list-contents">
							내용
						</div>
					</div>
				</section>
			</main>
			
			<main class="M_main">
				
			</main>
		</div>

		<div class="sun"></div>
		<!-- mode -->
		<div id="mode">
			<i class="fa-regular fa-lightbulb" style="display: none;"></i> 
			<i class="fa-solid fa-lightbulb"></i>
		</div>
	</div>
</body>
</html>