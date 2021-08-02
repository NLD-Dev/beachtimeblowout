package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import openfl.media.Sound;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;
	var bg:FlxSprite;

	var curCharacter:String = '';
	var curSound:String = '';
	var fading:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];
	var kadeEngineWatermark:FlxText;

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;
	var extraPortraits:Array<FlxSprite> = [];
	var extraPortraits2:Array<FlxSprite> = [];
	var CharNames:Array<String> = [
		'katelyn_wow',
		'katelyn_YAY',
		'katelyn_hey',
		'katelyn_ahaha',
	];
	var CharNames2:Array<String> = [
		'bf',
		'gf',
	];
	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'foreshore':
				FlxG.sound.playMusic(Paths.music('music', 'beachtime'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		
		var hasDialog = false;
		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
			// bg.antialiasing = true;
			// bg.setGraphicSize(Std.int(bg.width * 0.6));
			// bg.updateHitbox();
			add(bg);
	
			box = new FlxSprite(40, 345);
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * -0.9));
				box.updateHitbox();

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;



	 if (PlayState.SONG.song.toLowerCase() == 'foreshore')
		{
		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * -0.95));
		box.updateHitbox();
		}
		add(box);

		kadeEngineWatermark = new FlxText(4,FlxG.height * 0.9 + 45,0, "Press space to skip dialogue.", 32);
		kadeEngineWatermark.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		kadeEngineWatermark.scrollFactor.set();
		add(kadeEngineWatermark);



		for (i in 0...CharNames.length)
		{
			var prefix:String = "";
			//var shitList:Array<String> = [];
			var newSprite:FlxSprite = new FlxSprite(box.x, box.y + 100).loadGraphic(Paths.image("dailog/" + CharNames[i], 'beachtime'));
			newSprite.setGraphicSize(Std.int(newSprite.width * 0.5));
			newSprite.screenCenter(Y);
			newSprite.x += 100;
			newSprite.y += 68;
			newSprite.updateHitbox();
			newSprite.scrollFactor.set();
			newSprite.visible = false;
			extraPortraits.push(newSprite);
			add(extraPortraits[i]);
		}

		for (i in 0...CharNames2.length)
		{
			var prefix:String = "";
			//var shitList:Array<String> = [];
			var newSprite2:FlxSprite = new FlxSprite(box.x, box.y + 100);
			newSprite2.frames = Paths.getSparrowAtlas('dailog/' + CharNames2[i] + 'port', 'beachtime');
			newSprite2.setGraphicSize(Std.int(newSprite2.width * 1.2));
			newSprite2.screenCenter(Y);
			newSprite2.x += 600;
			if(CharNames2[i] == 'gf')
			{
				newSprite2.x -= 250;
				newSprite2.animation.addByPrefix('enter', 'gfport', 24, false);
			}else{
				newSprite2.animation.addByPrefix('enter', 'bfport', 24, false);
			}
			newSprite2.y -= 148;
			newSprite2.updateHitbox();
			newSprite2.scrollFactor.set();
			newSprite2.visible = false;
			extraPortraits2.push(newSprite2);
			add(extraPortraits2[i]);
		}



		if (!talkingRight)
		{
			// box.flipX = true;
		}
   if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns' || PlayState.SONG.song.toLowerCase() == 'roses')
		{
		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'Pixel Arial 11 Bold';
		dropText.color = 0xFFD89494;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'Pixel Arial 11 Bold';
		swagDialogue.color = 0xFF3F2021;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);
	    }

		   if (PlayState.SONG.song.toLowerCase() == 'foreshore')
		{
        swagDialogue = new FlxTypeText(240, 460, Std.int(FlxG.width * 0.67), "", 32);
		swagDialogue.font = 'Lampshade';
		swagDialogue.color = FlxColor.BLACK;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.3)];
		add(swagDialogue);
		}

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (FlxG.keys.justPressed.ANY  && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (FlxG.keys.justPressed.SPACE)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'foreshore')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						hidePortraits();
						swagDialogue.alpha -= 1 / 5;
						bg.alpha -= 1 / 5;
						if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns' || PlayState.SONG.song.toLowerCase() == 'roses') 
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						kadeEngineWatermark.alpha -= 1 / 5 * 0.7;
						hidePortraits();
						bg.alpha -= 1 / 5;
						swagDialogue.alpha -= 1 / 5;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				if (!isEnding)
				{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
				}
			}
		}

		super.update(elapsed);
	}

	var isEnding:Bool = false;

		
	function hidePortraits():Void
	{
		for (shit in extraPortraits)
		{
			shit.visible = false;
		}
		for (shit2 in extraPortraits2)
		{
			shit2.visible = false;
		}
	}

	function startDialogue():Void
	{
		var skipdialogue:Bool = false;
		var foundchar:Bool = false;
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		switch (curCharacter)
		{
			case 'noone':
				hidePortraits();
			case 'music':
			if(fading == 'false')
			{
				FlxG.sound.playMusic(Paths.music(curSound, 'dialogue'), 0.6);
				skipdialogue = true;
			}else
			{
				FlxG.sound.playMusic(Paths.music(curSound, 'dialogue'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.6);
				skipdialogue = true;
			}
			case 'stopmusic':
			if(fading == 'false')
			{
				FlxG.sound.music.fadeOut(0, 0);
				skipdialogue = true;
			}else
			{
				FlxG.sound.music.fadeOut(1, 0);
				skipdialogue = true;
			}
		}
		if (CharNames.contains(curCharacter))
		{
			foundchar = true;
			hidePortraits();
			extraPortraits[CharNames.indexOf(curCharacter)].visible = true;
		}
		if (CharNames2.contains(curCharacter))
		{	
			foundchar = true;
			hidePortraits();
			extraPortraits2[CharNames2.indexOf(curCharacter)].visible = true;
			extraPortraits2[CharNames2.indexOf(curCharacter)].animation.play('enter');
		}
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		fading = splitName[2];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + splitName[2].length + 3).trim();
	}
}
