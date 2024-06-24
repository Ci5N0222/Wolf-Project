class GameOver extends Phaser.Scene{

    constructor(){
        super({key:"GameOver"});
    }
    preload(){

    }

    create(data){
        const width = this.scale.width
		const height = this.scale.height

		this.add.text(width * 0.5, height * 0.5, 'Game Over', {
			fontSize: 48
		})
		.setOrigin(0.5)

		this.input.keyboard.once('keydown-SPACE', () => {
			this.scene.start('Project')
		})
		
		gameScoreSave(data.score);
        
    }

    update(){

    }

   


}

