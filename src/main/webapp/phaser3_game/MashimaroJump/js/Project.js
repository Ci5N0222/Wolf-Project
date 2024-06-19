
class Carrot extends Phaser.Physics.Arcade.Sprite
{

	constructor(scene, x, y, texture = 'carrot')
	{
		super(scene, x, y, texture)

		this.setScale(0.5)
	}
}

class Wolf extends Phaser.Physics.Arcade.Sprite
{

	constructor(scene, x, y, texture = 'wolf')
	{
		super(scene, x, y, texture);

		this.setScale(0.1);
     
        this.anims.play("right");
        //this.anims.play("right");
        //this.setBounce(1);
	}
}

class Project extends Phaser.Scene{


    constructor(){
        super({key:"Project"});
        this.count=0;
        this.a=[];
        this.b=[];
    }
    init()
	{
		this.carrotsCollected = 0;
        this.count=0;
        this.a=[];
        this.b=[];
	}
    preload(){
        this.load.image('background', '/phaser3_game/MashimaroJump/images/bg_layer1.png');
		this.load.image('platform', '/phaser3_game/MashimaroJump/images/ground_grass.png');
		this.load.image('bunny-stand', '/phaser3_game/MashimaroJump/images/bunny1_stand.png');
        this.load.image('bunny-stand-reverse', '/phaser3_game/MashimaroJump/images/bunny1_stand_reverse.png');
		this.load.image('bunny-jump', '/phaser3_game/MashimaroJump/images/bunny1_jump.png');
        this.load.image('bunny-jump-reverse', '/phaser3_game/MashimaroJump/images/bunny1_jump_reverse.png');
		this.load.image('carrot', '/phaser3_game/MashimaroJump/images/carrot.png');
    	this.load.audio('jump', '/phaser3_game/MashimaroJump/images/sfx/phaseJump1.wav');
		this.load.image('wolf','/phaser3_game/MashimaroJump/images/wolf.png');
        this.load.spritesheet('wolf-left','/phaser3_game/MashimaroJump/images/wolfattack_left.png',{frameWidth:590,frameHeight:412});
        this.load.spritesheet('wolf-right','/phaser3_game/MashimaroJump/images/wolfattack_right.png',{frameWidth:650,frameHeight:412});
		
		this.cursor = this.input.keyboard.createCursorKeys();
    }

    create(){
        this.add.image(240, 320, 'background').setScrollFactor(1, 0);
		 this.anims.create({
            key:'right',
            frames:this.anims.generateFrameNumbers('wolf-right',{frames:[0,1,2]}),
            frameRate:5,
            repeat:-1
        });

        this.anims.create({
            key:'left',
            frames:this.anims.generateFrameNumbers('wolf-left',{frames:[2,1,0]}),
            frameRate:5,
            repeat:-1
        }); 
		this.platforms = this.physics.add.staticGroup();
		// then create 5 platforms from the group
		for (let i = 0; i < 5; ++i)
		{
			const x = Phaser.Math.Between(0, 400)
			const y = 150 * i;
			const platform = this.platforms.create(x, y, 'platform');
			platform.setScale(1, 0.5);
			const body = platform.body;
			body.updateFromGameObject();
			
			let bottomBoundary1= 
            this.add.rectangle(x-180,y-30,50,100,0xffffff).setVisible(false);
            this.physics.add.existing(bottomBoundary1,true);
            let bottomBoundary2= 
            this.add.rectangle(x+180,y-30,50,100,0xffffff).setVisible(false);
            this.physics.add.existing(bottomBoundary2,true);

            this.a.push(bottomBoundary1);
            this.b.push(bottomBoundary2);
		}

		this.player = this.physics.add.sprite(240, 320, 'bunny-stand').setScale(0.2);
        this.player.setSize(50/0.2, 65/0.2);
		//this.physics.add.collider(this.platforms, this.player);
    
        //위 왼쪽 오른쪽 출동무시
		
        this.physics.add.collider(this.player,this.platforms,(me,floor)=>{});
        this.player.body.checkCollision.up = false;
		//this.player.body.checkCollision.left = false;
		//this.player.body.checkCollision.right = false;
        this.player.setGravityY(300);
		this.cameras.main.startFollow(this.player);
		this.cameras.main.setDeadzone(this.scale.width * 1.5);

		this.carrots = this.physics.add.group({
			classType: Carrot
		})
		  this.wolfs = this.physics.add.group({
			classType: Wolf
		})
		
		this.physics.add.collider(this.platforms, this.wolfs);
        this.physics.add.collider(this.a, this.wolfs,(boundary,wolf)=>{
            wolf.anims.play("right");
        });
        this.physics.add.collider(this.b, this.wolfs,(boundary,wolf)=>{
            wolf.anims.play("left");
        });
        this.physics.add.collider(this.player,this.wolfs,()=>{
            this.scene.start('GameOver');
        })
		
		this.physics.add.collider(this.platforms, this.carrots);
		this.physics.add.overlap(this.player, this.carrots, this.handleCollectCarrot, undefined, this);
		this.carrotsCollectedText = this.add.text(240, 10, 'Carrots: 0', { color: '#000', fontSize: 24 }).setScrollFactor(0).setOrigin(0.5, 0);
    }

    update(){
        if (!this.player)
            {
                return
            }
    
            this.platforms.children.iterate((child, index) => {
                const platform = child
                const scrollY = this.cameras.main.scrollY
                if (platform.y >= scrollY + 700)
                {
                    platform.y = scrollY - Phaser.Math.Between(50, 100)
                    platform.body.updateFromGameObject();
                    this.addCarrotAbove(platform);
                    this.addWolf(platform);
                    
                    this.a[index].y = platform.y-30;
                    this.a[index].body.updateFromGameObject();

                    this.b[index].y = platform.y-30;
                    this.b[index].body.updateFromGameObject();
                }
            })
    
    
            if(this.cursor.left.isDown){
                //this.player.x-=10;
                this.player.setTexture('bunny-stand-reverse').setScale(0.2);
                this.player.setSize(50/0.2, 65/0.2);
                this.player.setVelocityX(-200); //속도단위
            }
            else if(this.cursor.right.isDown){
                this.player.setTexture('bunny-stand').setScale(0.2);
                this.player.setSize(50/0.2, 65/0.2);
                this.player.setVelocityX(+200);
            } else{
                this.player.setVelocityX(0);
            }
            const onFloor = this.player.body.touching.down;
            
            if(onFloor){
                this.count=0;
            }
            if(Phaser.Input.Keyboard.JustDown(this.cursor.space)&&this.count<2){
                this.player.setVelocityY(-300);
                this.count++;
            }

            if(!onFloor&&this.cursor.right.isDown){
                this.player.setTexture('bunny-jump-reverse').setScale(0.15); 
                 this.player.setSize(50/0.15, 65/0.15);
            }
            else if(!onFloor&&this.cursor.left.isDown){
                this.player.setTexture('bunny-jump').setScale(0.15); 
                this.player.setSize(50/0.15, 65/0.15);
            }
            
            if (this.player.texture.key == 'bunny-stand'&&!onFloor && this.cursor.right.isDown)
            {
                
                this.player.setTexture('bunny-jump-reverse').setScale(0.15); 
                 this.player.setSize(50/0.15, 65/0.15);
    
            }
            else if(this.player.texture.key == 'bunny-stand'&&!onFloor){
                this.player.setTexture('bunny-jump').setScale(0.15); 
                this.player.setSize(50/0.15, 65/0.15);
            }
            

            if ((this.player.texture.key == 'bunny-jump'||this.player.texture.key == 'bunny-jump-reverse')&&onFloor){
                this.player.setTexture('bunny-stand').setScale(0.2);
                this.player.setSize(50/0.2, 65/0.2);
    
            }
    
            this.horizontalWrap(this.player);
    
            const bottomPlatform = this.findBottomMostPlatform()
            if (this.player.y > bottomPlatform.y + 200)
            {
                this.scene.start('GameOver');
            }
    }

   horizontalWrap(sprite)
   {
       const halfWidth = sprite.displayWidth * 0.5;
       const gameWidth = this.scale.width;
       if (sprite.x < -halfWidth)
       {
           sprite.x = gameWidth + halfWidth;
       }
       else if (sprite.x > gameWidth + halfWidth)
       {
           sprite.x = -halfWidth;
       }
   }


   addCarrotAbove(sprite)
   {
       const y = sprite.y - sprite.displayHeight;
       const carrot = this.carrots.get(sprite.x, y, 'carrot');
       carrot.setActive(true);
       carrot.setVisible(true);
       this.add.existing(carrot);
       carrot.body.setSize(carrot.width, carrot.height);
       this.physics.world.enable(carrot);
       return carrot;
   }
	
	addWolf(sprite)
   {
       const y = sprite.y - sprite.displayHeight;
       const wolf = this.wolfs.get(sprite.x, y, 'wolf');
       wolf.setActive(true);
       wolf.setVisible(true);
       wolf.setVelocityX(50);
       wolf.setBounce(1);
       this.add.existing(wolf);
       wolf.body.setSize(50/0.1, 50/0.1);
       this.physics.world.enable(wolf);
       return wolf;
   }

   handleCollectCarrot(player, carrot)
   {
       this.carrots.killAndHide(carrot);
       this.physics.world.disableBody(carrot.body);
       this.carrotsCollected++;
       this.carrotsCollectedText.text = `Carrots: ${this.carrotsCollected}`;
   }

   findBottomMostPlatform()
   {
       const platforms = this.platforms.getChildren();
       let bottomPlatform = platforms[0];

       for (let i = 1; i < platforms.length; ++i)
       {
           const platform = platforms[i];

           if (platform.y < bottomPlatform.y)
           {
               continue;
           }

           bottomPlatform = platform;
       }

       return bottomPlatform;
   }




}