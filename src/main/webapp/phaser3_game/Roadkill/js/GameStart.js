class GameStart extends Phaser.Scene {
    constructor() {
        super({
            key: "GameStart"
        });
    }

    preload() {
        this.load.image('game', '/phaser3_game/Roadkill/images/gameStart.png');
        this.load.image("game-bg", "/phaser3_game/Roadkill/images/bg.jpg");
        this.load.image("car2", "/phaser3_game/Roadkill/images/car2.png");
        this.load.image("car", "/phaser3_game/Roadkill/images/car.png");
    }

    create() {
        // 배경
        this.add.image(
            this.cameras.main.width / 2,
            this.cameras.main.height / 2,
            "game-bg"
        ).setDisplaySize(this.cameras.main.width * 1.3, this.cameras.main.height * 1.05);

        // 게임 스타트 이미지
        let gameImage = this.add.image(this.cameras.main.width / 2, this.cameras.main.height / 2, 'game').setOrigin(0.5);
        gameImage.setScale(0.5); 
        gameImage.setInteractive({ cursor: 'pointer' });
        gameImage.on('pointerdown', () => {
            this.scene.start("Main");
        });

        // 차량 이미지 추가
        this.car = this.add.image(100, -50, 'car');
        this.car.setScale(0.3); // 차량 이미지 크기 조정
        this.car2 = this.add.image(900, -50, 'car2');
        this.car2.setScale(0.3); // 차량 이미지 크기 조정

        // 차량을 위에서 아래로 이동하게 설정
        this.tweens.add({
            targets: this.car,
            y: this.cameras.main.height + 50, // 목표 위치 (화면 아래)
            duration: 2000, // 이동하는 데 걸리는 시간 (ms)
            ease: 'Linear', // 이징 함수 (선택 사항)
            yoyo: true, // 왕복 애니메이션 설정
            repeat: -1 // 무한 반복
        });
        this.tweens.add({
            targets: this.car2,
            y: this.cameras.main.height + 50, // 목표 위치 (화면 아래)
            duration: 2000, // 이동하는 데 걸리는 시간 (ms)
            ease: 'Linear', // 이징 함수 (선택 사항)
            yoyo: true, // 왕복 애니메이션 설정
            repeat: -1 // 무한 반복
        });
    }

    update() {
        // 게임 로직 업데이트
    }
}
