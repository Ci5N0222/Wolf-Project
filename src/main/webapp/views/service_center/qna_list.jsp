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
					My "Q&A" List
				</div>
			</div>

			<!-- main -->
			<main class="service-main">
				<nav class="service-navi">
					<p onclick="location.href='#'">F A Q</p>
					<p onclick="location.href='#'">Q & A</p>
				</nav>
				<section class="servie-content-box">
					<div class="service-qna-res-seelct">
						<select id="qna-res-seelct">
							<option value="0">전체 문의</option>
					        <option value="N">답변 대기중</option>
					        <option value="Y">댑변 완료</option>
						</select>
					</div>
				</section>
				
				<div class="service-qna-list">
					<c:if test="${qnaList.size() > 0}">
						<table>
							<tr>
								<th>NO.</th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>상태</th>
							</tr>
				 			<c:forEach var="qnaList" items="${qnaList}">
					 			<tr>
					 				<td>${qnaList.seq}</td>
					 				<td><a href="#">${qnaList.title}</a></td>
					 				<td>${qnaList.nickname}</td>
					 				<td><fmt:formatDate value="${qnaList.write_date}" pattern="yyyy.MM.dd"/></td>
					 				<c:choose>
					 					<c:when test="${qnaList.res_ok eq 'Y'}">
					 						<td>완료</td>
					 					</c:when>
					 					<c:otherwise>
					 						<td>대기중</td>
					 					</c:otherwise>
					 				</c:choose>
					 			</tr>
				 			</c:forEach>
						</table>
					</c:if>
					
				</div>
				
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