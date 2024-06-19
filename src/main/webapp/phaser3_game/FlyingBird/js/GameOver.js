
class GameOver extends Phaser.Scene {


    constructor() {
        super({ key: "GameOver" });
    }


    preload() {
        this.load.image('gameoverImg', '/phaser3_game/FlyingBird/images/gameover2.png');
        this.load.image('scoreImg', '/phaser3_game/FlyingBird/images/score.png');
        this.load.image('restartBtn', '/phaser3_game/FlyingBird/images/restart.png');
        this.load.image('exitBtn', '/phaser3_game/FlyingBird/images/exit.png');
    }

    create(data) {

        console.log('Data received in GameOver:', data);

        let gameoverImg = this.add.image(this.cameras.main.width / 2, 180, 'gameoverImg');
        gameoverImg.setOrigin(0.5);

        // "score : " 문구 추가
        this.add.text(this.cameras.main.width / 2, 400, `Score    ${data.score}`, {
            fontFamily: 'Lilita One',
            fontSize: '65px',
            fill: '#f0f8ff'
        }).setOrigin(0.5);


        // reStart 버튼 추가
        let restartBtn = this.add.sprite(60, 60, 'restartBtn').setInteractive();
        restartBtn.setScale(0.5);

        restartBtn.on('pointerdown', () => {
            this.scene.start('Exam03');
        });
        // 버튼에 마우스 올릴 시 크기조절 및 효과
        restartBtn.on("pointerover", () => {
            restartBtn.setScale(0.6);
            this.game.canvas.style.cursor = "pointer";
        });
        restartBtn.on("pointerout", () => {
            restartBtn.setScale(0.5);
            this.game.canvas.style.cursor = "default";
        });


        // exit 버튼 추가
        let exitBtn = this.add.sprite(740, 60, 'exitBtn').setInteractive();
        exitBtn.setScale(0.5);

        exitBtn.on('pointerdown', () => {
            location.href= '/list.game';
        });
        // 버튼에 마우스 올릴 시 크기조절 및 효과
        exitBtn.on("pointerover", () => {
            exitBtn.setScale(0.6);
            this.game.canvas.style.cursor = "pointer";
        });
        exitBtn.on("pointerout", () => {
            exitBtn.setScale(0.5);
            this.game.canvas.style.cursor = "default";
        });

    }

    update() {

    }

}

