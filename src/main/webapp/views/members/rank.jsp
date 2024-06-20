<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>게임 랭킹</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
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
        margin-bottom: 10px;
    }
</style>
</head>
<body>
<div class="container">
    <h1 class="mb-4">게임 랭킹</h1>

    <div class="btn-group mb-4">
        <button type="button" class="btn btn-primary mr-2" onclick="loadRank(1)">Game 1</button>
        <button type="button" class="btn btn-primary mr-2" onclick="loadRank(2)">Game 2</button>
        <button type="button" class="btn btn-primary mr-2" onclick="loadRank(3)">Game 3</button>
        <button type="button" class="btn btn-primary mr-2" onclick="loadRank(4)">Game 4</button>
        <button type="button" class="btn btn-primary" onclick="loadRank(5)">Game 5</button>
    </div>

    <div id="rankContainer">
        <!-- 데이터는 JavaScript를 통해 동적으로 업데이트됩니다 -->
    </div>
</div>


<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
function loadRank(gameSeq) {
    $.ajax({
        type: "GET",
        url: "/rankselect.score",
        data: { gameSeq: gameSeq },
        dataType: "json"
    }).done(function(response) {
        $("#rankContainer").empty();
        // 최대 20개의 항목만 표시
        let gameRankHtml = '<div class="game-rank">' +
                           '<div class="game-rank-header">게임 ' + gameSeq + ' 랭킹</div>';
        for (let i = 0; i < Math.min(response.length, 20); i++) {
            let rankDTO = response[i];
            let rankItemHtml = '<div class="rank-item">' +
                               '<div>순위: ' + rankDTO.rank + '</div>' +
                               '<div>닉네임: ' + rankDTO.nickname + '</div>' +
                               '<div>아바타: ' + rankDTO.avatar + '</div>' +
                               '<div>점수: ' + rankDTO.score + '</div>' +
                               '</div>';
            gameRankHtml += rankItemHtml;
        }
        gameRankHtml += '</div>';
        $("#rankContainer").append(gameRankHtml); 
    }).fail(function(xhr, status, error) {
        console.error("Error loading rank:", error);
    });
}

// 페이지 로드 시 초기 작업
$(document).ready(function() {
    // 예: 초기 랭킹 정보 로드 등
});
</script>

</body>
</html>
