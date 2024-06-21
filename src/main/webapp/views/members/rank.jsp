<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게임 랭킹</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            color: #333;
            margin: 20px;
        }

        .container {
            max-width: 800px;
            margin: auto;
        }

        .btn-group {
            margin-bottom: 20px;
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
            width: 50px;
            height: 50px;
            border-radius: 50%;
        }

        .user-info {
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
            background-color: #fff;
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
    </style>
</head>

<body>
    <div class="container">
        <h1 class="mb-4">게임 랭킹</h1>

        <!-- 사용자 정보 표시 -->
        <div id="userInfo" class="user-info">
            닉네임: <span id="userNickname"></span> |
            점수: <span id="userScore"></span> |
            순위: <span id="userRank"></span>
        </div>

        <!-- 게임 선택 버튼 그룹 -->
        <div class="btn-group mb-4">
            <button type="button" class="btn btn-primary mr-2" onclick="loadRank(1)">Game 1</button>
            <button type="button" class="btn btn-primary mr-2" onclick="loadRank(2)">Game 2</button>
            <button type="button" class="btn btn-primary mr-2" onclick="loadRank(3)">Game 3</button>
            <button type="button" class="btn btn-primary mr-2" onclick="loadRank(4)">Game 4</button>
            <button type="button" class="btn btn-primary" onclick="loadRank(5)">Game 5</button>
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

    <!-- 스크립트 부분은 변경하지 않음 -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        // 사용자 정보 업데이트 함수
        function updateUserStats(nickname, score, rank) {
            $("#userNickname").text(nickname);
            $("#userScore").text(score);
            $("#userRank").text(rank);
        }

        // 랭킹 불러오기 함수
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
                for (let i = 0; i < Math.min(response.length, 3); i++) {
                    let rankDTO = response[i];
                    let boxHtml = '<div class="box-title"> ' + rankDTO.nickname + '</div>' +
                        '<div class="box-score"> ' + rankDTO.score + '</div>';
                    if (i === 1) {
                        topRankHtml += '<div class="secondbox">' + boxHtml + '</div>';
                    } else if (i === 0) {
                        topRankHtml += '<div class="firstbox">' + boxHtml + '</div>';
                    } else if (i === 2) {
                        topRankHtml += '<div class="thirdbox">' + boxHtml + '</div>';
                    }
                }
                $("#topRankSection").append(topRankHtml);

                // 하위 랭킹 리스트 업데이트
                $("#lowRankSection").empty();
                let lowRankHtml = '';
                for (let i = 3; i < Math.min(response.length, 20); i++) {
                    let rankDTO = response[i];
                    let rankItemHtml = '<div class="ranklist">' +
                        '<div class="lownum">' + rankDTO.rank + '</div>' +
                        '<div class="lowimg"><img src="' + rankDTO.avatar + '" alt="아바타"></div>' +
                        '<div class="lowname">' + rankDTO.nickname + '</div>' +
                        '<div class="lowscore">' + rankDTO.score + '</div>' +
                        '</div>';
                    lowRankHtml += rankItemHtml;
                }
                $("#lowRankSection").append(lowRankHtml);

                // 랭킹을 로드한 후 사용자 정보 업데이트
                updateUserStatsFromDatabase(gameSeq);
            }).fail(function(xhr, status, error) {
                console.error("Error loading rank:", error);
            });
        }

        // 데이터베이스에서 사용자 정보를 가져오는 함수
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
                    updateUserStats("기록 없음", 0, "N/A");
                }
            }).fail(function(xhr, status, error) {
                console.error("Error loading user info:", error);
            });
        }

        // 페이지 로드 시 초기 데이터 설정
        $(document).ready(function() {
            loadRank(1); // 초기에 Game 1의 랭킹을 로드합니다.
        });
    </script>
</body>

</html>
