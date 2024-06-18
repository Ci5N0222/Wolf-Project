class AmongBent extends Phaser.Scene {
    constructor(){
        super({key:"AmongBent"});

        this.frame = 0;
        this.timer = 0;
    }

    init(data) {
        this.frame = 0;
        this.timer = 0;
    }

    preload(){
        this.load.image("bent-end", "/phaser3_game/among_run/images/bent-end.jpg");
        this.load.spritesheet("bent-among", "/phaser3_game/among_run/images/amongJump.png", {frameWidth: 316/10, frameHeight: 29});
    }

    create(){
        this.background = this.add.tileSprite(0, 0, this.cameras.main.width, this.cameras.main.height, "bent-end");
        this.background.setOrigin(0, 0);

        this.anims.create({
            key:"ending",
            frames:[{key: "bent-among", frame: 9}],
            frameRate: 7,
            repeat: -1
        });

        this.player = this.physics.add.sprite(this.cameras.main.width/2, this.cameras.main.height-430, "bent-among");
        let playerScaleFactor = 4;
        this.player.setScale(playerScaleFactor);
        this.player.setSize(50/playerScaleFactor, 80/playerScaleFactor);
        this.player.setVelocityY(50);
        this.player.anims.play({key:"ending"});

        let endText = this.add.text(this.cameras.main.width/2, this.cameras.main.height/2 + 30, "", {
            fontSize: "25px",
            fontStyle: "bold",
            fill: "#FFFFFF"
        }).setOrigin(0.5);

        let message = "당신은 우주의 먼지가 되었습니다..."
        let index = 0;
        this.time.addEvent({
            delay: 200,
            callback: () => {
                endText.text += message[index];
                index++;

                if(index == message.length){
                    this.time.removeAllEvents();
                }
            },
            loop: true
        });
    }

    update(){
        this.frame++;

        if(this.frame%60 === 0) {
            this.timer++;
        }

        if(this.timer === 6){
            this.scene.start("AmongEnd");
        }

    }

}