class Main extends Phaser.Scene {
    constructor() {
        super({key:"Main"});
        this.boxes = [];
        this.frame = 0;
        this.timer = 0;
        this.tileSpeed = 2;
        this.playerCollisionCount = 0; // 플레이어 충돌 카운터
        this.lastCollisionTime = 0; //마지막 충돌 시간을 기록
        this.log = 10;
    }

    preload() {
        this.load.spritesheet('player', '/phaser3_game/Roadkill/images/player.png', { frameWidth: (346/6), frameHeight: 430/4 });
        this.load.image('car', '/phaser3_game/Roadkill/images/car.png');
        this.load.image('bg', '/phaser3_game/Roadkill/images/bg.jpg');
        this.load.image('car2', '/phaser3_game/Roadkill/images/car2.png');
    }
    

    //scene 이 start 될 때마다 실행되는 함수 (초기화)
    init(){
        this.timer = 0;
        this.playerCollisionCount = 0; // 장면이 초기화될 때마다 충돌 카운터를 0으로 초기화
        this.lastCollisionTime = 0 ; // 마지막 충돌 시간 초기화 
        this.log = 10;
    }

    create() {
        this.cameras.main.setBackgroundColor("#ffffff");

        //시간 흐름에 따라서 배경을 움직일 수 있다 (바닥에 까는 타일..?)
        this.background = this.add.tileSprite(0,0,this.cameras.main.width, this.cameras.main.height, 'bg'); 
        this.background.setOrigin(0,0);

        // x,y,w,h,color 선이 생기는데 x의 위치를 0으로 줬을때 중간으로 짤린다
        let bottomBoundary = this.add.rectangle(0, this.cameras.main.height + 30, this.cameras.main.width, 5, 0x000000);
        let topBoundary = this.add.rectangle(0, -30, this.cameras.main.width, 5, 0x000000);
        let leftBoundary = this.add.rectangle(-30, 0, 5, this.cameras.main.height, 0x000000);
        let rightBoundary = this.add.rectangle(this.cameras.main.width + 30, 0, 5, this.cameras.main.height, 0x000000);
        
        // 경계선의 시작점을 0, 0으로 설정
        bottomBoundary.setOrigin(0, 0);
        topBoundary.setOrigin(0, 0);
        leftBoundary.setOrigin(0, 0);
        rightBoundary.setOrigin(0, 0);
        
        // 물리 엔진에 경계선 추가
        this.physics.add.existing(bottomBoundary, true);
        this.physics.add.existing(topBoundary, true);
        this.physics.add.existing(leftBoundary, true);
        this.physics.add.existing(rightBoundary, true);
        
        this.physics.add.collider(this.boxes, bottomBoundary, (box, boundary) => {
            box.destroy();
            this.boxes.splice(this.boxes.indexOf(box), 1);
        });
        this.physics.add.collider(this.boxes, topBoundary, (box, boundary) => {
            box.destroy();
            this.boxes.splice(this.boxes.indexOf(box), 1);
        });
        this.physics.add.collider(this.boxes, leftBoundary, (box, boundary) => {
            box.destroy();
            this.boxes.splice(this.boxes.indexOf(box), 1);
        });
        this.physics.add.collider(this.boxes, rightBoundary, (box, boundary) => {
            box.destroy();
            this.boxes.splice(this.boxes.indexOf(box), 1);
        });
        
        //애니메이션 
        this.anims.create({
            key:"run",
            frames: this.anims.generateFrameNumbers('player',{start:12,end:17}),
            framRate:5, //숫자가 높아질수록 빠르게
            repeat: -1 //무한 반복 
        });
        // 왼쪽
        this.anims.create({
            key: 'left',
            frames: this.anims.generateFrameNumbers('player', { start: 20, end: 23 }),
            frameRate: 5,
            repeat: -1
        });
        // 오른쪽 
        this.anims.create({
            key: 'right',
            frames: this.anims.generateFrameNumbers('player', { start: 6, end: 11 }),
            frameRate: 5,
            repeat: -1
        });
        // 뒤로 이동 애니메이션
        this.anims.create({
            key: 'back',
            frames: this.anims.generateFrameNumbers('player', { start: 0, end: 5 }),
            frameRate: 5,
            repeat: -1
        });

        // player 
        this.player = this.physics.add.sprite(400,300, 'player'); // player 스프라이트 생성
        this.player.setScale(400 / 512, 200 / 256); // 크기 조정
        this.player.anims.play({key:'run'}); // 애니메이션 재생
        this.player.setData("onFloor",true); //사용자 정의값 (key value)
        this.player.setGravity(0,1000); // 중력 설정
        

        // 충돌 카운터 텍스트 추가
        this.collisionText = this.add.text(10, 10, '[내 목숨 10] 충돌 : 0', {
            fontSize: '30px',
            fontFamily: 'April16th-Life',
        }).setOrigin(0, 0);

        // 플레이어와 혜성의 충돌 감지 및 처리
        this.physics.add.collider(this.boxes, this.player, (box, player) => {
            const currentTime = this.time.now;
            if (currentTime - this.lastCollisionTime > 1000) { // 1초마다 충돌을 감지
                this.log --; //충돌시 카운터 감소
                this.playerCollisionCount++; // 충돌 카운터 증가
                this.collisionText.setText('[내 목숨 '+this.log+'] 충돌 : '+this.playerCollisionCount); // 충돌 카운터 텍스트 업데이트
                this.lastCollisionTime = currentTime; // 마지막 충돌 시간 업데이트
                
                //목숨 10개 모두 감소되면 GameOver 
                if (this.playerCollisionCount >= 10) {
                    this.scene.start("GameOver");
                }
            }
        });


        //오른쪽 카운터 
        this.timerText = this.add.text(this.cameras.main.width - 10, 5, '0', {
            fontSize: '40px',
            fontFamily: 'April16th-Life',
        }).setOrigin(1,0);

        //키보드 조작을 처리하기 위한 인스턴스 
        this.cursor = this.input.keyboard.createCursorKeys();  
    }

    update() {
        this.frame++;
        this.background.tilePositionY -= this.tileSpeed; //배경 이미지 움직임 
        this.player.setCollideWorldBounds(true); // player가 화면 밖으로 나가지 못하도록 설정

        if (this.frame % 60 === 0) {
            this.timer++;
            this.timerText.setText(this.timer);
        }
        if (this.frame % 30 === 0) {
            let box = this.physics.add.sprite(Math.random() * 800+100, 10, 'car');
            box.setVelocityY(Math.random() * (200 - 100 + 1) + 100);
            box.setBounce(1);
            box.setScale(0.1);
            this.boxes.push(box);

            if(this.timer >= 10){
                let box2 = this.physics.add.sprite(Math.random() * 1000, 450, 'car2');
                box2.setVelocityY((Math.random() * (200 - 100 + 1) + 100) * -1);
                box2.setScale(0.1);
                this.boxes.push(box2);

                this.tileSpeed = 5;
            }

            if (this.timer >= 30) {
                let randomX1 = Math.random() * (this.cameras.main.width - 50); 
                let randomY1 = Math.random() * (this.cameras.main.height - 50); 
            
                let randomX2 = Math.random() * (this.cameras.main.width - 50); 
                let randomY2 = Math.random() * (this.cameras.main.height - 50); 

                let box3 = this.physics.add.sprite(950, randomY1, 'car2');
                box3.setVelocityX((Math.random() * (200 - 100 + 1) + 100) * -1);
                box3.setScale(0.1);
                this.boxes.push(box3);
            
                let box4 = this.physics.add.sprite(50, randomY2, 'car');
                box4.setVelocityX(Math.random() * (200 - 100 + 1) + 100);
                box4.setScale(0.1);
                this.boxes.push(box4);

                this.tileSpeed = 10;
            }

        }

        if (this.cursor.left.isDown) {
            this.player.setVelocityX(-200);
            this.player.anims.play('left', true);
        } else if (this.cursor.right.isDown) {
            this.player.setVelocityX(200);
            this.player.anims.play('right', true);
        } else {
            this.player.setVelocityX(0);
        }

        if (this.cursor.up.isDown) {
            this.player.setVelocityY(-200);
            this.player.anims.play('run', true);
        } else if (this.cursor.down.isDown) {
            this.player.setVelocityY(200);
            this.player.anims.play('back', true);
        } else {
            this.player.setVelocityY(0);
        }

    }
}