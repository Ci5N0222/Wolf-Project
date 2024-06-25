<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Game</title>
	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
	<!-- phaser3 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/phaser/3.80.1/phaser.min.js"></script>
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
	<link rel="stylesheet" href="/css/score.css">
	<script src="/js/game.js"></script>

	<c:choose>
		<c:when test="${seq == 1 }">
			<script src="/phaser3_game/among_run/js/AmongStart.js"></script>
			<script src="/phaser3_game/among_run/js/AmongRun.js"></script>
			<script src="/phaser3_game/among_run/js/AmongBent.js"></script>
			<script src="/phaser3_game/among_run/js/AmongEnd.js"></script>
		</c:when>
		<c:when test="${seq == 2 }">
			<script src="/phaser3_game/FlyingBird/js/Exam03.js"></script>
			<script src="/phaser3_game/FlyingBird/js/GameOver.js"></script>
		</c:when>
		<c:when test="${seq == 4 }">
			<script src="/phaser3_game/Roadkill/js/GameStart.js"></script>
			<script src="/phaser3_game/Roadkill/js/Main.js"></script>
			<script src="/phaser3_game/Roadkill/js/GameOver.js"></script>
		</c:when>
			<c:when test="${seq == 3 }">
			<script src="/phaser3_game/MashimaroJump/js/Project.js"></script>
			<script src="/phaser3_game/MashimaroJump/js/GameOver.js"></script>
		</c:when>
		<c:when test="${seq == 5 }">
			<script src="/phaser3_game/spaceflight/js/StartScene.js"></script>
			<script src="/phaser3_game/spaceflight/js/Game.js"></script>
			<script src="/phaser3_game/spaceflight/js/GameOver.js"></script>
		</c:when>
	</c:choose>
	

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
			<main class="main">
				<div>
					<div class="game" id="game_play_form"></div>
					<div class="ranking">
						<div>ranking</div>
						<div>
							<div>
								<div>
									<img src="/images/wolf-1.gif">
								</div>
								<div>${topRank[0].nickname}</div>
								<div>${topRank[0].score}</div>
							</div>
							<div>
								<div>
									<img src="/images/wolf-2.gif">
								</div>
								<div>${topRank[1].nickname}</div>
								<div>${topRank[1].score}</div>
							</div>
							<div>
								<div>
									<img src="/images/wolfLogo.png">
								</div>
								<div>${topRank[2].nickname}</div>
								<div>${topRank[2].score}</div>
							</div>
							<br/><br/>
							<div>
								<input type="hidden" id="game_seq" value="${seq}">
								<p id="myNickname"> ${WolfNickname}</p>
								<p id="myGameScore">${myScore}</p>
							</div>
						</div>
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
	<script>
		gameCanvars(${seq});
	</script>
</body>
</html>