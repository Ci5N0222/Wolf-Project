class Exam03 extends Phaser.Scene {

    constructor() {
        super({ key: "Exam03" });
        this.cookies = [];
        this.eagles = [];
        this.frame = 0;
        this.timer = 0;
        this.score = 0;
        this.jumpCount = 0;
        this.tileSpeed = 3;
        this.isStart = false;

    }

    preload() {
        this.load.image('background', '/phaser3_game/FlyingBird/images/background4.jpg');
        this.load.spritesheet('bird', '/phaser3_game/FlyingBird/images/bird.png', { frameWidth: 135, frameHeight: 123 });
        this.load.image('cookie', '/phaser3_game/FlyingBird/images/cookie.png');
        this.load.spritesheet('eagle', '/phaser3_game/FlyingBird/images/eagle.png', { frameWidth: 360, frameHeight: 86.625 }); // 스프라이트 시트 로드
        this.load.image('startBtn', '/phaser3_game/FlyingBird/images/startbtn.png');
        this.load.image('startImg', '/phaser3_game/FlyingBird/images/start.png');
        this.load.image('score', '/phaser3_game/FlyingBird/images/score.png');
        this.load.image('timer', '/phaser3_game/FlyingBird/images/timer.png');
    }
    init() {
        this.cookies = [];
        this.eagles = [];
        this.frame = 0;
        this.timer = 0;
        this.score = 0;
        this.jumpCount = 0;
        this.tileSpeed = 3;
        this.isStart = false;
    }
    create() {
        this.cameras.main.setBackgroundColor("#ffffff");

        // 사용자 움직임
        this.anims.create({
            key: "run",
            frames: this.anims.generateFrameNumbers('bird', { start: 0, end: 13 }),
            frameRate: 10, 
            repeat: -1 
        });
        this.anims.create({
            key: "jump",
            frames: this.anims.generateFrameNumbers('bird', { frames: [2, 3, 4, 5] }),
            frameRate: 5,
            repeat: -1
        });

        // 장애물 움직임 (독수리)
        this.anims.create({
            key: "come",
            frames: this.anims.generateFrameNumbers('eagle', { start: 0, end: 7 }),
            frameRate: 7, 
            repeat: -1 
        });

        // 배경
        this.background = this.add.tileSprite(0, 0, this.cameras.main.width, this.cameras.main.height, 'background');
        this.background.setOrigin(0, 0);

        // 바닥선
        let floor = this.add.rectangle(0, 410, this.cameras.main.width, 5, "#000000", 0);
        floor.setOrigin(0, 0);

        // 왼쪽 바깥선
        let leftBoundary = this.add.rectangle(-30, 0, 5, this.cameras.main.height, "#000000");
        leftBoundary.setOrigin(0, 0);
        this.physics.add.existing(leftBoundary, true);
        this.physics.add.collider(this.cookies, leftBoundary, (cookie, boundary) => {
            cookie.destroy();
            this.cookies.splice(this.cookies.indexOf(cookie), 1);
        });
        this.physics.add.collider(this.eagles, leftBoundary, (eagle, boundary) => {
            eagle.destroy();
            this.eagles.splice(this.eagles.indexOf(eagle), 1);
        });

        // 사용자
        this.player = this.physics.add.sprite(80, 250, 'bird');
        this.player.setCollideWorldBounds(true);
        this.player.anims.play({ key: 'run' });
        this.player.setData("onFloor", true); 


        let scaleFactor = 75 / 135; 
        this.player.setScale(scaleFactor);
        this.player.setSize(20 / scaleFactor, 25 / scaleFactor);


        this.physics.add.existing(floor, true);
        this.physics.add.collider(this.player, floor, (player, floor) => {
            player.setData("onFloor", true);
        });

        // 쿠키 먹을 시 점수 +50
        this.physics.add.overlap(this.cookies, this.player, (cookie, player) => {
            this.score += 50;
            this.scoreText.setText(this.score);
            document.getElementById("score").innerHTML = this.score;
            cookie.destroy();
            this.cookies.splice(this.cookies.indexOf(cookie), 1);
        });

        this.physics.add.collider(this.player, this.eagles, (player, eagle) => {
            console.log('Game over triggered, score:', this.score); 
            this.scene.start('GameOver', { score: this.score }); 
        });

        // 타이머
        // 타이머 이미지
        let timerImg = this.add.image(60, 50, 'timer');
        timerImg.setScale(0.1);
        // 타이머 텍스트
        this.timerText = this.add.text(120, 40, '0', {
            fontFamily: 'Lilita One',
            fontSize: '25px',
            fill: '#000000'
        });

        // 점수
        // 점수 이미지
        let scoreImg = this.add.image(600, 53, 'score');
        scoreImg.setScale(0.17);
        // 점수 텍스트
        this.scoreText = this.add.text(700, 35, '0', {
            fontFamily: 'Lilita One',
            fontSize: '25px',
            fill: '#000000',

        });

        this.cursor = this.input.keyboard.createCursorKeys();

        this.cameras.main.setBackgroundColor("#ffffff");
        let startBackgroud = this.add.rectangle(0, 0, this.cameras.main.width, this.cameras.main.height, 0x000000, 0.5).setOrigin(0);

        let startImg = this.add.sprite(this.cameras.main.width / 2, this.cameras.main.height / 2 - 50, 'startImg').setInteractive();
        startImg.setScale(0.8);


        // Start 버튼 추가
        let startButton = this.add.sprite(this.cameras.main.width / 2, this.cameras.main.height / 2 + 140, 'startBtn').setInteractive();
        startButton.setScale(0.5);

        startButton.on('pointerdown', () => {
            this.isStart = true;
            startImg.destroy(); 
            startButton.destroy(); 
            startBackgroud.destroy();
        });
        // 버튼에 마우스 올릴 시 크기조절 및 효과
        startButton.on("pointerover", () => {
            startButton.setScale(0.55);
            this.game.canvas.style.cursor = "pointer";
        });
        startButton.on("pointerout", () => {
            startButton.setScale(0.5);
            this.game.canvas.style.cursor = "default";
        });


    }

    update() {
        if (this.isStart) {
            this.player.setGravity(0, 700);

            // 타일 속도 조정
            if (this.timer > 20) {
                this.tileSpeed = 5;
            } else if (this.timer > 10) {
                this.tileSpeed = 4;
            }

            this.background.tilePositionX += this.tileSpeed;
            this.frame++;

            if (Phaser.Input.Keyboard.JustDown(this.cursor.space)) {
                this.player.setVelocityY(-300); 
                this.player.play("jump");
                this.player.setData("onFloor", false);
                this.jumpCount++;
            }

            // 사용자 움직임 조작
            if (this.cursor.left.isDown) {
                this.player.setVelocityX(-200);
            } else if (this.cursor.right.isDown) {
                this.player.setVelocityX(200);
            } else {
                this.player.setVelocityX(0); 
            }

            // 플레이어가 바닥에 있고 뛰는 애니메이션이 아닌 경우
            if (this.player.getData("onFloor") && this.player.anims.currentAnim.key != "run") {
                this.player.play("run");
                this.jumpCount = 0;
            }

            // 타이머
            if (this.frame % 60 == 0) {
                this.timer++;
                this.timerText.setText(this.timer);
                document.getElementById("timer").innerHTML = this.timer;
            }

            // 쿠키 & 독수리 랜덤 생성
            if (this.frame % 60 == 0) {
                let rand1 = Math.random();
                let rand2 = Math.random();

                if (this.timer < 10) {
                    if (rand1 < 0.4) {
                        // 쿠키 생성
                        let cookie = this.physics.add.sprite(790, Math.random() * (410 - 60 + 1) + 60, "cookie");
                        cookie.setVelocityX(Math.random() * (200 - 240 + 1) - 200);

                        let cookie_scaleFactor = 27 / 512;
                        cookie.setScale(cookie_scaleFactor);
                        cookie.setSize(15 / cookie_scaleFactor, 15 / cookie_scaleFactor);
                        this.cookies.push(cookie);

                    } else if (rand2 >= 0.4) {
                        // 독수리 생성
                        let eagleY = Math.random() * (490 - 60 + 1) + 60;
                        let eagle = this.physics.add.sprite(790, eagleY, 'eagle').setOrigin(0.5, 1);

                        let eagle_scaleFactorX = 220 / 360;
                        let eagle_scaleFactorY = 60 / 86.625;
                        eagle.setScale(eagle_scaleFactorX, eagle_scaleFactorY);
                        eagle.setSize(40 / eagle_scaleFactorX, 20 / eagle_scaleFactorY);

                        eagle.setVelocityX(-220);
                        eagle.anims.play('come');
                        this.eagles.push(eagle);
                    }

                } else if (this.timer > 11) {

                    if (rand1 < 0.4) {
                        // 쿠키 생성
                        let cookie = this.physics.add.sprite(1010, Math.random() * (410 - 60 + 1) + 60, "cookie");
                        cookie.setVelocityX(Math.random() * (220 - 250 + 1) - 220 * (this.tileSpeed / 2));

                        let cookie_scaleFactor = 27 / 512;
                        cookie.setScale(cookie_scaleFactor);
                        cookie.setSize(15 / cookie_scaleFactor, 15 / cookie_scaleFactor);
                        this.cookies.push(cookie);
                    } else if (rand2 >= 0.4) {
                        // 독수리 생성
                        let eagleY = Math.random() * (490 - 60 + 1) + 60;
                        let eagle = this.physics.add.sprite(1010, eagleY, 'eagle').setOrigin(0.5, 1);

                        let eagle_scaleFactorX = 220 / 360;
                        let eagle_scaleFactorY = 60 / 86.625;
                        eagle.setScale(eagle_scaleFactorX, eagle_scaleFactorY);
                        eagle.setSize(40 / eagle_scaleFactorX, 20 / eagle_scaleFactorY);

                        eagle.setVelocityX(Math.random() * (230 - 270 + 1) - 230 * (this.tileSpeed / 2));
                        eagle.anims.play('come');
                        this.eagles.push(eagle);
                    }

                }
            }

        }

    }

}
