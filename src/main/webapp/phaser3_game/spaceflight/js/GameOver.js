class GameOver extends Phaser.Scene {
    constructor() {
        super({ key: 'GameOver' });
    }
    init(data) {
        this.score = data.score; // 전달된 스코어 값을 저장
    }
    preload(){
        this.load.image('sky', '/phaser3/spaceflight/images/sky.jpg');
        
    this.load.image('gameover', '/phaser3_game/spaceflight/images/gameover.png');
    this.load.image('restartButton', '/phaser3_game/spaceflight/images/restart.png');
    }
    create() {
        this.background = this.add.tileSprite(0, 0, this.cameras.main.width, this.cameras.main.height, 'sky');
        this.background.setOrigin(0, 0);
    
        // 게임오버 이미지 추가
        let gameoverImage = this.add.image(this.cameras.main.width / 2, 150 , 'gameover');
        gameoverImage.setScale(2.5);
        // 리스타트 버튼 이미지 추가
        let restartButton = this.add.image(this.cameras.main.width / 2, this.cameras.main.height / 2 + 150, 'restartButton');
        restartButton.setInteractive(); // 이미지를 인터랙티브하게 만들어 클릭 가능하게 함
    
        restartButton.on('pointerdown', () => {
            this.scene.start('Game');
        });
    
        // 실제 점수 텍스트 추가
       // SCORE 텍스트 추가
       let scoreText = this.add.text(this.cameras.main.width / 2 - 30, this.cameras.main.height / 2 + 50, 'SCORE: ', {
	        fontFamily: 'Impact', fontSize: '72px', fill: 'red'
	    }).setOrigin(0.5);
	
	    // 실제 점수 텍스트 추가
	    let scoreValue = this.add.text(scoreText.x + scoreText.width * 0.5, this.cameras.main.height / 2 + 50, this.score, {
	        fontFamily: 'Impact', fontSize: '72px', fill: 'white'
	    }).setOrigin(0, 0.5);
	    
	    gameScoreSave(this.score);
    
    }

    update(){
        this.background.tilePositionY -= 2;
    }
}