class GameOver extends Phaser.Scene {
  constructor() {
    super({
      key: "GameOver",
    });
  }

  preload() {
    this.load.image("game-bg", "/phaser3_game/Roadkill/images/bg.jpg");
    this.load.image("gameover", "/phaser3_game/Roadkill/images/gameover.png");
  }

  create() {
    // 배경 이미지 추가
    let backgroundImage = this.add.image(
      this.cameras.main.width / 2,
      this.cameras.main.height / 2,
      "game-bg"
    );
    backgroundImage.setDisplaySize(
      this.cameras.main.width * 1.3,
      this.cameras.main.height * 1.05
    );
    // 오퍼시티 설정
    backgroundImage.setAlpha(0.5);

    // 게임오버 이미지 추가
    this.add.image(
      this.cameras.main.width / 2,
      this.cameras.main.height / 2,
      "gameover"
    ).setDisplaySize(this.cameras.main.width, this.cameras.main.height);

    // 게임오버 텍스트 추가
    this.add.text(
      this.cameras.main.width / 2,
      this.cameras.main.height / 2,
      "GameOver",
      {
        fontSize: "100px",
        fontFamily: 'April16th-Life',
      }
    ).setOrigin(0.5);


    // 리스타트 버튼 추가
    let restartBtn = this.add.text(
      this.cameras.main.width / 2,
      this.cameras.main.height / 2 + 100,
      "Restart",
      {
        fontSize: "50px",
        fontFamily: 'April16th-Life',
      }
    ).setOrigin(0.5).setInteractive();

    // 리스타트 버튼 hover 시 애니메이션 효과
    restartBtn.on("pointerover", () => {
      this.tweens.add({
        targets: restartBtn,
        scaleX: 1.2,
        scaleY: 1.2,
        duration: 100,
        ease: 'Linear',
        yoyo: true, // 다시 원래 크기로 돌아오게 설정
      });
    });

    restartBtn.on("pointerdown", () => {
      this.scene.start("Main"); // Main 씬으로 이동
    });
  }

  update() {}
}
