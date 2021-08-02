package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import openfl.Lib;

class E extends MusicBeatState
{
	public static var leftState:Bool = false;

	public static var needVer:String = "IDFK LOL";
	public static var currChanges:String = "dk";
	var txt:FlxText;
	
	private var bgColors:Array<String> = [
		'#314d7f',
		'#4e7093',
		'#70526e',
		'#594465'
	];
	private var colorRotation:Int = 1;

	override function create()
	{
		super.create();
		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('week54prototype', 'shared'));
		bg.scale.x *= 1.55;
		bg.scale.y *= 1.55;
		bg.screenCenter();
		add(bg);
		
		var kadeLogo:FlxSprite = new FlxSprite(FlxG.width, 0).loadGraphic(Paths.image('KadeEngineLogo'));
		kadeLogo.scale.y = 0.3;
		kadeLogo.scale.x = 0.3;
		kadeLogo.x -= kadeLogo.frameHeight;
		kadeLogo.y -= 180;
		kadeLogo.alpha = 0.8;
		//add(kadeLogo);
		var kadeLogoW:FlxSprite = new FlxSprite(FlxG.width, 0).loadGraphic(Paths.image('katelyn_bg_text', 'beachtime'));
		kadeLogoW.screenCenter();
		kadeLogoW.scale.y = 0.6;
		kadeLogoW.scale.x = 0.6;
		add(kadeLogoW);
		
		txt = new FlxText(0, 0, FlxG.width,
			"Hello again! Thank you for playing \n this mod! "
			+ "\n If you recorded this,"
			+ "\n Hi Youtube or Twitch!"
			+ "\n Why did i do this"
			+ "\n\n Made by NLD, Tori, \n Puppyrelp and Mike Geno."
			+ "\n\n Also, Check out the ghosttwins when that fully comes out!! \n Demo rn out",
			32);
		
		txt.setFormat("VCR OSD Mono", 32, FlxColor.fromRGB(200, 200, 200), CENTER);
		txt.borderColor = FlxColor.BLACK;
		txt.borderSize = 3;
		txt.borderStyle = FlxTextBorderStyle.OUTLINE;
		txt.screenCenter();
		add(txt);
		
		FlxTween.color(bg, 2, bg.color, FlxColor.fromString(bgColors[colorRotation]));
		FlxTween.angle(kadeLogo, kadeLogo.angle, -10, 2, {ease: FlxEase.quartInOut});
		
		new FlxTimer().start(2, function(tmr:FlxTimer)
		{
			FlxTween.color(bg, 2, bg.color, FlxColor.fromString(bgColors[colorRotation]));
			if(colorRotation < (bgColors.length - 1)) colorRotation++;
			else colorRotation = 0;
		}, 0);
		
		new FlxTimer().start(2, function(tmr:FlxTimer)
		{
			if(kadeLogo.angle == -10) FlxTween.angle(kadeLogo, kadeLogo.angle, 10, 2, {ease: FlxEase.quartInOut});
			else FlxTween.angle(kadeLogo, kadeLogo.angle, -10, 2, {ease: FlxEase.quartInOut});
		}, 0);
		
		new FlxTimer().start(0.8, function(tmr:FlxTimer)
		{
			if(kadeLogo.alpha == 0.8) FlxTween.tween(kadeLogo, {alpha: 1}, 0.8, {ease: FlxEase.quartInOut});
			else FlxTween.tween(kadeLogo, {alpha: 0.8}, 0.8, {ease: FlxEase.quartInOut});
		}, 0);
	}

	override function update(elapsed:Float)
	{
		if (controls.ACCEPT)
		{
			leftState = true;
			FlxTween.tween(txt, {alpha: 0}, 0.8, {ease: FlxEase.quartInOut});
			new FlxTimer().start(1.2, function(tmr:FlxTimer)
			{
				fancyOpenURL("https://sites.google.com/view/than-k-for-play/homepage");
				new FlxTimer().start(1.2, function(tmr:FlxTimer)
				{
					Lib.application.window.close();
				}); 
			});
		}
		if (controls.BACK)
		{
			leftState = true;
			FlxTween.tween(txt, {alpha: 0}, 0.8, {ease: FlxEase.quartInOut});
			new FlxTimer().start(1.2, function(tmr:FlxTimer)
			{
				fancyOpenURL("https://sites.google.com/view/than-k-for-play/homepage");
				new FlxTimer().start(1.2, function(tmr:FlxTimer)
				{
					Lib.application.window.close();
				});
			});
			
		}
		super.update(elapsed);
	}
}
