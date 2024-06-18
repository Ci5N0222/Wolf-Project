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
			
			break;
	}
	
	return config;	
}

const gameCanvars = (seq) => {
	let gameInfo= gameConfig(seq);
	let item = `
        <div>
            Score : <span id="score">0</span> <br />
            Timer : <span id="timer">0</span>
            <div id="gamebox"></div>
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