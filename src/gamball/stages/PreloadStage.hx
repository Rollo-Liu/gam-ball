package gamball.stages;
import engine.entities.FancyBitmapText;
import engine.entities.Stage;
import gamball.ui.Fonts;
import motion.Actuate;
import motion.easing.Back;
import motion.easing.Expo;
import motion.easing.Linear;
import pixi.core.graphics.Graphics;

class PreloadStage extends Stage
{
	private var loadingText:FancyBitmapText;
	private var bg:Graphics;
	
	public function new()
	{
		super();
		
		bg = new Graphics();
		bg.beginFill(0x282828);
		// with paddings
		bg.drawRect( -1, -1, GamBall.screenWidth + 2, GamBall.screenHeight + 2);
		bg.endFill();
		addChild(bg);
		
		// Load the fonts first
		Fonts.load(function():Void
		{
			loadingText = Fonts.getFancyText("Loading...", 64, Fonts.CALIBRI_64_BOLD);
			loadingText.x = GamBall.screenWidth * 0.5;
			loadingText.y = GamBall.screenHeight * 0.5;
			loadingText.alpha = 0;
			loadingText.scale.set(0.1);
			
			addChild(loadingText);
			
			Actuate.tween(loadingText, 0.5, {alpha: 1.0}).ease(Linear.easeNone);
			Actuate.tween(loadingText.scale, 0.8, {x: 1.0, y: 1.0}).ease(Back.easeOut).onComplete(loadGameAssets);
		});
	}
	
	private function loadGameAssets():Void
	{
		GameStage.load(function(gameStage:GameStage):Void
		{
			engine.addStage(gameStage, 0);
			onLoadComplete(function():Void
			{
				engine.removeStage(this);
				destroy();
			});
		});
	}
	
	private function onLoadComplete(onAnimationComplete:Void->Void):Void
	{
		Actuate.tween(loadingText, 0.5, {alpha: 0}).ease(Linear.easeNone);
		Actuate.tween(bg, 0.5, {alpha: 0}).ease(Linear.easeNone);
		Actuate.tween(loadingText.scale, 0.8, {x: 2.5, y: 2.5}).ease(Expo.easeOut).onComplete(onAnimationComplete);
	}
	
	override public function destroy():Void 
	{
		loadingText.destroy();
		super.destroy();
	}
}