package;

import flixel.addons.display.FlxStarField.FlxStarField2D;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;

class DifficultyInfo extends MusicBeatState
{
	public static var leftStateWarn:Bool = false;
	
	private var bgColors:Array<String> = [
		'#314d7f',
		'#4e7093',
		'#70526e',
		'#594465'
	];
	private var colorRotation:Int = 1;

	override function create()
	{
                Paths.clearUnusedMemory();
                Paths.clearStoredMemory();
		super.create();
		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuPNG'));
		bg.scale.x *= 2;
		bg.scale.y *= 2;
		bg.screenCenter();
		add(bg);

                FlxG.mouse.visible = false;

		var difficInfo:FlxSprite = new FlxSprite().loadGraphic(Paths.image('difficulty_explanation'));
		difficInfo.scale.x *= 0.8;
		difficInfo.scale.y *= 0.8;
		difficInfo.screenCenter();
		add(difficInfo);
		
		#if mobileC var txt:FlxText = new FlxText(0, 0, FlxG.width, "Press A to Proceed, Press B to go Back.\n"); #elseif mobileCweb var txt:FlxText = new FlxText(0, 0, FlxG.width, "Press Enter/A to Proceed, Press Backspace/Escape/B to go Back.\n"); #elseif (!mobileC || !mobileCweb) var txt:FlxText = new FlxText(0, 0, FlxG.width, "Press Enter to Proceed, Press Backspace/Escape to go Back.\n"); #end
		
		txt.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.fromRGB(200, 200, 200), CENTER);
		txt.borderColor = FlxColor.BLACK;
		txt.borderSize = 3;
		txt.borderStyle = FlxTextBorderStyle.OUTLINE;
		txt.screenCenter();
		txt.y += 340;
		add(txt);
		
		FlxTween.color(bg, 2, bg.color, FlxColor.fromString(bgColors[colorRotation]));
		
		new FlxTimer().start(2, function(tmr:FlxTimer)
		{
			FlxTween.color(bg, 2, bg.color, FlxColor.fromString(bgColors[colorRotation]));
			if(colorRotation < (bgColors.length - 1)) colorRotation++;
			else colorRotation = 0;
		}, 0);

                #if (mobileC || mobileCweb) addVirtualPad(NONE, A_B); #end
	}

	override function update(elapsed:Float)
	{
		if (controls.BACK)
		{
			leftStateWarn = true;
			FlxG.switchState(new MainMenuState());
		}
		else if (controls.ACCEPT)
		{
			leftStateWarn = true;
			FlxG.switchState(new FreeplayState());
		}
		super.update(elapsed);
	}
}
