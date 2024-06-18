
class GameOver extends Phaser.Scene {


    constructor() {
        super({ key: "GameOver" });
    }


    preload() {
        this.load.image('gameoverImg', '/images/gameover2.png');
        this.load.image('scoreImg', '/images/score.png');
        this.load.image('restartBtn', '/images/restart.png');
        this.load.image('exitBtn', '/images/exit.png');
        // this.load.font('Lilita One', '/font/LilitaOne-Regular.ttf');
    }

    create(data) {

        console.log('Data received in GameOver:', data);

        let gameoverImg = this.add.image(this.cameras.main.width / 2, 230, 'gameoverImg');
        gameoverImg.setOrigin(0.5);
        gameoverImg.setScale(1.2);

        // let scoreImg = this.add.image(this.cameras.main.width / 2 - 130, 530, 'scoreImg');
        // scoreImg.setOrigin(0.5);
        // scoreImg.setScale(0.3);

        // this.timerText = this.add.text(520, 20, '0', {
        //     fontSize: '32px',
        //     fill: '#FF0000'
        // });

        // 얻은 점수 표시
        // this.add.text(this.cameras.main.width / 2 + 80, 530, `Score: ${data.score}`, {
        //     fontFamily: 'Lilita One',
        //     fontSize: '40px',
        //     fill: '#000000'
        // }).setOrigin(0.5);

        // "score : " 문구 추가
        this.add.text(this.cameras.main.width / 2, 530, `Score   :   ${data.score}`, {
            fontFamily: 'Lilita One',
            fontSize: '80px',
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
        let exitBtn = this.add.sprite(960, 60, 'exitBtn').setInteractive();
        exitBtn.setScale(0.5);

        exitBtn.on('pointerdown', () => {
            this.scene.start('/');
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







