package gamball.ui;
import gamball.entities.Ball;
import gamball.ui.Button.ButtonConfig;
import pixi.core.sprites.Sprite;

class BallButton extends Button
{
	public function new(fileName:String, cost:Int, callback:Void->Void)
	{
		var btnConfig:ButtonConfig =
		{
			width: 180,
			height: 75,
			surfaceColour: 0xFFCE25,
			baseColour: 0xEBA205,
			springHeight: 18,
			cooldown: 0.15
		}
		
		super(btnConfig, callback);
		
		var icon = Sprite.fromImage(Ball.PATH + fileName, false);
		icon.anchor.set(0.5, 0.5);
		icon.scale.set(0.5, 0.5);
		icon.position.set(45, Math.round(btnConfig.height / 2));
		surface.addChild(icon);
		
		var costText = Fonts.getFancyText("£" + CurrencyPanel.getCurrencyFormat(cost), 48, Fonts.CONSOLAS_64_BOLD);
		costText.position.set(125, icon.y);
		surface.addChild(costText);
	}
}