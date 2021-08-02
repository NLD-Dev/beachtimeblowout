package;

import flixel.FlxSprite;

class HealthIcon extends FlxSprite
{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		switch(char)
		{
			case 'bf' | 'katelyn':
				loadGraphic(Paths.image('iconsKatelyn', 'beachtime'), true, 150, 150);

				antialiasing = true;
				animation.add('bf', [0,1], 0, false, isPlayer);
				animation.add('katelyn', [2,3], 0, false, isPlayer);
				animation.play(char);


			default:
				loadGraphic(Paths.image('iconGrid'), true, 150, 150);

				antialiasing = true;
				animation.add('dad', [12, 13], 0, false, isPlayer);
				animation.add('gf', [16], 0, false, isPlayer);
				animation.play(char);
		}

		switch(char)
		{
			case 'bf-pixel' | 'senpai' | 'senpai-angry' | 'spirit' | 'gf-pixel':
				antialiasing = false;
		}

		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}
