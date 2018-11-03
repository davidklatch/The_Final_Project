//David Klatch C490 Final Project
package
{
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import Title;
	
	public class End
	{
		var theParent;
		var m1Timer, m2Timer, m3Timer, m4Timer, mmX, mmY, mwX, mwY;
		var mm1Bmp, mm2Bmp, mm3Bmp, mw1Bmp, mw2Bmp, mw3Bmp;
		var mm1Sprite, mm2Sprite, mm3Sprite, mw1Sprite, mw2Sprite, mw3Sprite;
		var txt1Bmp, txt1Sprite, txt2Bmp, txt2Sprite;
		var bL1Bmp, bL2Bmp, bR1Bmp, bR2Bmp, baby1, baby2;
		var bL1Sprite, bL2Sprite, bR1Sprite, bR2Sprite, mbX;
		var mbTimer, mbSpeed, r,l, mbStart;
		var pc1Bmp, pc2Bmp, pc3Bmp, pc4Bmp, pcSprites, pcX, pcY ,whichPC, pcTimer;
		var endSound;
		
		public function End (par)
		{
			theParent = par;
			theParent.stage.color = 0xbdbdbd;
			
			txt1Bmp = new ENDSCREENtxt1Bmp();
			txt1Sprite = Title.makeSprite(txt1Bmp, txt1Bmp.width, txt1Bmp.height);
			txt1Sprite.x = theParent.stage.stageWidth/2 - txt1Bmp.width/2;
			txt1Sprite.y = 10;
			theParent.stage.addChild(txt1Sprite);
			txt1Sprite.visible = true;
			
			txt2Bmp = new ENDSCREENtxt2Bmp();
			txt2Sprite = Title.makeSprite(txt2Bmp, txt2Bmp.width, txt2Bmp.height);
			txt2Sprite.x = theParent.stage.stageWidth/2 - txt2Bmp.width/2;
			txt2Sprite.y = theParent.stage.stageHeight - txt2Bmp.height - 5;
			theParent.stage.addChild(txt2Sprite);
			txt2Sprite.visible = true;
			
			pcX = theParent.stage.stageWidth - 150;
			pcY = theParent.stage.stageHeight/2 ;
			pcSprites = new Array;
			pc1Bmp = new ENDSCREENpc1Bmp();
			pcSprites[0] = Title.makeSprite(pc1Bmp, pc1Bmp.width, pc1Bmp.height);
			pcSprites[0].x = pcX;
			pcSprites[0].y = pcY;
			theParent.stage.addChild(pcSprites[0]);
			pcSprites[0].visible = true;
			whichPC = 0;
			pc2Bmp = new ENDSCREENpc2Bmp();
			pcSprites[1] = Title.makeSprite(pc2Bmp, pc2Bmp.width, pc2Bmp.height);
			pcSprites[1].x = pcX;
			pcSprites[1].y = pcY;
			theParent.stage.addChild(pcSprites[1]);
			pc3Bmp = new ENDSCREENpc3Bmp();
			pcSprites[2] = Title.makeSprite(pc3Bmp, pc3Bmp.width, pc3Bmp.height);
			pcSprites[2].x = pcX;
			pcSprites[2].y = pcY;
			theParent.stage.addChild(pcSprites[2]);
			pc4Bmp = new ENDSCREENpc4Bmp();
			pcSprites[3] = Title.makeSprite(pc4Bmp, pc4Bmp.width, pc4Bmp.height);
			pcSprites[3].x = pcX;
			pcSprites[3].y = pcY;
			theParent.stage.addChild(pcSprites[3]);
			
			pcTimer = new Timer(200);
			pcTimer.addEventListener(TimerEvent.TIMER, changePC);
			pcTimer.start();
			
			bL1Bmp = new ENDSCREENmbL1Bmp();
			bL1Sprite = Title.makeSprite(bL1Bmp, bL1Bmp.width, bL1Bmp.height);
			mbX = theParent.stage.stageWidth/2;
			bL1Sprite.x = mbX;
			bL1Sprite.y = theParent.stage.stageHeight/2;
			theParent.stage.addChild(bL1Sprite);
			bL1Sprite.visible = true;
			baby1 = true;
			baby2 = false;
			
			bL2Bmp = new ENDSCREENmbL2Bmp();
			bL2Sprite = Title.makeSprite(bL2Bmp, bL2Bmp.width, bL2Bmp.height);
			mbX = theParent.stage.stageWidth/2;
			mbStart = mbX;
			bL2Sprite.x = mbX;
			bL2Sprite.y = theParent.stage.stageHeight/2;
			theParent.stage.addChild(bL2Sprite);
			
			bR1Bmp = new ENDSCREENmbR1Bmp();
			bR1Sprite = Title.makeSprite(bR1Bmp, bR1Bmp.width, bR1Bmp.height);
			mbX = theParent.stage.stageWidth/2;
			bR1Sprite.x = mbX;
			bR1Sprite.y = theParent.stage.stageHeight/2;
			theParent.stage.addChild(bR1Sprite);
			
			bR2Bmp = new ENDSCREENmbR2Bmp();
			bR2Sprite = Title.makeSprite(bR2Bmp, bR2Bmp.width, bR2Bmp.height);
			mbX = theParent.stage.stageWidth/2;
			bR2Sprite.x = mbX;
			bR2Sprite.y = theParent.stage.stageHeight/2;
			theParent.stage.addChild(bR2Sprite);
			
			mbSpeed = 1;
			r = false;
			l = true;
			mbTimer = new Timer(100);
			mbTimer.addEventListener(TimerEvent.TIMER, movemb);
			mbTimer.start();
			
			mm1Bmp = new MainMan1Bmp();
			mm1Sprite = Title.makeSprite(mm1Bmp, mm1Bmp.width, mm1Bmp.height);
			mmX = theParent.stage.stageWidth/2+mm1Bmp.width;
			mmY = theParent.stage.stageHeight/2;
			mm1Sprite.x = mmX;
			mm1Sprite.y = mmY;
			theParent.stage.addChild(mm1Sprite);
			
			mm2Bmp = new MainMan2Bmp();
			mm2Sprite = Title.makeSprite(mm2Bmp, mm2Bmp.width, mm2Bmp.height);
			mm2Sprite.x = mmX;
			mm2Sprite.y = mmY;
			theParent.stage.addChild(mm2Sprite);
			
			mm3Bmp = new MainMan3Bmp();
			mm3Sprite = Title.makeSprite(mm3Bmp, mm3Bmp.width, mm3Bmp.height);
			mm3Sprite.x = mmX;
			mm3Sprite.y = mmY;
			theParent.stage.addChild(mm3Sprite);
			
			mw1Bmp = new MainWoman1Bmp();
			mw1Sprite = Title.makeSprite(mw1Bmp, mw1Bmp.width, mw1Bmp.height);
			mwX = theParent.stage.stageWidth/2;
			mwY = mmY;
			mw1Sprite.x = mwX;
			mw1Sprite.y = mwY;
			theParent.stage.addChild(mw1Sprite);
			
			mw2Bmp = new MainWoman2Bmp();
			mw2Sprite = Title.makeSprite(mw2Bmp, mw2Bmp.width, mw2Bmp.height);
			mw2Sprite.x = mwX;
			mw2Sprite.y = mwY;
			theParent.stage.addChild(mw2Sprite);
			
			mw3Bmp = new MainWoman3Bmp();
			mw3Sprite = Title.makeSprite(mw3Bmp, mw3Bmp.width, mw3Bmp.height);
			mw3Sprite.x = mwX;
			mw3Sprite.y = mwY;
			theParent.stage.addChild(mw3Sprite);
			
			m1Timer = new Timer (200);
			m1Timer.addEventListener(TimerEvent.TIMER, move1);
			m2Timer = new Timer (200);
			m2Timer.addEventListener(TimerEvent.TIMER, move2);
			m3Timer = new Timer (200);
			m3Timer.addEventListener(TimerEvent.TIMER, move3);
			m4Timer = new Timer (200);
			m4Timer.addEventListener(TimerEvent.TIMER, move4);
			
			
			endSound = new endGameSound();
			endSound.play();
			
			mm1Sprite.visible = true;
			mw1Sprite.visible = true;
			m1Timer.start();
		}
	
		function move1 (ev:TimerEvent)
		{
			m1Timer.stop();
			mm1Sprite.visible = false;
			mw1Sprite.visible = false;
			mm2Sprite.visible = true;
			mw2Sprite.visible = true;
			m2Timer.start();
		}
		
		function move2 (ev:TimerEvent)
		{
			m2Timer.stop();
			mm2Sprite.visible = false;
			mw2Sprite.visible = false;
			mm3Sprite.visible = true;
			mw3Sprite.visible = true;
			m3Timer.start();
		}
		
		function move3 (ev:TimerEvent)
		{
			m3Timer.stop();
			mm3Sprite.visible = false;
			mw3Sprite.visible = false;
			mm2Sprite.visible = true;
			mw2Sprite.visible = true;
			m4Timer.start();
		}
		
		function move4 (ev:TimerEvent)
		{
			m4Timer.stop();
			mm2Sprite.visible = false;
			mw2Sprite.visible = false;
			mm1Sprite.visible = true;
			mw1Sprite.visible = true;
			m1Timer.start();
		}
		
		function movemb (ev:TimerEvent)
		{
			if (l == true)
			{
				bR1Sprite.visible = false;
				bR2Sprite.visible = false;
				mbX--;
				if (baby1)
				{
					bL1Sprite.visible = false;
					bL2Sprite.visible = true;
					bL2Sprite.x = mbX;
					baby1 = false;
					baby2 = true;
				}
				else if (baby2)
				{
					bL2Sprite.visible = false;
					bL1Sprite.visible = true;
					bL1Sprite.x = mbX;
					baby2 = false;
					baby1 = true;
				}
				
			}
			else if (r == true)
			{
				bL2Sprite.visible = false;
				bL1Sprite.visible = false;
				mbX++;
				if (baby1)
				{
					bR1Sprite.visible = false;
					bR2Sprite.visible = true;
					bR2Sprite.x = mbX;
					baby1 = false;
					baby2 = true;
				}
				else if (baby2)
				{
					bR2Sprite.visible = false;
					bR1Sprite.visible = true;
					bR1Sprite.x = mbX;
					baby2 = false;
					baby1 = true;
				}	
				
			}
					
			if (mbX < mbStart - 70)
			{
				baby1 = true;
				l = false;
				r = true;
			}
			else if (mbX > mbStart)
			{
				baby1 = true;
				l = true;
				r = false;
			}
		}
		
		function changePC (ev:TimerEvent)
		{
			pcSprites[whichPC].visible = false;
			
			if (whichPC == 3)
			{
				whichPC = 0;
			}
			else
			{
				whichPC++;
			}
			pcSprites[whichPC].visible = true;
		}
	}
}