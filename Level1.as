//David Klatch C490 Final Project
package
{
	import Title;
	import flash.text.TextField;
	import flash.text.*;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.KeyboardEvent;

	public class Level1
	{
		var cardBmp, cardSprites, theParent, titleBox, secondClick, firstCard, globalFirstClick;
		var cardX, cardY, bgMusic, bgSoundChannel;
		var flippedSprites, flippedLocs, bmpArray,rndChoices, numMatches;
		var firstFlip, firstLoc, foundLoc;
		var flipTimer, mysteryTimer, endTimer, won, sourceSprite;
		var fadeArray, globalI;
		var fade0Timer,fade1Timer,fade2Timer,fade3Timer,fade4Timer, fadeDoneTimer;
		var finalSprite, finaltxt1Sprite,finaltxt2Sprite;
		var enterTimer, enterSprite, Enter;
		
		public function Level1(par)
		{
			theParent = par;
			secondClick = false;
			numMatches = 4;
			Enter = 13;
			won = false;
			fadeArray = new Array;
			flippedSprites = new Array;
			flippedLocs = new Array;			
			foundLoc = new Array;
			bmpArray = new Array(5); 
			rndChoices = new Array(2,2,2,2);
			cardBmp = new Level1CardBmp();
			cardSprites = new Array;
			cardX = new Array;
			cardY = new Array;
			for(var i=0; i<9; i++)
			{
				cardSprites[i] = Title.makeSprite(cardBmp, 83, 97);
				theParent.stage.addChild(cardSprites[i]);
				cardSprites[i].visible = true;
				cardSprites[i].addEventListener(MouseEvent.CLICK,checkMatch);
				flippedLocs[i] = -1;
				foundLoc[i] = false;
			}
			placeSprite();
			titleBox = makeTextBox();
			theParent.addChild(titleBox);
			titleBox.text = "Memory Game";
			titleBox.visible = true;
						
			flipTimer = new Timer(750);
			flipTimer.addEventListener(TimerEvent.TIMER, flipCards);
			mysteryTimer = new Timer(500);
			mysteryTimer.addEventListener(TimerEvent.TIMER, closeMystery);
			endTimer = new Timer(500);
			endTimer.addEventListener(TimerEvent.TIMER, endLevel);
			fade0Timer = new Timer(50);
			fade1Timer = new Timer(250);
			fade2Timer = new Timer(450);
			fade3Timer = new Timer(650);
			fade4Timer = new Timer(850);
			fadeDoneTimer = new Timer(1050);
			fade0Timer.addEventListener(TimerEvent.TIMER,fade0);
			fade1Timer.addEventListener(TimerEvent.TIMER,fade1);
			fade2Timer.addEventListener(TimerEvent.TIMER,fade2);
			fade3Timer.addEventListener(TimerEvent.TIMER,fade3);
			fade4Timer.addEventListener(TimerEvent.TIMER,fade4);
			fadeDoneTimer.addEventListener(TimerEvent.TIMER,fadeDone);
			enterTimer = new Timer(4000);
			enterTimer.addEventListener(TimerEvent.TIMER,pressEnter);
			randomizeFlips();
			fillFlippedArray();
			
			bgMusic = new BG1Sound();
			bgSoundChannel = bgMusic.play();
		}
		
		function placeSprite()
		{
			var initialOffset = 75, k=0;
			for (var i=0; i<3; i++)
			{
				for (var j=0; j<3; j++)
				{
					cardSprites[k].x = theParent.stage.stageWidth/2 - 2*cardSprites[0].width + k%3 * initialOffset;
					cardSprites[k].y = theParent.stage.stageHeight/2 - 1.5*cardSprites[0].height + 1.5*i * initialOffset;
					if (k%3 == 1)
					{
						cardSprites[k].x += 50;
					}
					if (k%3 == 2)
					{
						cardSprites[k].x += 100;
					}
					cardX[k] = cardSprites[k].x;
					cardY[k] = cardSprites[k].y;
					k++;
				}
			}
		}
		
		static function makeTextBox()
		{
			var countDownShow = new TextField();
			countDownShow.x = 450/3+5;
			countDownShow.y = 10;
			countDownShow.width = 500;
			countDownShow.height = 60;
			var format:TextFormat = new TextFormat();
			format.font = "Consolas";
			format.color = 0xff69b4;
			format.size = 48;
			countDownShow.defaultTextFormat = format;
			return countDownShow;
		}
		
		function checkMatch(ev:MouseEvent)
		{
			
			if (!won)
			{
				if (secondClick)
				{
					removeEvListeners();
					secondClick = false;
					ev.target.visible = false;
					firstFlip = getFlipLoc();
					flippedSprites[firstFlip].visible = true;
					flipTimer.start();
				}
				else
				{
					ev.target.visible = false;
					getFirstLoc();
					if (cardSprites[firstLoc].name != "mystery")
					{
						firstCard = ev.target;
						secondClick = true;
						flippedSprites[firstLoc].visible = true;
					}
					else
					{
						removeEvListeners();
						flippedSprites[firstLoc].visible = true;
						mysteryTimer.start();
					}
				}
			}
			else
			{
				ev.target.visible = false;
				showSource();
				endTimer.start();
			}
		}
		
		function removeEvListeners()
		{
			for(var i=0; i<9; i++)
			{
				cardSprites[i].removeEventListener(MouseEvent.CLICK,checkMatch);
			}
		}
		
		function getFirstLoc()
		{
			for (var i=0; i<cardSprites.length; i++)
			{
				if (cardSprites[i].visible == false && foundLoc[i] == false)
				{
					firstLoc = i;
					return;
				}
			}
		}
		
		function getFlipLoc()
		{
			for (var i=0; i<cardSprites.length; i++)
			{
				if (i != firstLoc)
				{
					if (cardSprites[i].visible == false && foundLoc[i] == false)
					{
						return i;
					}
				}
			}
		}
		function isMatch(fFlip, i)
		{
			if (flippedLocs[fFlip] == flippedLocs[i])
			{
				return true;
			}
			return false;
		}
		
		function flipCards(ev:TimerEvent)
		{
			flipTimer.stop();
			if (isMatch(firstFlip,firstLoc))
			{
				numMatches--;
				foundLoc[firstFlip] = true;
				foundLoc[firstLoc] = true;
				flippedSprites[firstFlip].visible = false;
				flippedSprites[firstLoc].visible = false;
				cardSprites[firstFlip].visible = false;
				cardSprites[firstLoc].visible = false;
			}
			else
			{
				flippedSprites[firstFlip].visible = false;
				flippedSprites[firstLoc].visible = false;
				cardSprites[firstFlip].visible = true;
				cardSprites[firstLoc].visible = true;
			}
			addEvListeners();
		
			if (numMatches == 0)
			{
				won = true;
				removeObjects();
				bgSoundChannel.stop();
			}
		}
		
		function addEvListeners()
		{
			for(var i=0; i<9; i++)
			{
				cardSprites[i].addEventListener(MouseEvent.CLICK,checkMatch);
			}
		}
		
		function fillFlippedArray()
		{
			bmpArray[0] = new LEVEL1CSCIBmp();
			bmpArray[1] = new LEVEL1flashBmp();
			bmpArray[2] = new LEVEL1IUBmp();
			bmpArray[3] = new LEVEL1LvlBmp();
			bmpArray[4] = new LEVEL1qmBmp();
			for (var i=0; i<flippedLocs.length; i++)
			{
				if (flippedLocs[i] != -1)
				{
					
					flippedSprites[i] = Title.makeSprite(bmpArray[flippedLocs[i]],83,97);
				}
				else
				{
					flippedSprites[i] = Title.makeSprite(bmpArray[4],83,97);
					cardSprites[i].name = "mystery";
				}
				flippedSprites[i].x = cardX[i];
				flippedSprites[i].y = cardY[i];
				theParent.stage.addChild(flippedSprites[i]);
			}
		}
		
		function randomizeFlips()
		{
			makeFlippedLocs();
		}
		
		function makeFlippedLocs()
		{
			var rnd, randFlip;
			rnd = Math.floor(Math.random()*9);
			randFlip = Math.floor(Math.random()*4);
			flippedLocs[rnd] = randFlip;
			rndChoices[randFlip] -= 1;
			for (var i=0; i<7; i++)
			{
				rnd = Math.floor(Math.random()*9);
				while (isLocFull(rnd))
				{
					rnd = Math.floor(Math.random()*9);
				}
				randFlip = Math.floor(Math.random()*4);
				while (isFlipMatch(randFlip))
				{
					randFlip = Math.floor(Math.random()*4);
				}
				flippedLocs[rnd] = randFlip;
			}
		}
		
		function isLocFull(r)
		{
			if (flippedLocs[r] == -1)
			{
				return false;
			}
			return true;
		}
		
		function isFlipMatch(r)
		{
			if (rndChoices[r] == 0)
			{
				return true;
			}
			rndChoices[r] -= 1;
			return false;
		}
		
		function removeObjects()
		{
			for(var i=0; i<9; i++)
			{
				if (cardSprites[i].name != "mystery")
				{
					cardSprites[i].removeEventListener(MouseEvent.CLICK,checkMatch);
					theParent.stage.removeChild(cardSprites[i]);
					theParent.stage.removeChild(flippedSprites[i]);
				}
				else
				{
					globalI = i;
					mysteryTimer.removeEventListener(TimerEvent.TIMER, closeMystery);
				}
			}
			theParent.removeChild(titleBox);
		}
		
		function closeMystery(ev:TimerEvent)
		{
			addEvListeners();
			flippedSprites[firstLoc].visible = false;
			cardSprites[firstLoc].visible = true;
			mysteryTimer.stop();
		}
		
		function showSource()
		{
			var bmp = new LEVEL1sourceBmp();
			sourceSprite = Title.makeSprite(bmp,83,97);
			theParent.stage.addChild(sourceSprite);
			for(var i=0; i<9; i++)
			{
				if (cardSprites[i].name == "mystery")
				{
					sourceSprite.x = cardX[i];
					sourceSprite.y = cardY[i];
					theParent.stage.removeChild(cardSprites[i]);
					theParent.stage.removeChild(flippedSprites[i]);
					break;
				}
			}
			sourceSprite.visible = true;
		}
		function endLevel(ev:TimerEvent)
		{
			endTimer.stop();
			var bmpAry = new Array;
			bmpAry[0] = new LEVEL1fade1Bmp();
			bmpAry[1] = new LEVEL1fade2Bmp();
			bmpAry[2] = new LEVEL1fade3Bmp();
			bmpAry[3] = new LEVEL1fade4Bmp();
			bmpAry[4] = new LEVEL1fade5Bmp();
			for (var i=0; i<5; i++)
			{
				fadeArray[i] = Title.makeSprite(bmpAry[i],83,97);
				theParent.stage.addChild(fadeArray[i]);
				fadeArray[i].x = cardX[globalI];
				fadeArray[i].y = cardY[globalI];
			}
			fade0Timer.start();
			
		}
		
		function fade0 (ev:TimerEvent)
		{
			fade0Timer.stop();
			theParent.stage.removeChild(sourceSprite);
			fadeArray[0].visible = true;
			fade1Timer.start();
			
		}
		
		function fade1 (ev:TimerEvent)
		{
			fade1Timer.stop();
			theParent.stage.removeChild(fadeArray[0]);
			fadeArray[1].visible = true;
			fade2Timer.start();
			
		}
		
		function fade2 (ev:TimerEvent)
		{
			fade2Timer.stop();
			theParent.stage.removeChild(fadeArray[1]);
			fadeArray[2].visible = true;
			fade3Timer.start();
			
		}
		
		function fade3 (ev:TimerEvent)
		{
			fade3Timer.stop();
			theParent.stage.removeChild(fadeArray[2]);
			fadeArray[3].visible = true;
			fade4Timer.start();
		}
		
		function fade4 (ev:TimerEvent)
		{
			fade4Timer.stop();
			theParent.stage.removeChild(fadeArray[3]);
			fadeArray[4].visible = true;
			fadeDoneTimer.start();
		}
		
		function fadeDone(ev:TimerEvent)
		{
			fadeDoneTimer.stop();
			theParent.stage.removeChild(fadeArray[4]);
			var bmp = new LEVEL1finalBmp();
			finalSprite = Title.makeSprite(bmp,200,200);
			theParent.stage.addChild(finalSprite);
			finalSprite.x = theParent.stage.stageWidth/3;
			finalSprite.y = theParent.stage.stageHeight/3;
			finalSprite.visible = true;
			var bmp1 = new LEVEL1finaltxt1Bmp();
			var bmp2 = new LEVEL1finaltxt2Bmp();
			finaltxt1Sprite = Title.makeSprite(bmp1,550,100);
			finaltxt2Sprite = Title.makeSprite(bmp2,550,100);
			
			theParent.stage.addChild(finaltxt1Sprite);
			theParent.stage.addChild(finaltxt2Sprite);
			finaltxt1Sprite.visible = true;
			finaltxt2Sprite.visible = true;
			finaltxt2Sprite.x = 25;
			finaltxt2Sprite.y = theParent.stage.stageHeight - 105;
			finaltxt1Sprite.x = 25;
			finaltxt1Sprite.y = 25;
			
			var winSound = new LEVEL1winSound();
			winSound.play();
			enterTimer.start();
		}
		
		function pressEnter(ev:TimerEvent)
		{
			enterTimer.stop();
			theParent.stage.removeChild(finaltxt1Sprite);
			theParent.stage.removeChild(finaltxt2Sprite);
			theParent.stage.removeChild(finalSprite);
			var enterBmp = new LEVEL1enterBmp();
			enterSprite = Title.makeSprite(enterBmp, 450,100);
			theParent.stage.addChild(enterSprite);
			enterSprite.x = theParent.stage.stageWidth/6.5;
			enterSprite.y = theParent.stage.stageHeight/3;
			enterSprite.visible = true;
			theParent.stage.addEventListener(KeyboardEvent.KEY_DOWN, nextLevel);
		}
		function nextLevel(ev:KeyboardEvent)
		{
			if (ev.keyCode == Enter)
			{
				theParent.stage.removeEventListener(KeyboardEvent.KEY_DOWN, nextLevel);
				theParent.stage.removeChild(enterSprite);
				theParent.gotoAndStop(1, "Scene 4");
			}
		}
	}
}