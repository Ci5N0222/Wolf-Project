class AmongStart extends Phaser.Scene {
    constructor() {
        super({key:"AmongStart"});
    }

    preload(){
        this.load.image("start-bg", "/phaser3_game/among_run/images/start-bg.png");
    }

    create(){
        this.background = this.add.tileSprite(0, 0, this.cameras.main.width, this.cameras.main.height, "start-bg");
        this.background.setOrigin(0, 0);

        let startBtn = this.add.text(this.cameras.main.width/2, this.cameras.main.height/2+60, "Start", {
            fontSize: "40px",
            fontWeight: "900"
        }).setOrigin(0.5).setInteractive();

        let padding = 15;
        let textWidth = startBtn.width + padding * 2;
        let textHeight = startBtn.height + padding * 2;

        let box = this.add.graphics();
        box.lineStyle(4, 0xFFFFFF, 1);
        box.strokeRect(startBtn.x - startBtn.width/2 - padding, startBtn.y - startBtn.height / 2 - padding, textWidth, textHeight);
        this.children.bringToTop(startBtn);

        startBtn.on("pointerover", () => {
            startBtn.setColor("#FFFF00");
            this.game.canvas.style.cursor = "pointer";

            box.clear();
            box.lineStyle(4, 0xFFFF00, 1); 
            box.strokeRect(startBtn.x - startBtn.width / 2 - padding, startBtn.y - startBtn.height / 2 - padding, textWidth, textHeight);
        });

        startBtn.on("pointerout", () => {
            startBtn.setColor("#FFFFFF");
            this.game.canvas.style.cursor = "pointer";

            box.clear();
            box.lineStyle(4, 0xFFFFFF, 1); 
            box.strokeRect(startBtn.x - startBtn.width / 2 - padding, startBtn.y - startBtn.height / 2 - padding, textWidth, textHeight);
        });

        startBtn.on("pointerdown", () => {
            this.scene.start("AmongRun");
        });
    }

    update(){
        
    }
}