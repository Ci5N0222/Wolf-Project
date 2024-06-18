$(() => {
	

});

const gameConfig = (seq) => {
	let config = {};
	switch(seq){
		case 6:
			config = {
				width: 700,
				height: 400,
				scene: [AmongStart, AmongRun, AmongEnd, AmongBent]
			}
			break;
		case 8 :
			config = {
				width: 800,
				height: 500,
				scene: [Exam03, GameOver]
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


