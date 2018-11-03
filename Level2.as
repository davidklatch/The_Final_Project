//David Klatch C490 Final Project
package 
{
	import Man;
	import Title;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.system.System;
	import flash.media.SoundChannel;
	
	public class Level2
	{
		var theParent;
		var bgMusic;
		var MainMan;
		var bgBmp, bg;
		var enemy1Bmp, enemy1Sprite, enemy1X, enemy1Y, enemy1Speed, enemy1Timer,enemy1CurrentPic;
		var enemy1BombBmp, enemy1BombSprite, enemy1BombX, enemy1BombY, enemy1BombSpeed, enemy1BombTimer, numEnemy1Bomb, enemy1BombNextSpawn, enemy1BombSpawnTimer;
		var enemy2Bmp, enemy2Sprite, enemy2X, enemy2Y, enemy2Speed, enemy2Timer;
		var enemy2BombBmp, enemy2BombSprite, enemy2BombX, enemy2BombY, enemy2BombSpeed, enemy2BombTimer, numEnemy2Bomb, enemy2BombNextSpawn, enemy2BombSpawnTimer;
		
		public var lvl2Title1Sprite,lvl2Title2Sprite,lvl2Title3Sprite, leftArrowSprite,rightArrowSprite, spaceBarSprite, introTimer;
		var lost, won;
		var sndChannel:SoundChannel;
		var removeIntro;
		
		public var boxSprite, boxX, boxBmp, boxY, hitBox;
		var explodeBmp, explodeSprite, explodeTimer,explodeCount;
		var computerBmp, computerSprite, seeComputerTimer;
		
		var finalSprite, finalTimer;
		
		var finalNoise;
		
		public function Level2(par)
		{
			theParent = par;
			
			theParent.LEVEL2finaltxt1.visible = false;
			theParent.LEVEL2finaltxt2.visible = false;
						
			bgBmp = new Level2Bmp();
			bg = Title.makeSprite(bgBmp,bgBmp.width,bgBmp.height);
			theParent.stage.addChild(bg);
			bg.visible = true;
			MainMan = new Man(par,this);
			
			hitBox = false;
			createBox();
			boxSprite.visible = true;
			
			bgMusic = new BG2Sound();
			sndChannel = new SoundChannel();
			sndChannel = bgMusic.play();
			
			finalNoise = new LEVEL2finalSound();
			
			removeIntro = false;
			lost = false;
			won = false;
			
			
			explodeTimer = new Timer(50);
			explodeTimer.addEventListener(TimerEvent.TIMER, explode);
			introTimer = new Timer(30);
			introTimer.addEventListener(TimerEvent.TIMER, moveIntro);
			introToLevel();
			
			enemy1Bmp = new Array;
			enemy1Sprite = new Array;
			enemy1X = bgBmp.width+100;
			enemy1Y = 90;
			enemy1Speed = 1.5;
			enemy1Timer = new Timer(30);
			enemy1Timer.addEventListener(TimerEvent.TIMER, moveEnemy1);
			
			enemy2X = bgBmp.width+50;
			enemy2Y = 50;
			enemy2Speed = 5;
			
			createEnemy();
			
			enemy2BombNextSpawn = 0;
			enemy2BombX = new Array;
			enemy2BombY = new Array;
			enemy2BombSpeed = 5;
			numEnemy2Bomb = 1;
			makeEnemy2Bombs();
			enemy2BombTimer = new Timer(30);
			enemy2BombTimer.addEventListener(TimerEvent.TIMER,moveEnemy2Bomb);
			enemy2BombSpawnTimer = new Timer (3000);
			enemy2BombSpawnTimer.addEventListener(TimerEvent.TIMER, spawnEnemy2);
			
			enemy2Timer = new Timer(30);
			enemy2Timer.addEventListener(TimerEvent.TIMER, moveEnemy2);
			
			
			enemy1Sprite[0].visible = true;
			enemy1CurrentPic = 0;
			enemy2Sprite.visible = true;
			
			enemy1Timer.start();
			enemy2Timer.start();
			enemy2BombTimer.start();
			enemy2BombSpawnTimer.start();
			
		}
		
		function introToLevel()
		{
			var titleBmp = new LEVEL2introTxt1Bmp();
			lvl2Title1Sprite = Title.makeSprite(titleBmp, titleBmp.width, titleBmp.height);
			lvl2Title1Sprite.x = 15;
			lvl2Title1Sprite.y = 25;
			theParent.stage.addChild(lvl2Title1Sprite);
			lvl2Title1Sprite.visible = true;
			
			titleBmp = new LEVEL2introTxt2Bmp();
			lvl2Title2Sprite = Title.makeSprite(titleBmp, titleBmp.width, titleBmp.height);
			lvl2Title2Sprite.x = 15;
			lvl2Title2Sprite.y = 70;
			theParent.stage.addChild(lvl2Title2Sprite);
			lvl2Title2Sprite.visible = true;
			
			titleBmp = new LEVEL2leftArrowBmp();
			leftArrowSprite = Title.makeSprite(titleBmp, titleBmp.width, titleBmp.height);
			leftArrowSprite.x = 15;
			leftArrowSprite.y = 125;
			theParent.stage.addChild(leftArrowSprite);
			leftArrowSprite.visible = true;
			
			titleBmp = new LEVEL2rightArrowBmp();
			rightArrowSprite = Title.makeSprite(titleBmp, titleBmp.width, titleBmp.height);
			rightArrowSprite.x = 75;
			rightArrowSprite.y = 125;
			theParent.stage.addChild(rightArrowSprite);
			rightArrowSprite.visible = true;
			
			
			titleBmp = new LEVEL2introTxt3Bmp();
			lvl2Title3Sprite = Title.makeSprite(titleBmp, titleBmp.width, titleBmp.height);
			lvl2Title3Sprite.x = 15;
			lvl2Title3Sprite.y = 175;
			theParent.stage.addChild(lvl2Title3Sprite);
			lvl2Title3Sprite.visible = true;
		
			titleBmp = new LEVEL2spaceBarBmp();
			spaceBarSprite = Title.makeSprite(titleBmp, titleBmp.width, titleBmp.height);
			spaceBarSprite.x = 15;
			spaceBarSprite.y = 235;
			theParent.stage.addChild(spaceBarSprite);
			spaceBarSprite.visible = true;
		
			introTimer.start()
		}
		
		function moveIntro(ev:TimerEvent)
		{
			var introX = bg.x;
			var introY = bg.y;
			
			
			
			lvl2Title1Sprite.x = introX + 15;
			lvl2Title2Sprite.x = introX + 15;
			leftArrowSprite.x = introX + 15;
			rightArrowSprite.x = introX + 75;
			lvl2Title3Sprite.x = introX + 15;
			spaceBarSprite.x = introX + 15;
			
			if (lvl2Title1Sprite.x + 200 < 0)
			{
				removeIntro = true;
				theParent.stage.removeChild(lvl2Title1Sprite);
				theParent.stage.removeChild(lvl2Title2Sprite);
				theParent.stage.removeChild(leftArrowSprite);
				theParent.stage.removeChild(rightArrowSprite);
				theParent.stage.removeChild(lvl2Title3Sprite);
				theParent.stage.removeChild(spaceBarSprite);
				
				introTimer.removeEventListener(TimerEvent.TIMER, moveIntro);
			}
		}
		
		function createEnemy()
		{
			enemy1Bmp[0] = new LEVEL2enemy1p1Bmp();
			enemy1Bmp[1] = new LEVEL2enemy1p2Bmp();
			enemy1Bmp[2] = new LEVEL2enemy1p3Bmp();
			enemy1Bmp[3] = new LEVEL2enemy1p4Bmp();
			enemy1Bmp[4] = new LEVEL2enemy1p5Bmp();
			enemy1Bmp[5] = new LEVEL2enemy1p6Bmp();
			enemy1Bmp[6] = new LEVEL2enemy1p7Bmp();
			enemy1Bmp[7] = new LEVEL2enemy1p8Bmp();
			enemy1Bmp[8] = new LEVEL2enemy1p9Bmp();
			enemy1Bmp[9] = new LEVEL2enemy1p10Bmp();
			enemy1Bmp[10] = new LEVEL2enemy1p11Bmp();
			enemy1Bmp[11] = new LEVEL2enemy1p12Bmp();
			enemy1Bmp[12] = new LEVEL2enemy1p13Bmp();
			
			for (var i=0; i<13; i++)
			{
				enemy1Sprite[i] = Title.makeSprite(enemy1Bmp[i], enemy1Bmp[i].width, enemy1Bmp[i].height);
				enemy1Sprite[i].x = enemy1X;
				enemy1Sprite[i].y = enemy1Y;
				theParent.stage.addChild(enemy1Sprite[i]);
			}
			
			enemy2Bmp = new LEVEL2enemy2Bmp();
			enemy2Sprite = Title.makeSprite(enemy2Bmp, enemy2Bmp.width, enemy2Bmp.height);
			enemy2Sprite.x = enemy2X;
			enemy2Sprite.y = enemy2Y;
			theParent.stage.addChild(enemy2Sprite);
		}
		
		function moveEnemy1 (ev:TimerEvent)
		{
			enemy1Sprite[enemy1CurrentPic].visible = false;
			
			if (enemy1CurrentPic == 12)
			{
				enemy1CurrentPic = 0;
			}
			else
			{
				enemy1CurrentPic++;
			}
			enemy1Sprite[enemy1CurrentPic].visible = true;
			
			if (enemy1X + enemy1Bmp[enemy1CurrentPic].width <= bg.x)
			{
				enemy1X = bg.x + bgBmp.width;
			}
			
			placeEnemy1(enemy1CurrentPic);
		}
		
		function placeEnemy1(i)
		{
			enemy1X -= enemy1Speed;
			//trace("1 " + MainMan.atLeftEdge);
			if (MainMan.stageMovingLeft && !MainMan.atLeftEdge && !MainMan.atRightEdge)
			{
				enemy1X -= MainMan.stageSpeed;
			}
			else if (MainMan.stageMovingRight && !MainMan.atRightEdge && !MainMan.atLeftEdge)
			{
				enemy1X += MainMan.stageSpeed;
			}
			
			enemy1Sprite[i].x = enemy1X;
			
		}
		
		function moveEnemy2 (ev:TimerEvent)
		{
			if (enemy2X + enemy2Bmp.width <= bg.x)
			{
				enemy2X = bg.x+bgBmp.width;
			}
			
			placeEnemy2();
		}
		
		function placeEnemy2()
		{
			enemy2X -= enemy2Speed;
			//trace("1 " + MainMan.atLeftEdge);
			if (MainMan.stageMovingLeft && !MainMan.atLeftEdge && !MainMan.atRightEdge)
			{
				enemy2X -= MainMan.stageSpeed;
			}
			else if (MainMan.stageMovingRight && !MainMan.atRightEdge && !MainMan.atLeftEdge)
			{
				enemy2X += MainMan.stageSpeed;
			}
			
			enemy2Sprite.x = enemy2X;
			
			
		}
		
		function makeEnemy2Bombs()
		{
			enemy2BombBmp = new LEVEL2bomb4Bmp();
			enemy2BombSprite = new Array;
			for (var i=0; i<numEnemy2Bomb; i++)
			{
				enemy2BombSprite[i] = Title.makeSprite(enemy2BombBmp, enemy2BombBmp.width, enemy2BombBmp.height);
				enemy2BombX[i] = enemy2X+enemy2Bmp.width/2;
				enemy2BombY[i] = enemy2Y+enemy2Bmp.height;
				enemy2BombSprite[i].x = enemy2BombX[i];
				enemy2BombSprite[i].y = enemy2BombY[i];
				theParent.stage.addChild(enemy2BombSprite[i]);
			}
			
		}
		
		function moveEnemy2Bomb (ev:TimerEvent)
		{
			for (var i=0; i<numEnemy2Bomb; i++)
			{
				if (enemy2BombY[i] < theParent.stage.stageHeight)
				{
					enemy2BombX[i] = enemy2X;
					enemy2BombY[i] += enemy2BombSpeed;
					placeEnemy2Bomb(i);
					enemy2CollisionDetection(i);
				}
				else
				{
					enemy2BombSprite[i].visible = false;
					enemy2BombY[i] = enemy2Y+enemy2Bmp.height;
				}
							
			}		
		}
		
		function placeEnemy2Bomb(i)
		{
			enemy2BombSprite[i].x = enemy2BombX[i];
			enemy2BombSprite[i].y = enemy2BombY[i];
		}
		
		function enemy2CollisionDetection(i)
		{
			
			if (!hitBox)
			{
				if (enemy2BombSprite[i].visible == true && enemy2BombX[i]+enemy2BombBmp.width >= MainMan.MMX && enemy2BombX[i] <= MainMan.MMX + MainMan.MMBmp[0].width
					&& enemy2BombY[i]+enemy2BombBmp.height >= MainMan.MMY && enemy2BombY[i] <= MainMan.MMY + MainMan.MMBmp[0].height)
				{
					enemy2BombSpawnTimer.removeEventListener(TimerEvent.TIMER, spawnEnemy2);
					lost = true;
					endLevel();
				}
			}
		}
		
		function spawnEnemy2(ev:TimerEvent)
		{
			enemy2BombY[enemy2BombNextSpawn] = enemy2Y+enemy2Bmp.height;
			enemy2BombSprite[enemy2BombNextSpawn].visible = true;
			placeEnemy2Bomb(enemy2BombNextSpawn);
			if (enemy2BombNextSpawn < numEnemy2Bomb-1)
			{
				enemy2BombNextSpawn++;
			}
			else
			{
				enemy2BombNextSpawn = 0;
			}
		}
		
		function endLevel()
		{
			enemy1Timer.removeEventListener(TimerEvent.TIMER, moveEnemy1);
			enemy2Timer.removeEventListener(TimerEvent.TIMER, moveEnemy2);
			enemy2BombTimer.removeEventListener(TimerEvent.TIMER,moveEnemy2Bomb);
			
			if(!removeIntro)
			{
				theParent.stage.removeChild(lvl2Title1Sprite);
				theParent.stage.removeChild(lvl2Title2Sprite);
				theParent.stage.removeChild(leftArrowSprite);
				theParent.stage.removeChild(rightArrowSprite);
				theParent.stage.removeChild(lvl2Title3Sprite);
				theParent.stage.removeChild(spaceBarSprite);
				introTimer.removeEventListener(TimerEvent.TIMER, moveIntro);
			}
						
			
			for (var i=0; i<13; i++)
			{
				theParent.stage.removeChild(enemy1Sprite[i]);
			}
			
			theParent.stage.removeChild(enemy2Sprite);
			
			for (i=0; i<numEnemy2Bomb; i++)
			{
				theParent.stage.removeChild(enemy2BombSprite[i]);
			}
			
			theParent.stage.removeChild(bg);
			
			for (i=0; i<4; i++)
			{
				theParent.stage.removeChild(MainMan.MM[i]);
			}
			
			MainMan = null;
			System.gc();
			
			if (!hitBox)
			{
				theParent.stage.removeChild(boxSprite);
			
			}
			
			
			
			if (lost)
			{
				sndChannel.stop();
				theParent.gotoAndStop(1, "Scene 9");
			}
			if (won)
			{
				theParent.stage.removeChild(computerSprite);
				level2End();
			}
		}
		
		function createBox()
		{
			boxBmp = new LEVEL2boxBmp();
			boxSprite = Title.makeSprite(boxBmp, boxBmp.width, boxBmp.height);
			boxX = bg.x + bgBmp.width - 100;
			boxY = theParent.stage.stageHeight/2-boxBmp.height/2;
			boxSprite.x = boxX;
			boxSprite.y = boxY;
			theParent.stage.addChild(boxSprite);
		}
		
		public function explodeBox()
		{
			theParent.stage.removeChild(boxSprite);
			
			computerBmp = new LEVEL2computerBmp();
			computerSprite = Title.makeSprite(computerBmp, computerBmp.width, computerBmp.height);
			computerSprite.x = boxX;
			computerSprite.y = boxY;
			theParent.stage.addChild(computerSprite);
			seeComputerTimer = new Timer(1000);
			seeComputerTimer.addEventListener(TimerEvent.TIMER, seeComputer);
			
			explodeBmp = new Array;
			explodeBmp[0] = new LEVEL2explode1Bmp();
			explodeBmp[1] = new LEVEL2explode2Bmp();
			explodeBmp[2] = new LEVEL2explode3Bmp();
			explodeBmp[3] = new LEVEL2explode4Bmp();
			explodeBmp[4] = new LEVEL2explode5Bmp();
			explodeBmp[5] = new LEVEL2explode6Bmp();
			explodeBmp[6] = new LEVEL2explode7Bmp();
			explodeBmp[7] = new LEVEL2explode8Bmp();
			explodeBmp[8] = new LEVEL2explode9Bmp();
			explodeBmp[9] = new LEVEL2explode10Bmp();
			explodeBmp[10] = new LEVEL2explode11Bmp();
			explodeBmp[11] = new LEVEL2explode12Bmp();
			explodeBmp[12] = new LEVEL2explode13Bmp();
			explodeBmp[13] = new LEVEL2explode14Bmp();
			explodeBmp[14] = new LEVEL2explode15Bmp();
			explodeBmp[15] = new LEVEL2explode16Bmp();
			
			explodeSprite = new Array;
			for (var i=0; i<16; i++)
			{
				explodeSprite[i] = Title.makeSprite(explodeBmp[i], explodeBmp[i].width, explodeBmp[i].height);
				explodeSprite[i].x = boxX;
				explodeSprite[i].y = boxY;
				theParent.stage.addChild(explodeSprite[i]);
			}
			
			explodeCount = 0;
			explodeSprite[explodeCount].visible = true;
			explodeTimer.start();
		}
		
		function explode (ev:TimerEvent)
		{
			if (explodeCount < 15)
			{
				explodeSprite[explodeCount].visible = false;
				explodeCount++;
				if (explodeCount == 7)
				{
					computerSprite.visible = true;
				}
				explodeSprite[explodeCount].visible = true;
			}
			else
			{
				explodeTimer.stop();
				explodeSprite[15].visible = false;
				won = true;
				seeComputerTimer.start();
			}
		}
	
		function seeComputer (ev:TimerEvent)
		{
			seeComputerTimer.stop();
			endLevel();
		}
	
		function level2End()
		{
			theParent.stage.color = 0x000000;
			sndChannel.stop();
			finalNoise.play();
			theParent.LEVEL2finaltxt1.visible = true;
			theParent.LEVEL2finaltxt2.visible = true;
			
			var finalBmp = new LEVEL2finalBmp();
			finalSprite = Title.makeSprite(finalBmp, finalBmp.width, finalBmp.height);
			finalSprite.x = theParent.stage.stageWidth/3;
			finalSprite.y = theParent.stage.stageHeight/3;
			theParent.stage.addChild(finalSprite);
			finalSprite.visible = true;
			
			
			finalTimer = new Timer(4000);
			finalTimer.addEventListener(TimerEvent.TIMER, nextLevel);
			finalTimer.start();
		}
		
		function nextLevel(ev:TimerEvent)
		{
			finalTimer.stop();
			
			theParent.LEVEL2finaltxt1.visible = false;
			theParent.LEVEL2finaltxt2.visible = false;
			theParent.stage.removeChild(finalSprite);
						
			theParent.gotoAndStop(1, "Scene 5");
		}
	
	}
}