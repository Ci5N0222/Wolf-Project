<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!--  MDN에 나와있는 모바일 최적화된 사이트들이 포함하고 있다는 코드 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>First-Project</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<!-- 부트스트랩 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<!-- 아이콘 -->
<script src="https://kit.fontawesome.com/1ee4acc8d4.js"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>

<!-- Project local -->
<link rel="stylesheet" href="/css/gameDetail.css">
</head>
<body>
	<!-- container -->
	<div class="container-fluid d-flex flex-column">
		<!-- nav -->
		<div class="container text-center flex-grow-1 d-flex flex-column">
			<img src="/images/bg1.png" alt="" class="img_bg"> <img
				src="/images/bg3.png" alt="" class="img_bg bgs"> <img
				src="/images/bg3.png" alt="" class="img_bg bgs"> <img
				src="/images/bg3.png" alt="" class="img_bg bgs"> <img
				src="/images/bg3.png" alt="" class="img_bg bgs"> <img
				src="/images/bg3.png" alt="" class="img_bg bgs"> <img
				src="/images/bg3.png" alt="" class="img_bg bgs">


			<!-- nav -->
			<%@ include file="/views/include/header.jsp"%>

			<!-- main -->
			<main class="main container flex-grow-1">
				<div class="datail">
					<div>
						<div>
							<c:choose>
								<c:when test="${dto.thumbnail != 'none'}">
									<img src="/${dto.thumbnail}">
								</c:when>

								<c:otherwise>
									<img src="/images/default-game.png" alt="기본 이미지">
								</c:otherwise>
							</c:choose>
						</div>
						<form action='/gameview.game' method='post'>
							<div>
								<input type='hidden' name='seq' value="${dto.seq}" />
								<button class="btn btn-outline-warning">게임 시작</button>
							</div>
						</form>
					</div>
					<div>
						<div>${dto.contents}</div>
					</div>
				</div>
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