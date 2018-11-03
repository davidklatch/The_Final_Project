//David Klatch C490 Final Project
package
{
	import Title;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLLoader;
    import flash.net.URLRequest;
	
	public class Level3
	{
		var sightBMP, sightSprite, theParent, sightX, sightY;
		var title1Bmp, title1Sprite, title2Bmp, title2Sprite, title3Bmp, title3Sprite, title4Bmp, title4Sprite;
		var title1Timer, title2Timer, title3Timer, title4Timer;
		var enemyBmps, enemySprites, enemiesSpeed, enemiesStartY,numEnemies;
		var enemiesX, enemiesY, enemyTimer, enemiesRand, enemiesCount;
		var rowBmp, rowSprites, rowsX, rowsY,numRows;
		var scoreBox, score, scoreLimit;
		var keyboardBmp, keyboardSprite, keyboardY, foundKB;
		var endLvlTimer, endLvlSound;
		var kbTmpBmp, kbTmpSprite, kbTmpY, kbTmpStop, kbTmpTimer;
		var barBmp, barSprite, thingyBmp, thingySprite, thingyX;
		var hookBmp, hookSprite, hookY, hookX, hookStartY, hookSpeed, hookTimer, hookMoving, hookNoise, hookNoiseOn;
		var LCode,RCode,SpaceCode,Left,Right,Space, clawTimer, spaceCount;
		var dropClawTimer, raiseClawTimer;
		var raiseKBTimer, raiseKBSound;
		var mmBmp, mmSprite, mmY;
		var leftBmp, leftSprite, rightBmp, rightSprite, spaceBmp, spaceSprite;
		var fadeKB1Bmp, fadeKB1Sprite, fadeKB2Bmp, fadeKB2Sprite, fadeKB3Bmp, fadeKB3Sprite, fadeKB4Bmp, fadeKB4Sprite;
		var fadeMM1Bmp, fadeMM1Sprite, fadeMM2Bmp, fadeMM2Sprite, fadeMM3Bmp, fadeMM3Sprite, fadeMM4Bmp, fadeMM4Sprite;
		var fade1Timer, fade2Timer, fade3Timer, fade4Timer;
		var endScreenTimer;
		var finalSprite, finaltxt1Sprite, finaltxt2Sprite;
		var nextSceneTimer;
		var hitNoise, missNoise;
		var sndChannel:SoundChannel;
		var bgNoise, bgSoundChannel:SoundChannel;
		
		public function Level3(par)
		{
			var i=0;
			theParent = par;
			theParent.stage.color = 0x000000;
			
			LCode = 37;
			RCode = 39;
			SpaceCode = 32;
			Left = false;
			Right = false;
			Space = false;
			spaceCount = 0;
			clawTimer = new Timer(30);
			clawTimer.addEventListener(TimerEvent.TIMER,moveClaw);
						
			hitNoise = new hitSound();
			missNoise = new missSound();
			sndChannel = new SoundChannel();
					
			bgNoise = new BG3Sound();
			bgSoundChannel = new SoundChannel();			
			
			sightBMP = new sightBmp();
			title1Timer = new Timer(1000);
			title2Timer = new Timer(1000);
			title3Timer = new Timer(1000);
			title4Timer = new Timer(1000);
			title1Timer.addEventListener(TimerEvent.TIMER, preLevel);
			title2Timer.addEventListener(TimerEvent.TIMER, title2);
			title3Timer.addEventListener(TimerEvent.TIMER, title3);
			title4Timer.addEventListener(TimerEvent.TIMER, title4);
			
			numEnemies = 9;
			enemyBmps = new Array;
			enemySprites = new Array;
			enemiesX = new Array;
			enemiesY = new Array;
			enemiesSpeed = new Array;
			enemiesStartY = new Array;
			
			enemyBmps[0] = new LEVEL3enemy1Bmp;
			enemyBmps[1] = new LEVEL3enemy2Bmp;
			enemyBmps[2] = new LEVEL3enemy3Bmp;
			enemyBmps[3] = new LEVEL3enemy4Bmp;
			enemyBmps[4] = new LEVEL3enemy5Bmp;
			enemyBmps[5] = new LEVEL3enemy6Bmp;
			enemyBmps[6] = new LEVEL3enemy7Bmp;
			enemyBmps[7] = new LEVEL3enemy8Bmp;
			enemyBmps[8] = new LEVEL3enemy9Bmp;
						
			enemiesRand = new Array;
			enemiesCount = new Array;
			
			var rnd;
			for (i=0; i<numEnemies; i++)
			{
				rnd = Math.random()*numEnemies+1;
				if (rnd < numEnemies/2)
					enemiesRand[i] = 1;
				else
					enemiesRand[i] = Math.random()*100;
					
				enemiesCount[i] = 0;
				
				enemiesSpeed[i] = Math.random()*0.5+0.5;
				if (i % 3 == 0)
				{
					enemiesX[i] = 80;
				}
				else if (i % 3 == 1)
				{ 
					enemiesX[i] = 275;
				}
				else
				{
					enemiesX[i] = 465;
				}
				
				if (i <= 2)
				{
					enemiesStartY[i] = 80;
					enemiesY[i] = enemiesStartY[i];
				}
				else if (i >= 3 && i <= 5)
				{
					enemiesStartY[i] = 80 + 145;
					enemiesY[i] = enemiesStartY[i];
				}
				else
				{
					enemiesStartY[i] = 80 + 2*145; 
					enemiesY[i] = enemiesStartY[i];
				}
				enemySprites[i] = Title.makeSprite(enemyBmps[i], enemyBmps[i].width, enemyBmps[i].height);
				theParent.stage.addChild(enemySprites[i]);
				placeEnemy(i);
			}
			
			enemyTimer = new Timer(20);
			enemyTimer.addEventListener(TimerEvent.TIMER, moveEnemies);
			
			raiseKBSound = new mainmanAndKBSound();
			keyboardBmp = new LEVEL3keyboardBmp();
			kbTmpTimer = new Timer(20);
			kbTmpTimer.addEventListener(TimerEvent.TIMER, movekbTmp);
			
			endLvlSound = new foundKBSound();
			endLvlTimer = new Timer(2000);
			endLvlTimer.addEventListener(TimerEvent.TIMER, pauseForKbTmp);
			
			hookMoving = false;
			hookTimer = new Timer(500);
			hookTimer.addEventListener(TimerEvent.TIMER, setupHook);
						
			dropClawTimer = new Timer(20);
			dropClawTimer.addEventListener(TimerEvent.TIMER, dropClaw);
			raiseClawTimer = new Timer(20);
			raiseClawTimer.addEventListener(TimerEvent.TIMER, raiseClaw);
			raiseKBTimer = new Timer(20);
			raiseKBTimer.addEventListener(TimerEvent.TIMER, raiseKeyboard);
			foundKB = false;
			
			fade1Timer = new Timer(500);
			fade1Timer.addEventListener(TimerEvent.TIMER, fade1);
			fade2Timer = new Timer(500);
			fade2Timer.addEventListener(TimerEvent.TIMER, fade2);
			fade3Timer = new Timer(500);
			fade3Timer.addEventListener(TimerEvent.TIMER, fade3);
			fade4Timer = new Timer(500);
			fade4Timer.addEventListener(TimerEvent.TIMER, fade4);
			
			endScreenTimer = new Timer (750);
			endScreenTimer.addEventListener(TimerEvent.TIMER, endScreen);
			nextSceneTimer = new Timer(6000);
			nextSceneTimer.addEventListener(TimerEvent.TIMER, nextscene);
			
			numRows = 3;
			rowBmp = new LEVEL3rowBmp();
			rowSprites = new Array;
			for (i=0; i<numRows; i++)
			{
				rowSprites[i] = Title.makeSprite(rowBmp,rowBmp.width, rowBmp.height);
				theParent.stage.addChild(rowSprites[i]);
				rowSprites[i].x = 0;
				rowSprites[i].y = 80 + i*145;
			}
			
			score = 0;
			scoreLimit = 10;
			scoreBox = Title.makeTextBox();
			scoreBox.x = theParent.stage.stageWidth/2-scoreBox.width/2;
			scoreBox.y = theParent.stage.stageHeight-1.1*scoreBox.height;
			scoreBox.text = score + "/" + scoreLimit;
			
			sightSprite = Title.makeSprite(sightBMP,80,80);
			theParent.stage.addChild(sightSprite);
			sightSprite.x = theParent.stage.stageWidth/2-sightSprite.width/2+10;
			sightSprite.y = theParent.stage.stageHeight/2+25-sightSprite.height/2+10;
			sightSprite.addEventListener(MouseEvent.CLICK, checkHit);
						
			title1Timer.start();
		}
		
		function preLevel(ev:TimerEvent)
		{
			title1Bmp = new LEVEL3title1Bmp();
			title1Sprite = Title.makeSprite(title1Bmp,400,100);
			theParent.stage.addChild(title1Sprite);
			title1Sprite.x = theParent.stage.stageWidth/6;
			title1Sprite.y = 10;
			title1Sprite.visible = true;
			
			title2Timer.start();
			title1Timer.stop();
		}
		
		function title2 (ev:TimerEvent)
		{
			title2Bmp = new LEVEL3title2Bmp();
			title2Sprite = Title.makeSprite(title2Bmp,400,100);
			theParent.stage.addChild(title2Sprite);
			title2Sprite.x = theParent.stage.stageWidth/6;
			title2Sprite.y = theParent.stage.stageHeight-title2Sprite.height-10;
			title2Sprite.visible = true;
			
			title3Timer.start();
			title2Timer.stop();
		}
		
		function title3 (ev:TimerEvent)
		{			
			title3Bmp = new LEVEL3dotBmp();
			title3Sprite = Title.makeSprite(title3Bmp,20,20);
			theParent.stage.addChild(title3Sprite);
			title3Sprite.x = theParent.stage.stageWidth/2;
			title3Sprite.y = theParent.stage.stageHeight/2+25;
			title3Sprite.visible = true;
			
			title4Timer.start();
			title3Timer.stop();
		}
		
		function title4 (ev:TimerEvent)
		{			
			title4Bmp = new LEVEL3clickhereBmp();
			title4Sprite = Title.makeSprite(title4Bmp,200,100);
			theParent.stage.addChild(title4Sprite);
			title4Sprite.x = theParent.stage.stageWidth/3;
			title4Sprite.y = theParent.stage.stageHeight/3;
			title4Sprite.visible = true;
			title3Sprite.addEventListener(MouseEvent.CLICK, startLevel);
			title4Timer.stop();
		}
		
		function startLevel(ev:MouseEvent)
		{
			theParent.stage.color = 0xFFFFFF;
			theParent.stage.removeChild(title1Sprite);
			theParent.stage.removeChild(title2Sprite);
			theParent.stage.removeChild(title3Sprite);
			theParent.stage.removeChild(title4Sprite);
			
			bgSoundChannel = bgNoise.play(0,5);
			
			sightSprite.visible = true;
			Mouse.hide();
			theParent.stage.addEventListener(MouseEvent.MOUSE_MOVE, moveSight);
			for (var i=0; i<numEnemies; i++)
			{
				enemySprites[i].visible = true;
			}
			
			for (i=0; i<numRows; i++)
			{
				rowSprites[i].visible = true;
			}			
			theParent.stage.addChild(scoreBox);
			scoreBox.visible = true;
			
			enemyTimer.start();
		}
		
		function moveEnemies (ev:TimerEvent)
		{
			for (var i=0 ; i<numEnemies; i++)
			{
				if (enemiesCount[i] > enemiesRand[i])
				{
					if (enemiesY[i] > enemiesStartY[i]-enemyBmps[i].height)
					{
						enemiesY[i] -= enemiesSpeed[i];
					}
					else
					{
						enemiesY[i] = enemiesStartY[i];
						enemiesCount[i] = 0;
						enemiesRand[i] = Math.random()*200+100;
					}
					placeEnemy(i);
					
				}
				else
				{
					enemiesCount[i] += 1;
				}
			}
		}
		
		function placeEnemy(i)
		{				
			enemySprites[i].x = enemiesX[i];
			enemySprites[i].y = enemiesY[i];
		}
		
		function moveSight(ev:MouseEvent)
		{
			sightX = ev.stageX;
			sightX -= sightSprite.width/2;
			sightSprite.x = sightX;
			sightY = ev.stageY;
			sightY -= sightSprite.height/2;
			sightSprite.y = sightY;
		}
		
		function checkHit (ev:MouseEvent)
		{
			var whichRow;
			var won = false;
			var noHit = true;
			
			for (var i=0; i<9; i++)
			{				
				if (i < 3)
					whichRow = 0;
				else if (i >= 3 && i <= 5)
					whichRow = 1;
				else 
					whichRow = 2;
				
				if (ev.stageX >= enemiesX[i] && ev.stageX <= enemiesX[i] + enemyBmps[i].width 
					&& ev.stageY >= enemiesY[i] && ev.stageY <= enemiesY[i] + enemyBmps[i].height
					&& ev.stageY < rowSprites[whichRow].y)
				{
					noHit = false;
					hitNoise.play();
					enemiesY[i] = enemiesStartY[i];
					placeEnemy(i);
					enemiesRand[i] = Math.random()*200+100;
					enemiesCount[i] = 0;
					score++;
					scoreBox.text = score + "/" + scoreLimit;
					if (score >= scoreLimit)
					{
						removeEnemiesRowsAndSight();
						won = true;
						break;
					}
				}
			}
			
			if(noHit)
			{
				missNoise.play();
			}
			
			if (won)
			{
				bgSoundChannel.stop();
				kbTmpBmp = new LEVEL3kbtmpBmp();
				kbTmpSprite = Title.makeSprite(kbTmpBmp,kbTmpBmp.width,kbTmpBmp.height);
				kbTmpSprite.x = 273;
				kbTmpY = 80 + 2*145;
				kbTmpSprite.y = kbTmpY;
				kbTmpStop = 80 + 2*145 - (keyboardBmp.height - rowBmp.height);
				theParent.stage.removeChild(rowSprites[numRows-1]);
				theParent.stage.addChild(kbTmpSprite);
				theParent.stage.addChild(rowSprites[numRows-1]);
				kbTmpSprite.visible = true;
				endLvlTimer.start();
			}
		}
		
		function movekbTmp(ev:TimerEvent)
		{
			if (kbTmpY > kbTmpStop)
			{
				kbTmpY -= 0.5;
				kbTmpSprite.y = kbTmpY;
			}
			else
			{
				theParent.stage.removeChild(kbTmpSprite);
				endLevel();
				kbTmpTimer.stop();
			}
		}
		
		function pauseForKbTmp (ev:TimerEvent)
		{
			endLvlTimer.stop();
			endLvlSound.play();
			kbTmpTimer.start();
		}
		
		function removeEnemiesRowsAndSight()
		{
			for (var i=0; i<numEnemies; i++)
			{
				theParent.stage.removeChild(enemySprites[i]);
			}
			for (i=0; i<numRows-1; i++)
			{
				theParent.stage.removeChild(rowSprites[i]);
			}
			theParent.stage.removeChild(scoreBox);
			sightSprite.removeEventListener(MouseEvent.CLICK, checkHit);
			theParent.stage.removeChild(sightSprite);
			Mouse.show();
		}
		
		function endLevel()
		{			
			mmBmp = new LEVEL3MMBmp();
			mmSprite = Title.makeSprite(mmBmp, mmBmp.width, mmBmp.height);
			mmY = rowSprites[numRows-1].y;
			mmSprite.y = mmY;
			
			keyboardSprite = Title.makeSprite(keyboardBmp,keyboardBmp.width,keyboardBmp.height);
			keyboardSprite.x = 273;
			keyboardY = 80 + 2*145 - (keyboardBmp.height - rowBmp.height);
			keyboardSprite.y = keyboardY;
			theParent.stage.removeChild(rowSprites[numRows-1]);
			theParent.stage.addChild(keyboardSprite);
			keyboardSprite.visible = true;
			mmSprite.x = 273 + keyboardBmp.width/2 - 3;
			theParent.stage.addChild(mmSprite);
			theParent.stage.addChild(rowSprites[numRows-1]);
			hookTimer.start();
		}
		
		function setupHook (ev:TimerEvent)
		{
			hookTimer.stop();
			barBmp = new LEVEL3barBmp();
			barSprite = Title.makeSprite(barBmp, barBmp.width, barBmp.height);
			barSprite.x = 0;
			barSprite.y = 0;
			theParent.stage.addChild(barSprite);
			barSprite.visible = true;
			thingyBmp = new LEVEL3barSquareBmp();
			thingySprite = Title.makeSprite(thingyBmp,thingyBmp.width,thingyBmp.height);
			thingyX = theParent.stage.stageWidth - 50;
			thingySprite.x = thingyX;
			theParent.stage.addChild(thingySprite);
			thingySprite.visible = true;
			hookSpeed = 5;
			hookBmp = new LEVEL3hookBmp();
			hookSprite = Title.makeSprite(hookBmp,hookBmp.width,hookBmp.height);
			hookY = -1*200;
			hookSprite.y = hookY;
			hookStartY = hookY;
			hookX = theParent.stage.stageWidth - 50;
			hookSprite.x = hookX;
			theParent.stage.addChild(hookSprite);
			hookSprite.visible = true;

			var req:URLRequest = new URLRequest("level3Sounds/hookmp3.mp3");
            hookNoise = new Sound();
			hookNoise.load(req);
			//hookNoise = new hookSound();
			hookNoiseOn = false;

			leftBmp = new LEVEL3leftBmp();
			leftSprite = Title.makeSprite(leftBmp, leftBmp.width,leftBmp.height);
			leftSprite.x = 10;
			leftSprite.y = 300;
			theParent.stage.addChild(leftSprite);
			leftSprite.visible = true;
			rightBmp = new LEVEL3rightBmp();
			rightSprite = Title.makeSprite(rightBmp, rightBmp.width,rightBmp.height);
			rightSprite.x = 35;
			rightSprite.y = 300;
			theParent.stage.addChild(rightSprite);
			rightSprite.visible = true;
			spaceBmp = new LEVEL3spaceBmp();
			spaceSprite = Title.makeSprite(spaceBmp, spaceBmp.width,spaceBmp.height);
			spaceSprite.x = 10;
			spaceSprite.y = 322;
			theParent.stage.addChild(spaceSprite);
			spaceSprite.visible = true;
			
			theParent.stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
			theParent.stage.addEventListener(KeyboardEvent.KEY_UP, KeyUp);
			clawTimer.start();
		}
		
		function KeyDown(ev:KeyboardEvent)
		{
			switch (ev.keyCode)
			{
				case LCode:
					if (!hookNoiseOn)
					{
						hookNoiseOn = true;
						sndChannel = hookNoise.play();
					}
					Left = true;
					break;
				case RCode:
					if (!hookNoiseOn)
					{
						hookNoiseOn = true;
						sndChannel = hookNoise.play();
					}
					Right = true;
					break;
				case SpaceCode:
					hookNoiseOn = false;
					sndChannel.stop();
					if (!hookMoving)
					{
						dropClawTimer.start();
					}
					hookMoving = true;
					if (spaceCount == 0)
					{
						spaceCount++;
						removeHint();
					}
					break;
			}
		}
		
		function KeyUp(ev:KeyboardEvent)
		{
			switch (ev.keyCode)
			{
				case LCode:
					hookNoiseOn = false;
					sndChannel.stop();
					Left = false;
					break;
				case RCode:
					hookNoiseOn = false;
					sndChannel.stop();
					Right = false;
					break;
			}
		}
		
		function moveClaw (ev:TimerEvent)
		{
			
			if (Left && !hookMoving)
			{
				
				if (hookX - hookSpeed >= 0)
				{
					hookX -= hookSpeed;
					thingyX -= hookSpeed;
				}
			}
			else if (Right && !hookMoving)
			{
				
				if (hookX + hookSpeed <= theParent.stage.stageWidth - hookBmp.width)
				{
					hookX += hookSpeed;
					thingyX += hookSpeed;
				}
			}
			placeClaw();
		}
		
		function placeClaw()
		{
			hookSprite.x = hookX;
			hookSprite.y = hookY;
			
			thingySprite.x = thingyX;
		}
		
		function dropClaw (ev:TimerEvent)
		{
			hookNoiseOn = false;
			sndChannel.stop();
			if (hookY + hookBmp.height <= 323 + 15)
			{
				hookY += hookSpeed;
				placeClaw();
			}
			else
			{
				dropClawTimer.stop();
				if (gotKB())
				{
					theParent.stage.removeEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
					theParent.stage.removeEventListener(KeyboardEvent.KEY_UP, KeyUp);
					raiseKBSound.play();
					hookSpeed = 1;
					mmSprite.visible = true;
					foundKB = true;
					raiseKBTimer.start();
				}
				raiseClawTimer.start();
				
			}
		}
		
		function gotKB ()
		{
			if (hookX >= keyboardSprite.x - hookBmp.width/1.5 && hookX <= keyboardSprite.x + keyboardBmp.width - hookBmp.width/2)
			{
				return true;
			}
			return false;
		}
		
		function raiseClaw (ev:TimerEvent)
		{
			hookNoiseOn = false;
			sndChannel.stop();
			if (hookY >= hookStartY)
			{
				hookY -= hookSpeed;
				placeClaw();
			}
			else
			{
				hookMoving = false;
				raiseClawTimer.stop();
				if (foundKB)
				{
					raiseKBTimer.stop();
					finishLevel();
				}
			}
		}
		
		function raiseKeyboard (ev:TimerEvent)
		{
			keyboardY -= hookSpeed;
			keyboardSprite.y = keyboardY;
			if (keyboardY + keyboardBmp.height - mmBmp.height/2 +5 <= rowSprites[numRows-1].y)
			{
				mmY -= hookSpeed;
				mmSprite.y = mmY;
			}
		}
		
		function removeHint()
		{
			theParent.stage.removeChild(leftSprite);
			theParent.stage.removeChild(rightSprite);
			theParent.stage.removeChild(spaceSprite);
		}
		
		function finishLevel()
		{
			theParent.stage.removeChild(rowSprites[numRows-1]);
			theParent.stage.removeChild(barSprite);
			theParent.stage.removeChild(thingySprite);
			theParent.stage.removeChild(hookSprite);
						
			fadeKB1Bmp = new LEVEL3keyboardfade1Bmp();
			fadeKB1Sprite = Title.makeSprite(fadeKB1Bmp, fadeKB1Bmp.width, fadeKB1Bmp.height);
			fadeKB1Sprite.x = keyboardSprite.x;
			fadeKB1Sprite.y = keyboardY;
			theParent.stage.addChild(fadeKB1Sprite);
			fadeKB2Bmp = new LEVEL3keyboardfade2Bmp();
			fadeKB2Sprite = Title.makeSprite(fadeKB2Bmp, fadeKB2Bmp.width, fadeKB2Bmp.height);
			fadeKB2Sprite.x = keyboardSprite.x;
			fadeKB2Sprite.y = keyboardY;
			theParent.stage.addChild(fadeKB2Sprite);
			fadeKB3Bmp = new LEVEL3keyboardfade3Bmp();
			fadeKB3Sprite = Title.makeSprite(fadeKB3Bmp, fadeKB3Bmp.width, fadeKB3Bmp.height);
			fadeKB3Sprite.x = keyboardSprite.x;
			fadeKB3Sprite.y = keyboardY;
			theParent.stage.addChild(fadeKB3Sprite);
			fadeKB4Bmp = new LEVEL3keyboardfade4Bmp();
			fadeKB4Sprite = Title.makeSprite(fadeKB4Bmp, fadeKB4Bmp.width, fadeKB4Bmp.height);
			fadeKB4Sprite.x = keyboardSprite.x;
			fadeKB4Sprite.y = keyboardY;
			theParent.stage.addChild(fadeKB4Sprite);
			
			fadeMM1Bmp = new LEVEL3MMfade1Bmp();
			fadeMM1Sprite = Title.makeSprite(fadeMM1Bmp, fadeMM1Bmp.width, fadeMM1Bmp.height);
			fadeMM1Sprite.x = mmSprite.x;
			fadeMM1Sprite.y = mmY;
			theParent.stage.addChild(fadeMM1Sprite);
			fadeMM2Bmp = new LEVEL3MMfade2Bmp();
			fadeMM2Sprite = Title.makeSprite(fadeMM2Bmp, fadeMM2Bmp.width, fadeMM2Bmp.height);
			fadeMM2Sprite.x = mmSprite.x;
			fadeMM2Sprite.y = mmY;
			theParent.stage.addChild(fadeMM2Sprite);
			fadeMM3Bmp = new LEVEL3MMfade3Bmp();
			fadeMM3Sprite = Title.makeSprite(fadeMM3Bmp, fadeMM3Bmp.width, fadeMM3Bmp.height);
			fadeMM3Sprite.x = mmSprite.x;
			fadeMM3Sprite.y = mmY;
			theParent.stage.addChild(fadeMM3Sprite);
			fadeMM4Bmp = new LEVEL3MMfade4Bmp();
			fadeMM4Sprite = Title.makeSprite(fadeMM4Bmp, fadeMM4Bmp.width, fadeMM4Bmp.height);
			fadeMM4Sprite.x = mmSprite.x;
			fadeMM4Sprite.y = mmY;
			theParent.stage.addChild(fadeMM4Sprite);
			
			theParent.stage.removeChild(keyboardSprite);
			theParent.stage.removeChild(mmSprite);
			fadeKB1Sprite.visible = true;
			fadeMM1Sprite.visible = true
			
			fade1Timer.start();
		}
		
		function fade1 (ev:TimerEvent)
		{
			fade1Timer.stop();
			theParent.stage.removeChild(fadeKB1Sprite);
			theParent.stage.removeChild(fadeMM1Sprite);
			fadeKB2Sprite.visible = true;
			fadeMM2Sprite.visible = true;
			fade2Timer.start();
		}
		function fade2 (ev:TimerEvent)
		{
			fade2Timer.stop();
			theParent.stage.removeChild(fadeKB2Sprite);
			theParent.stage.removeChild(fadeMM2Sprite);
			fadeKB3Sprite.visible = true;
			fadeMM3Sprite.visible = true;
			fade3Timer.start();
		}
		function fade3 (ev:TimerEvent)
		{
			fade3Timer.stop();
			theParent.stage.removeChild(fadeKB3Sprite);
			theParent.stage.removeChild(fadeMM3Sprite);
			fadeKB4Sprite.visible = true;
			fadeMM4Sprite.visible = true;
			fade4Timer.start();
		}
		function fade4 (ev:TimerEvent)
		{
			fade4Timer.stop();
			theParent.stage.removeChild(fadeKB4Sprite);
			theParent.stage.removeChild(fadeMM4Sprite);
			endScreenTimer.start();
		}
		
		function endScreen (ev:TimerEvent)
		{
			endScreenTimer.stop();
						
			var bmp = new LEVEL3finalBmp();
			finalSprite = Title.makeSprite(bmp,bmp.width,bmp.height);
			theParent.stage.addChild(finalSprite);
			finalSprite.x = theParent.stage.stageWidth/3;
			finalSprite.y = theParent.stage.stageHeight/3-40;
			finalSprite.visible = true;
			var bmp1 = new LEVEL3finaltxt1Bmp();
			var bmp2 = new LEVEL3finaltxt2Bmp();
			finaltxt1Sprite = Title.makeSprite(bmp1,bmp1.width,bmp1.height);
			finaltxt2Sprite = Title.makeSprite(bmp2,bmp2.width,bmp2.height);
			
			theParent.stage.addChild(finaltxt1Sprite);
			theParent.stage.addChild(finaltxt2Sprite);
			finaltxt1Sprite.visible = true;
			finaltxt2Sprite.visible = true;
			finaltxt2Sprite.x = 25;
			finaltxt2Sprite.y = theParent.stage.stageHeight - 75;
			finaltxt1Sprite.x = 25;
			finaltxt1Sprite.y = 25;
			
			var winSound = new LEVEL3finalSound();
			winSound.play();
			nextSceneTimer.start();
		}
		
		function nextscene (ev:TimerEvent)
		{
			nextSceneTimer.stop();
			theParent.stage.removeChild(finalSprite);
			theParent.stage.removeChild(finaltxt1Sprite);
			theParent.stage.removeChild(finaltxt2Sprite);
			
			theParent.gotoAndStop(1, "Scene 6");
		}
	}
}