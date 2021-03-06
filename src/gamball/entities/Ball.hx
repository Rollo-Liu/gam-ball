package gamball.entities;
import engine.entities.PhysicObject;
import gamball.entities.Ball.BallConfig;
import nape.geom.Vec2;
import nape.phys.BodyType;
import nape.phys.Material;
import nape.shape.Circle;
import pixi.core.sprites.Sprite;

class Ball extends PhysicObject
{
	static public inline var PATH:String = "assets/textures/sprites/";
	static public inline var BALL_RADIUS:Int = 40;
	static public inline var BALL_CANDY_ID:String = "candy";
	static public inline var BALL_8_ID:String = "8";
	static public inline var BALL_POKEMON_ID:String = "pokemon";
	
	public var id(default, null):String;
	public var config(default, null):BallConfig;
	public var isDone(default, default):Bool = false;
	
	private var sprite:Sprite;
	
	public function new(x:Float, y:Float, id:String, config:BallConfig)
	{
		super(BodyType.DYNAMIC, Vec2.get(x, y));
		this.id = id;
		this.config = config;
		
		body.shapes.add(new Circle(BALL_RADIUS, null, Material.wood()));
		body.allowRotation = true;
		body.allowMovement = true;
		body.space = physics.worldSpace;
		
		sprite = Sprite.fromImage(PATH + config.texture, false);
		sprite.anchor.set(0.5, 0.5);
		sprite.scale.set(BALL_RADIUS * 2.0 / 128);
		addChild(sprite);
		
		#if debug
		addDebugDraw();
		#end
	}
	
	override private function addDebugDraw():Void 
	{
		super.addDebugDraw();
		debugDraw.lineStyle(2, 0x6CFDCE);
		debugDraw.drawCircle(0, 0, BALL_RADIUS);
		debugDraw.lineStyle(2, 0xFF402B);
		debugDraw.moveTo(0, 0);
		debugDraw.lineTo(BALL_RADIUS, 0);
		debugDraw.drawCircle(0, 0, 3);
	}
}

typedef BallConfig =
{
	var id:String;
	var texture:String;
	var cost:Int;
	var bonus:Int;
}