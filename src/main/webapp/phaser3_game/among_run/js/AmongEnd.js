class AmongEnd extends Phaser.Scene {
    constructor(){
        super({key: "AmongEnd"});
        this.score = "";
    }

    preload(){
        this.load.image("game-over", "images/game-over.png");
    }

    create(){
        this.background = this.add.tileSprite(0, 0, this.cameras.main.width, this.cameras.main.height, "game-over");
        this.background.setOrigin(0, 0);

        let scoreText = this.add.text(this.cameras.main.width/2 -50, this.cameras.main.height/2 -130, "Score", {
            fontSize: "30px",
            fontStyle: "bold",
            fill: "#FFFFFF"
        }).setOrigin(0.5).setInteractive();

        let score = this.add.text(this.cameras.main.width/2 + 50, this.cameras.main.height/2 -130, this.score, {
            fontSize: "30px",
            fontStyle: "bold",
            fill: "#FFFF00"
        }).setOrigin(0.5).setInteractive();
        score.text += document.querySelector("#score").innerHTML.trim();


        let restartBtn = this.add.text(this.cameras.main.width/2, this.cameras.main.height/2+ 130, "Restart", {
            fontSize: "40px",
            fontWeight: "900"
        }).setOrigin(0.5).setInteractive();

        let padding = 15;
        let textWidth = restartBtn.width + padding * 2;
        let textHeight = restartBtn.height + padding * 2;

        let box = this.add.graphics();
        box.lineStyle(4, 0xFFFFFF, 1);
        box.strokeRect(restartBtn.x - restartBtn.width/2 - padding, restartBtn.y - restartBtn.height / 2 - padding, textWidth, textHeight);
        this.children.bringToTop(restartBtn);

        restartBtn.on("pointerover", () => {
            restartBtn.setColor("#FFFF00");
            this.game.canvas.style.cursor = "pointer";

            box.clear();
            box.lineStyle(4, 0xFFFF00, 1); 
            box.strokeRect(restartBtn.x - restartBtn.width / 2 - padding, restartBtn.y - restartBtn.height / 2 - padding, textWidth, textHeight);
        });

        restartBtn.on("pointerout", () => {
            restartBtn.setColor("#FFFFFF");
            this.game.canvas.style.cursor = "pointer";

            box.clear();
            box.lineStyle(4, 0xFFFFFF, 1); 
            box.strokeRect(restartBtn.x - restartBtn.width / 2 - padding, restartBtn.y - restartBtn.height / 2 - padding, textWidth, textHeight);
        });

        restartBtn.on("pointerdown", () => {
            this.scene.start("AmongRun");
        });

        // 점수 DB에 저장
    }

    update(){
        
    }

}