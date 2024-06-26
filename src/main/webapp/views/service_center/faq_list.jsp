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
					F A Q
				</div>
			</div>

			<!-- main -->
			<main class="service-main">
				<nav class="service-navi">
					<p onclick="location.href='/faq_list.service'">F A Q</p>
					<p onclick="location.reload()">Q & A</p>
				</nav>

				<div class="service-qna-list">
					<c:if test="${faqList.size() > 0}">
						<table>
							<tr>
								<th>NO.</th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
							</tr>
				 			<c:forEach var="faqList" items="${faqList}">
					 			<tr>
					 				<td>${faqList.seq}</td>
					 				<td><a href="/detail.board?seq=${faqList.seq}&target=&keyword=&board_code=4">${faqList.title}</a></td>
					 				<td>${faqList.nickname}</td>
					 				<td><fmt:formatDate value="${faqList.write_date}" pattern="yyyy.MM.dd"/></td>
					 			</tr>
				 			</c:forEach>
						</table>
					</c:if>
					<div class="page-navigation"></div>
					<script>
						/** 페이징 네이게이터 **/
						pagenation(${cpage}, ${recode_total_count}, ${recode_count_per_page}, ${navi_count_per_page}, "/faq_list.service");
					</script>
				</div>
			</main>

			<main class="M_main"></main>
		</div>

		<div class="sun"></div>
		<!-- mode -->
		<div id="mode">
			<i class="fa-regular fa-lightbulb" style="display: none;"></i> <i
				class="fa-solid fa-lightbulb"></i>
		</div>
	</div>
</body>
</html>