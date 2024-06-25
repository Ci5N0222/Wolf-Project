$(() => {
	

});

const gameConfig = (seq) => {
	let config = {};
	switch(seq){
		case 1: // 시온
			config = {
				width: 700,
				height: 400,
				scene: [AmongStart, AmongRun, AmongEnd, AmongBent]
			}
			break;
		case 2 : // 유나
			config = {
				width: 800,
				height: 500,
				scene: [Exam03, GameOver]
			}
			
			break;
		case 4: // 은미
			config = {
				width: 1000,
				height:500,
				scene:[GameStart,Main,GameOver]
			}
			break;
		case 3: // 하람
			config = {
				width: 800,
				height:500,
				scene:[ Project,GameOver]
			}
			break;
		case 5: // 상혁
			config = {
				width: 800,
				height:500,
				scene:[ StartScene, Game,GameOver]
			}
			break;
	}
	
	return config;	
}

const gameCanvars = (seq) => {
	let gameInfo= gameConfig(seq);
	let item = `
        <div id="gamebox">
	      <div id="timer" style="display: none"></div>
	      <div id="score" style="display: none"></div>
	    </div>`;
        
    $(".game").append(item);
    
	let config = {
	    type: Phaser.AUTO,
	    parent: "game_play_form",
	    width: gameInfo.width,
	    height: gameInfo.height,
	    physics: {
	        default: "arcade"
	    },
	    scene: gameInfo.scene
	}
	
	let game = new Phaser.Game(config);
}



// 게임 종료 시 데이터 업데이트 or 인서트
const gameScoreSave = (newScore) => {
	
	const beforeScore = $("#myGameScore").html().trim();

	let data = {
		seq : $("#game_seq").val(),
		score: newScore,
		state: "none"
	}
	
	if(beforeScore === "0") {
		data.state = "insert";
	} else if(parseInt(newScore) > parseInt(beforeScore)) {
		data.state = "update";
	}
	
	// Login 상태에서만 데이터 서버로 전송
	if($("#myNickname").html().trim() !== "" && data.state !== "none"){
		$.ajax({
			url: "/save.score",
			method: "post",
			data: data
		})
		.done((res) => {
			console.log(res);
			if(res !== "fail"){
				$("#myGameScore").html(res);
			}
		});
	}
	
}

