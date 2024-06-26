<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- JSTL Core -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>Wolf</title>
<link rel="icon" href="/images/favicon.png">
<!-- 부트스트랩 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous" />

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
<link rel="stylesheet" href="/css/style.css">
<link rel="stylesheet" href="/css/mypage.css">

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

			<!-- main -->
			<main class="mypage-myGame-container">
				<div class="mypage-myGame-title">게임플레이 정보</div>
				<div class="aside-section-form" style="display: flex">
					<%@ include file="/views/include/mypage_side.jsp"%>

					<section class="mypage-myGame-form">
						<div class="mypage-myGameList">
							<!-- <c:if test="${result == null}">
			                  <div style="border: 1px solid aqua">
			                    플레이 한 게임이 없습니다.
			                  </div>
			                </c:if> -->
							<c:if test="${result != null}">
								<c:forEach var="i" items="${result}">
									<div class="mypage-myGameList-info">
										<div class="mypage-myGameList-img">
											<img src="${i.thumbnail}" style="width: 100%; height: 100%; border-radius: 30px;">
										</div>
										<div>
											<div class="mypage-myGameList-title">
												<p class="title_txt">${i.title}</p>
											</div>
											<div class="mypage-myGameList-score">
												<c:choose>
													<c:when test="${i.score != 0}">
														<p>최고점수 :
															<span class="score_txt">${i.score}</span> 점
                                						</p>
													</c:when>
													<c:otherwise>
						                               	 플레이한 기록이 없습니다.
						                              </c:otherwise>
												</c:choose>
											</div>
										</div>
									</div>
								</c:forEach>
							</c:if>
						</div>
					</section>
				</div>
			</main>
		</div>

		<div class="sun"></div>
		<!-- mode -->
		<div id="mode">
			<i class="fa-regular fa-lightbulb" style="display: none"></i> <i
				class="fa-solid fa-lightbulb"></i>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>

</body>
</html>
