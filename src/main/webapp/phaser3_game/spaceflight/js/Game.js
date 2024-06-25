class Game extends Phaser.Scene {
    constructor() {
        super({ key: 'Game' });

        this.player;
        this.bullets;
        this.enemies;
        this.enemy3;
        this.cursors;
        this.lastFired = 0;
        this.score = 0;
        this.scoreText;
        this.enemyTimer = 0;
        this.offScreenEnemies = 0;
        this.isEnemy3Active = false; // enemy3이 활성화되었는지 여부를 나타내는 변수
        this.enemy3Direction = 1; // enemy3의 초기 방향
        this.enemy3Timer = null; // enemy3의 방향 전환을 위한 타이머
        this.scoreValue;
        
    }

    init() {
        this.score = 0;  // 점수 초기화
        this.offScreenEnemies = 0; // offScreenEnemies 초기화
        this.score = 0;
        this.offScreenEnemies = 0;
        this.isEnemy3Active = false;  // 적절히 초기화
        this.enemy3Direction = 1;
        this.lastFired = 0;
        this.enemy3Timer = null;
    }

    preload() {
        this.load.image('sky', '/phaser3_game/spaceflight/images/sky.jpg');
        this.load.image('player', '/phaser3_game/spaceflight/images/player.png');
        this.load.image('bullet', '/phaser3_game/spaceflight/images/bullet.png');
        this.load.image('enemy', '/phaser3_game/spaceflight/images/enemy.png');
        this.load.image('enemy2', '/phaser3_game/spaceflight/images/enemy2.png');
         this.load.image('enemy3', '/phaser3_game/spaceflight/images/enemy3.png'); 
        
    }

    create() {
        this.background = this.add.tileSprite(0, 0, this.cameras.main.width, this.cameras.main.height, 'sky');
        this.background.setOrigin(0, 0);

        this.player = this.physics.add.sprite(400, 400, 'player').setScale(0.3); // 플레이어 이미지 크기 조정
        this.player.setCollideWorldBounds(true);

        this.bullets = this.physics.add.group({
            defaultKey: 'bullet',
            maxSize: 3000000,
            createCallback: function (bullet) {
                bullet.setScale(0.2);
                bullet.setActive(false).setVisible(false);
            }
        });

        this.enemies = this.physics.add.group({
            defaultKey: 'enemy',
            maxSize: 30000,
            createCallback: function (enemy) {
                enemy.setScale(0.3);
                enemy.setActive(false).setVisible(false);
                enemy.health = 1; // 기본 health 설정
                enemy.body.immovable = true; // enemy가 밀리지 않도록 설정
            }
        });

        this.enemy3 = this.physics.add.group({
            defaultKey: 'enemy3',
            maxSize: 1, // 한 번에 하나만 나타나도록 설정
            createCallback: function (enemy) {
                enemy.setScale(1.5);
                enemy.setActive(false).setVisible(false);
                enemy.health = 20; // enemy3의 health 설정
                enemy.body.immovable = true; // enemy3이 밀리지 않도록 설정
            }
        });

        this.physics.add.collider(this.bullets, this.enemies, this.bulletHitEnemy, null, this);
        this.physics.add.collider(this.bullets, this.enemy3, this.bulletHitEnemy3, null, this); // enemy3과 bullet 충돌 처리
        this.physics.add.collider(this.player, this.enemies, this.playerHitEnemy, null, this);
        this.physics.add.collider(this.player, this.enemy3, this.playerHitEnemy, null, this);

        this.cursors = this.input.keyboard.createCursorKeys();

        // 스코어 텍스트 설정
        this.scoreText = this.add.text(10, 10, 'SCORE: ', { fontFamily: 'Impact', fontSize: '24px', fill: 'red' });
        this.scoreValue = this.add.text(this.scoreText.x + this.scoreText.width, 10, '0', { fontFamily: 'Impact', fontSize: '24px', fill: 'white' });

        this.enemyTimer = this.time.addEvent({
            delay: 1000,
            callback: this.createEnemy,
            callbackScope: this,
            loop: true
        });

        this.time.addEvent({
            delay: 30000, // 30초마다 enemy3 생성 시도
            callback: this.createEnemy3,
            callbackScope: this,
            loop: true
        });
    }

    update() {
        this.background.tilePositionY -= 2;
        this.player.setVelocity(0);
        if (this.cursors.left.isDown) {
            this.player.setVelocityX(-300);
        } else if (this.cursors.right.isDown) {
            this.player.setVelocityX(300);
        }

        if (this.cursors.space.isDown && this.time.now > this.lastFired) {
            let bullet = this.bullets.get();
            if (bullet) {
                bullet.setActive(true).setVisible(true);
                bullet.setPosition(this.player.x, this.player.y - 20);
                bullet.setVelocityY(-300);
                this.lastFired = this.time.now + 250;
            }
        }

        this.enemies.getChildren().forEach(enemy => {
            if (enemy.y > 520) {
                this.increaseOffScreenEnemies();
                enemy.destroy();
            }
        });

        if (this.isEnemy3Active) {
            let enemy3 = this.enemy3.getFirstAlive();
            if (enemy3) {
                // 화면 우측 끝에 도달하면 좌측으로 내려오도록 설정
                if (enemy3.x >= this.cameras.main.width) {
                    enemy3.setVelocityX(-80); // 좌측으로 내려오는 속도 설정
                }
                if (enemy3.y > this.cameras.main.height) {
                    enemy3.destroy();
                    this.isEnemy3Active = false;
                    this.enemy3Timer = this.time.addEvent({
                        delay: 40000, // 0초 후 다시 enemy3 생성 시도
                        callback: this.createEnemy3,
                        callbackScope: this
                    });
                }
            }
        }

        this.physics.overlap(this.bullets, this.enemies, this.bulletHitEnemy, (bullet, enemy) => {
            return enemy.y > 100;
        }, this);

        this.physics.overlap(this.bullets, this.enemy3, this.bulletHitEnemy3, (bullet, enemy3) => {
            return enemy3.y > 100;
        }, this);
    }

    bulletHitEnemy(bullet, enemy) {
        bullet.destroy();

        enemy.health -= 1; // enemy의 health 감소

        if (enemy.health <= 0) {
            enemy.destroy();

            if (enemy.texture.key === 'enemy') {
                this.score += 30;
            } else if (enemy.texture.key === 'enemy2') {
                this.score += 15;
            }

            this.updateScore();
        }
    }

    bulletHitEnemy3(bullet, enemy3) {
        bullet.destroy();

        enemy3.health -= 1; // enemy3의 health 감소

        if (enemy3.health <= 0) {
            enemy3.destroy();
            this.isEnemy3Active = false; // enemy3이 사라졌음을 표시
            this.score += 300; // enemy3을 파괴하면 추가 점수
            this.updateScore();
        }
    }

    playerHitEnemy(player, enemy) {
        enemy.destroy();
        player.setTint(0xff0000);
        player.disableBody(true, true);

        this.scene.start("GameOver", { score: this.score });
    }

    createEnemy() {
        if (this.isEnemy3Active) return; // enemy3이 활성화된 동안에는 다른 enemy 생성 안 함

        let enemy = this.enemies.get();
        if (enemy) {
            if (Phaser.Math.RND.integerInRange(0, 1) === 0) {
                enemy.setTexture('enemy');
                enemy.health = 2; // enemy의 health 설정
            } else {
                enemy.setTexture('enemy2');
                enemy.health = 1; // enemy2의 health 설정
            }
            enemy.setActive(true).setVisible(true);
            enemy.setPosition(Phaser.Math.RND.integerInRange(50, this.cameras.main.width - 50), 0);
            enemy.setVelocityY(Phaser.Math.RND.integerInRange(50, 100));
        }
    }

    createEnemy3() {
        if (this.isEnemy3Active) return;

        let enemy3 = this.enemy3.get();
        if (enemy3) {
            enemy3.setActive(true).setVisible(true);
            enemy3.setPosition(this.cameras.main.width / 2, 0);
            enemy3.setVelocityX(Phaser.Math.RND.integerInRange(50, 80)); // 초기 X축 속도 설정
            enemy3.setVelocityY(30); // Y축 속도 설정
            enemy3.health = 25;

            // enemy3를 활성화할 때 body 속성 설정
            enemy3.body.allowGravity = false; // 중력 비활성화
            enemy3.body.collideWorldBounds = false; // 화면 경계 충돌 비활성화

            this.isEnemy3Active = true;
            
        }
    }

    updateScore() {
        this.scoreValue.setText(this.score);
    }

    increaseOffScreenEnemies() {
        this.offScreenEnemies++;
        if (this.offScreenEnemies >= 3) {
            this.scene.start("GameOver", { score: this.score });
        }
    }
}
