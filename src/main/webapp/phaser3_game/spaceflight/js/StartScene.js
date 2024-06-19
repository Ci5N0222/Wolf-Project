class StartScene extends Phaser.Scene {
    constructor() {
        super({ key: 'StartScene' });
    }
    
    preload() {
        this.load.image('sky', '/phaser3_game/spaceflight/images/sky.jpg');
        this.load.image('logo', '/phaser3_game/spaceflight/images/enemy3.png'); // 로고 이미지 추가
        this.load.image('startButton', '/phaser3_game/spaceflight/images/start.png');
        this.load.image('enemy', '/phaser3_game/spaceflight/images/enemy.png'); // 추가할 이미지
        this.load.image('enemy2', '/phaser3_game/spaceflight/images/enemy2.png'); // 추가할 이미지
        this.load.image('player', '/phaser3_game/spaceflight/images/player.png'); // 추가할 이미지
        this.load.image('bullet', '/phaser3_game/spaceflight/images/bullet.png');
    }

    create() {
        // 배경 이미지
        this.background = this.add.tileSprite(0, 0, this.cameras.main.width, this.cameras.main.height, 'sky');
        this.background.setOrigin(0, 0);

        // 게임 로고
        let logo = this.add.image(400, 150, 'logo');
        logo.setScale(1.5);
        logo.setAlpha(0); // 초기에는 투명하게 설정

        // 로고 애니메이션: 서서히 나타나기
        this.tweens.add({
            targets: logo,
            alpha: 1,
            duration: 2000,
            ease: 'Power2'
        });

        // 시작 버튼
        let startButton = this.add.sprite(400, 300, 'startButton').setInteractive();
        startButton.setScale(1.5);
        startButton.setFrame(0); // 초기 프레임 설정

        // 시작 버튼 애니메이션: Hover 및 클릭 시 효과
        startButton.on('pointerover', () => {
            startButton.setFrame(1); // Hover 상태 프레임
        });

        startButton.on('pointerout', () => {
            startButton.setFrame(0); // 기본 상태 프레임
        });

        startButton.on('pointerup', () => {
            this.scene.start('Game');
        });

        // 텍스트 애니메이션: Fade-in 효과
        this.tweens.add({
            targets: startButton,
            alpha: 0.3,
            yoyo: true,
            repeat: -1,
            duration: 1000,
            ease: 'Sine.easeInOut'
        });

        // 추가 이미지들 배치
        let top1 = this.add.image(200, 100, 'enemy');
        top1.setScale(0.5);
        top1.setAlpha(0.7);

        let top2 = this.add.image(600, 80, 'enemy2');
        top2.setScale(0.4);
        top2.setAlpha(0.6);

        let bottom1 = this.add.image(100, 400, 'enemy');
        bottom1.setScale(0.5);
        bottom1.setAlpha(0.7);

        let bottom2 = this.add.image(700, 450, 'enemy2');
        bottom2.setScale(0.6);
        bottom2.setAlpha(0.7);

        let bottom = this.add.image(400, 450, 'player');
        bottom.setScale(0.8);
        bottom.setAlpha(0.8);
    }

    update() {
        // 배경 스크롤링
        this.background.tilePositionY -= 2;
    }
}
