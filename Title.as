//David Klatch C490 Final Project
package{
	import flash.display.Sprite;
	import flash.display.BitmapData;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.text.*
	
	public class Title 
	{
		var theParent;
		var theBMP, bmpArray, titleTheBMP, titleFinalBMP, titleProjectBMP, titleNameBMP, titleEnterBMP;
		var TheSpr, FinalSpr, ProjectSpr, NameSpr, EnterSpr;
		var theTimer, finalTimer, projectTimer, nameTimer, continueTimer;
		var theSound, Enter;
		
		public function Title(par)
		{
			theParent = par;
			theSound = new titleSound();
			Enter = 13;
			titleTheBMP = new THEbmp();
			titleFinalBMP = new FINALbmp();
			titleProjectBMP = new PROJECTbmp();
			titleNameBMP = new NAMEbmp();
			titleEnterBMP = new ENTERbmp();
			bmpArray = new Array(titleTheBMP, titleFinalBMP, titleProjectBMP, titleNameBMP, titleEnterBMP);
			theTimer = new Timer(1);
			finalTimer = new Timer(1);
			projectTimer = new Timer(1);
			nameTimer = new Timer(1);
			continueTimer = new Timer(2);
			theTimer = new Timer(1000);
			finalTimer = new Timer(1000);
			projectTimer = new Timer(1000);
			nameTimer = new Timer(1500);
			continueTimer = new Timer(2000);
			theTimer.addEventListener(TimerEvent.TIMER,displayThe);
			finalTimer.addEventListener(TimerEvent.TIMER,displayFinal);
			projectTimer.addEventListener(TimerEvent.TIMER,displayProject);
			nameTimer.addEventListener(TimerEvent.TIMER,displayName);
			continueTimer.addEventListener(TimerEvent.TIMER,displayContinue);
			
			TheSpr = makeSprite(bmpArray[0], 175, 80);
			theParent.stage.addChild(TheSpr);
			FinalSpr = makeSprite(bmpArray[1], 400, 150);
			theParent.stage.addChild(FinalSpr);
			ProjectSpr = makeSprite(bmpArray[2], 580, 170);
			theParent.stage.addChild(ProjectSpr);
			NameSpr = makeSprite(bmpArray[3], 400, 125);
			theParent.stage.addChild(NameSpr);
			EnterSpr = makeSprite(bmpArray[4], 400, 125);
			theParent.stage.addChild(EnterSpr);
			theTimer.start();
		}
				
		static public function makeSprite(bmpName, w, h)
		{
			var theSprite = new Sprite();
			theSprite.graphics.beginBitmapFill(bmpName);
			theSprite.graphics.drawRect(0, 0, w, h);
			theSprite.graphics.endFill();
			theSprite.visible = false;
			return theSprite;
		}
		
		static public function makeTextBox()
		{
			var countDownShow = new TextField();
			countDownShow.x = 0;
			countDownShow.y = 0;
			countDownShow.width = 125;
			countDownShow.height = 50;
			var format:TextFormat = new TextFormat();
			format.font = "Arial";
			format.color = 0x000000;
			format.size = 48;
			countDownShow.defaultTextFormat = format;
			return countDownShow;
		}
		
		function displayThe(ev:TimerEvent)
		{
			theTimer.stop();
			TheSpr.x = theParent.stage.stageWidth/2-TheSpr.width/2-15;
			TheSpr.y = 0;
			TheSpr.visible = true;
			theSound.play();
			finalTimer.start();
		}
		
		function displayFinal (ev:TimerEvent)
		{
			finalTimer.stop();
			FinalSpr.x = theParent.stage.stageWidth/2-FinalSpr.width/2;
			FinalSpr.y = theParent.stage.stageHeight/2-FinalSpr.height-10;
			FinalSpr.visible = true;
			theSound.play();
			projectTimer.start();
		}
		
		function displayProject (ev:TimerEvent)
		{
			projectTimer.stop();
			ProjectSpr.x = theParent.stage.stageWidth/2-ProjectSpr.width/2;
			ProjectSpr.y = theParent.stage.stageHeight-ProjectSpr.height-85;
			ProjectSpr.visible = true;
			theSound.play();
			nameTimer.start();
		}
		
		function displayName (ev:TimerEvent)
		{
			nameTimer.stop();
			NameSpr.x = theParent.stage.stageWidth/2-NameSpr.width/2;
			NameSpr.y = theParent.stage.stageHeight-NameSpr.height-5;
			NameSpr.visible = true;
			theSound.play();
			continueTimer.start();
		}
		
		function displayContinue (ev:TimerEvent)
		{
			continueTimer.stop();
			NameSpr.visible = false;
			EnterSpr.x = theParent.stage.stageWidth/2-EnterSpr.width/2;
			EnterSpr.y = theParent.stage.stageHeight-EnterSpr.height-5;
			EnterSpr.visible = true;
			theParent.stage.addEventListener(KeyboardEvent.KEY_DOWN, removeStage1)
			theSound.play();
		}
		
		function removeStage1(ev:KeyboardEvent)
		{
			if (ev.keyCode == Enter)
			{
				TheSpr.visible = false;
				FinalSpr.visible = false;
				ProjectSpr.visible = false;
				NameSpr.visible = false;
				EnterSpr.visible = false;
				theParent.stage.removeChild(TheSpr);
				theParent.stage.removeChild(FinalSpr);
				theParent.stage.removeChild(ProjectSpr);
				theParent.stage.removeChild(NameSpr);
				theParent.stage.removeChild(EnterSpr);
				theParent.stage.removeEventListener(KeyboardEvent.KEY_DOWN, removeStage1);
				theParent.gotoAndStop(1, "Scene 2"); 
			}
		}
	}
}