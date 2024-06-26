<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Wolf</title>
<link rel="icon" href="/images/favicon.png">
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
<link rel="stylesheet" href="/css/members.css">
<script src="/js/main.js"></script>


<style>
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

body {
   display: flex;
   justify-content: center;
   align-items: center;
   height: 100vh;
   margin: 0;
}

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
         	<div class="ranking-title">Ranking!</div>
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
      </div>
   </div>

   <!-- 스크립트 부분은 변경하지 않음 -->
   <script
      src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
   <script>
function updateUserStats(nickname, score, rank) {
    var userInfoElement = $("#userInfo");

    console.log("Received:", nickname, score, rank); // 변수 값 확인용 로그

    if (nickname === undefined || nickname === null) {
        userInfoElement.html('<span id="userNickname"></span>');
    } else if (score === 0 || rank === 0) {
        userInfoElement.html('<span id="userNickname">' + nickname + '</span> 님의 플레이한 기록이 없습니다.');
    } else {
        userInfoElement.html('<span id="userNickname">' + nickname + '</span> 님의 점수는 ' +
            '<span id="userScore">' + score + '</span> 점, 순위는 ' +
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
                } else if (i === 0) {
                    topRankHtml += '<div class="firstbox">' + boxHtml + '</div>';
                }else{
                	  topRankHtml += '<div class="thirdbox">' + boxHtml + '</div>';
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
                for (let i = 3; i < 10; i++) {
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
        if (user && user.nickname !== undefined && user.nickname !== null) {
            if (user.score === undefined || user.rank === undefined) {
                updateUserStats(user.nickname); // 스코어와 랭크가 없는 경우
            } else {
                updateUserStats(user.nickname, user.score, user.rank); // 스코어와 랭크가 있는 경우
            }
        } else {
            updateUserStats(undefined); // 사용자가 로그인하지 않은 경우
        }
    }).fail(function(xhr, status, error) {
        console.error("Error loading user info:", error);
        updateUserStats(undefined);
    });
}

// 페이지 로드 시 초기 랭킹 로드
$(document).ready(function() {
    loadRank(1); // 초기에 Game 1의 랭킹을 로드합니다.
});
</script>

</body>

</html>