<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게임 랭킹</title>
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

<script src="https://kit.fontawesome.com/1ee4acc8d4.js" crossorigin="anonymous"></script>

<script src="https://code.jquery.com/jquery-3.7.1.js">
	
</script>
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Luckiest+Guy&family=Noto+Sans+KR:wght@100..900&display=swap')
	;

:root { -
	-bg-light: #ffd449; -
	-bg-dark: #14213D; -
	-bg-transparent: transparent; -
	-color-white: #eeeeee; -
	-color-black: #14213D; -
	-bg-nav: #f9a620; -
	-color-nav-icon: #14213D; -
	-color-nav-bg: #f9a620;
	font-size: 16px;
}

html, body {
	height: 100%;
	margin: 0;
	background-color: var(- -bg-dark);
	color: var(- -bg-black);
	color: var(- -color-black);
	overflow: hidden;
	/* 폰트 */
	font-family: "Noto Sans KR", sans-serif;
	font-family: "Luckiest Guy", cursive;
}

body.light {
	background-color: var(- -bg-light);
	color: var(- -bg-black);
}
/* 하단 원 */
.sun {
	position: absolute;
	width: 120%;
	height: 100%;
	background-color: var(- -color-nav-bg);
	box-shadow: 5px -5px 10px var(- -bg-light);
	border-radius: 50%;
	top: 40%;
	left: 50%;
	transform: translateX(-50%);
}
/* 모드 변경시 부드럽게 넘어가는 효과 */
.sun, .navi {
	transition: background-color 0.5s ease, box-shadow 0.5s ease;
}
/* img */
.img_bg {
	position: absolute;
	top: -60%;
	left: 0;
	width: 100%;
	object-fit: cover;
}

.bgs {
	animation: bg 1s ease-in Infinite Alternate;
	transition: all ease-in 0.2s;
	width: 50px;
}

.bgs:nth-child(1) {
	top: 15%;
	left: 80%;
}

.bgs:nth-child(2) {
	top: 20%;
	left: 80%;
	width: 40px;
}

.bgs:nth-child(3) {
	top: 15%;
	left: 20%;
}

.bgs:nth-child(4) {
	top: 27%;
	left: 70%;
	width: 20px;
}

.bgs:nth-child(5) {
	top: 12%;
	left: 50%;
}

.bgs:nth-child(6) {
	top: 12%;
	left: 80%;
	width: 20px;
}

@
keyframes bg { 0% {
	opacity: 1;
}

100




%
{
opacity




:




0


;
}
}
.container-fluid, .container, .main {
	height: 100%;
}
/* 메뉴 */
.navi {
	border: 1px solid white;
	z-index: 5;
	height: 10%;
	display: flex;
	align-items: center;
	background-color: var(- -bg-nav);
	padding: 0 3%;
	font-size: 20px;
	color: var(- -color-white);
	text-shadow: 1px 1px 1px gray;
	letter-spacing: 1px;
	border-radius: 40px 80px/80px 40px;
}

.navi i {
	font-size: 22px;
}

.navi>div {
	margin-top: 0;
}

.navi>div:nth-child(2) #wolfLogo {
	width: 100px;
	height: 100px;
}
/* 로고 */
.navi #wolfLogo>img {
	object-fit: cover;
	width: 100%;
	height: 100%;
}
/* 메뉴 버튼 */
.naviBtn {
	cursor: pointer;
	transition: all 0.3s ease-in-out;
}

.naviBtn:hover {
	opacity: 0.5;
}
/* -- main과 동일 -- */
/* 라이트 다크 mode */
#mode {
	cursor: pointer;
	position: absolute;
	bottom: 5%;
	right: 5%;
	background-color: var(- -bg-dark);
	width: 50px;
	height: 50px;
	display: flex;
	align-items: center;
	justify-content: center;
	border-radius: 50%;
	transition: all ease-in 0.2s;
	animation: ball 1s ease-in Infinite Alternate;
	border: double 1px rgba(255, 255, 255, 0.46);
}

@
keyframes ball { 0% {
	bottom: 5%;
}

95




%
{
width




:




50px


;
}
to {
	bottom: 8%;
	width: 50px;
	height: 60px
}

}
/* 모드 전환 버튼 호버 시 투명도 조정 */
#mode:hover {
	opacity: 0.8;
}

/* 모드 전환 버튼 아이콘 스타일 */
#mode i {
	font-size: 30px;
	color: var(—color-nav-bg);
}

html, body {
	height: 100%;
	margin: 0;
	background-color: var(- -bg-dark);
	color: var(- -bg-black);
	color: var(- -color-black);
	overflow: hidden;
	/* 폰트 */
	font-family: "Noto Sans KR", sans-serif;
	font-family: "Luckiest Guy", cursive;
}

.overlay {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.7);
	z-index: -1;
}

body {
	
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	margin: 0;
}

        .rankcontainer {
        	width:100%;
            max-width: 800px;
            margin: auto;
            z-index: 1;
        }
.btn-group>.btn-group>.btn, .btn-group>.btn.dropdown-toggle-split:first-child, .btn-group>.btn:not(:last-child):not(.dropdown-toggle) {
	border-radius:20px;
}
.btn-group>.btn-group:not(:first-child)>.btn, .btn-group>.btn:nth-child(n+3), .btn-group>:not(.btn-check)+.btn {
border-radius:20px;}
    
        .btn {
    margin: 20px;
    padding: 20px;
    background-color: #f9a620;
    border: #f9a620;
    border-radius: 5px; /* 모든 모서리에 적용될 둥근 모서리 설정 */
}

        .game-rank {
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 20px;
        }

        .game-rank-header {
            background-color: #007bff;
            color: #fff;
            padding: 10px;
            text-align: center;
            border-radius: 5px 5px 0 0;
        }

        .rank-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border: 1px solid black;
            padding: 10px;
            margin-bottom: 10px;
        }

        .rank-item > div {
            flex: 1;
            text-align: center;
        }

        .rank-item .avatar img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
        }

        .user-info {
        	color:white;
            font-size: 14px;
            text-align: right;
            margin-bottom: 10px;
        }

        /* 추가된 스타일 */
        .toprank {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .toprank .firstbox,
        .toprank .secondbox,
        .toprank .thirdbox {
            width: calc(33.33% - 10px);
            border: 1px solid black;
            padding: 10px;
            text-align: center;
            border-radius: 5px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .toprank .firstbox {
      		  order: 2; 
            background-size: cover;
            background-position: center;
        }

        .toprank .secondbox {
      		   order: 1;
            background-size: cover;
            background-position: center;
        }

        .toprank .thirdbox {
      		   order: 3;
            background-size: cover;
            background-position: center;
        }

        .toprank .box-title,
        .toprank .box-score {
            margin-bottom: 10px;
        }

        .lowrank {
        
            border: 1px solid black;
            padding: 10px;
            background-color: #14213D;
          color: #f9a620;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
        }

        .ranklist {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }

        .ranklist .lownum,
        .ranklist .lowname,
        .ranklist .lowscore {
            flex: 1;
            text-align: center;
            padding: 5px;
        }

        .ranklist .lowimg {
            flex: 1;
            text-align: center;
        }

        .ranklist .lowimg img {
            max-width: 50px;
            max-height: 50px;
            border-radius: 50%;
        }
        /* 모바일 메뉴 */ @media all and (max-width: 767px) { 
	.wolf {
		display: block;
	}
	
	.navi {
		display: none;
	}
	
	.m_navi {
		display: block;
	}
	
	.container-fluid {
		padding: 0;
	}
	
	.container {
		padding: 0;
	}
	
	/* 햄버거 */
	.navbar {
		box-shadow: 0px 1px 5px white;
	}
	
	.navbar div {
		width: 50px;
		width: 50px;
		height: 50px;
		line-height: 50px;
		margin: 0 2%;
	} }
.wolf {display: none;}


 @media all and (min-width:768px) and (max-width: 1023px) {
	.wolf {
		display: block;
	}
	
	#wolfLogo {
		display: none;
	}}
    </style>
</head>

<body>
	<div class="container-fluid d-flex flex-column">
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
		
		
             <div class="rankcontainer">
                <!-- 사용자 정보 표시 -->
                <div id="userInfo" class="user-info">
                    <!-- 사용자 정보 업데이트 스크립트에서 동적으로 업데이트 -->
                </div>

        <!-- 게임 선택 버튼 그룹 -->
        <div class="btn-group mb-4">
            <button type="button" class="btn btn-primary mr-2" onclick="loadRank(1)">Among_Run</button>
            <button type="button" class="btn btn-primary mr-2" onclick="loadRank(2)">FlyingBird</button>
            <button type="button" class="btn btn-primary mr-2" onclick="loadRank(3)">MashimaroJump</button>
            <button type="button" class="btn btn-primary mr-2" onclick="loadRank(4)">RoadKill</button>
            <button type="button" class="btn btn-primary" onclick="loadRank(5)">SpaceFlight</button>
        </div>

        <!-- 상위 랭크 박스 -->
        <div class="toprank" id="topRankSection">
            <!-- 동적으로 업데이트될 부분 -->
        </div>

        <!-- 하위 랭킹 리스트 -->
        <div class="lowrank" id="lowRankSection">
            <!-- 동적으로 업데이트될 부분 -->
        </div>
        
    </div>
    			<div class="sun"></div>
			<!-- mode -->
			<div id="mode">
				<i class="fa-regular fa-lightbulb" style="display: none;"></i> <i
					class="fa-solid fa-lightbulb"></i>
			</div>

    <!-- 스크립트 부분은 변경하지 않음 -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>




function updateUserStats(nickname, score, rank) {
    var userInfoElement = $("#userInfo");

        
    if (nickname === 0 && score === 0 && rank === 0) {
        // 로그인은 되었지만 플레이 기록이 없는 경우
        userInfoElement.html('<span id="userNickname">플레이한 기록이 없습니다.</span>');
    }else{
        // 로그인되었고 플레이 기록이 있는 경우
        userInfoElement.html('<span id="userNickname">' + nickname + '</span> 님의 점수는 ' +
            '<span id="userScore">' + score + '</span> 점 순위는 ' +
            '<span id="userRank">' + rank + '</span> 등 입니다.');
    }
}

// 랭킹 로드 함수
function loadRank(gameSeq) {
    $.ajax({
        type: "GET",
        url: "/rankselect.score",
        data: { gameSeq: gameSeq },
        dataType: "json"
    }).done(function(response) {
        // 상위 랭크 박스 업데이트
        $("#topRankSection").empty();
        let topRankHtml = '';
        for (let i = 0; i < 3; i++) {
            if (i < response.length) {
                let rankDTO = response[i];
                let boxHtml = '<div class="box-title"> ' + rankDTO.nickname + '</div>' +
                    '<div class="box-score"> ' + rankDTO.score + '</div>';
                if (i === 1) {
                    topRankHtml += '<div class="secondbox">' + boxHtml + '</div>';
                } else if (i === 0 || i === 2) {
                    topRankHtml += '<div class="firstbox">' + boxHtml + '</div>';
                }
            } else {
                // 게임 기록이 없는 경우 처리
                if (i === 1) {
                    topRankHtml += '<div class="secondbox"></div>';
                } else if (i === 0 || i === 2) {
                    topRankHtml += '<div class="firstbox"></div>';
                }
            }
        }
        $("#topRankSection").append(topRankHtml);

        // 하위 랭킹 리스트 업데이트
        $("#lowRankSection").empty();
        let lowRankHtml = '';
        for (let i = 3; i < 10; i++) { // 항상 10개의 항목을 표시하도록 설정
            if (i < response.length) {
                let rankDTO = response[i];
                let rankItemHtml = '<div class="ranklist">' +
                    '<div class="lownum">' + rankDTO.rank + '</div>' +
                    '<div class="lowimg"><img src="' + rankDTO.avatar + '" alt="아바타"></div>' +
                    '<div class="lowname">' + rankDTO.nickname + '</div>' +
                    '<div class="lowscore">' + rankDTO.score + '</div>' +
                    '</div>';
                lowRankHtml += rankItemHtml;
            } else {
                // 게임 기록이 없는 경우 빈 데이터로 처리
                let emptyRankItemHtml = '<div class="ranklist">' +
                    '<div class="lownum"></div>' +
                    '<div class="lowimg"></div>' +
                    '<div class="lowname">기록 없음</div>' +
                    '<div class="lowscore">0</div>' +
                    '</div>';
                lowRankHtml += emptyRankItemHtml;
            }
        }
        $("#lowRankSection").append(lowRankHtml);

        // 랭킹을 로드한 후 사용자 정보 업데이트
        updateUserStatsFromDatabase(gameSeq);
    }).fail(function(xhr, status, error) {
        console.error("Error loading rank:", error);
    });
}

// 데이터베이스에서 사용자 정보 업데이트
function updateUserStatsFromDatabase(gameSeq) {
    $.ajax({
        type: "GET",
        url: "/userinfo.score",
        data: { gameSeq: gameSeq },
        dataType: "json"
    }).done(function(user) {
    	if (user) {
    	    updateUserStats(user.nickname, user.score, user.rank);
    	} else {
    	    updateUserStats(0, 0, 0);
    	}
    }).fail(function(xhr, status, error) {
        console.error("Error loading user info:", error);
    });
}

// 페이지 로드 시 초기 랭킹 로드
$(document).ready(function() {
    loadRank(1); // 초기에 Game 1의 랭킹을 로드합니다.
});
</script>
    <script src="/js/main.js"></script>
</body>

</html>
