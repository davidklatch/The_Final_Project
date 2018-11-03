//David Klatch C490 Final Project
package
{
	import Title;
	import flash.display.BitmapData;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	public class Man
	{
		var MM, MMW, MMH, MMX, MMY;
		public var MMYFloor;
		var MMYCeiling, MMJumpSpeed;
		var MMBmp, theParent, theLevel;
		var moveTimer, jumpRTimer, jumpLTimer, jumpTimer;
		var movingDown, movingUp;
		var LCode,RCode,SpaceCode;
		public var Left,Right;
		var Space,Jumping;
		var L1,R1;
		var stageMove;
		public var stageSpeed,stageMovingLeft,stageMovingRight;
		
		var isJumping; // ADDED
		var rightEdge, leftEdge, atLeftEdge, atRightEdge;
		
		public function Man (par,level)
		{
			theParent = par;
			theLevel = level;
			stageMove = 0;
			stageMovingLeft = false;
			stageMovingRight = false;
			isJumping = false; // ADDED
			stageSpeed = 5;
			LCode = 37;
			RCode = 39;
			SpaceCode = 32;
			Left = false;
			Right = false;
			Space = false;
			Jumping = false;
			movingUp = false;
			movingDown = false;
			L1 = false;
			R1 = true;
			MMW = 26;
			MMH = 47;
			MM = new Array;
			MMBmp = new Array;
			MMBmp[0] = new mainManR1Bmp();
			MMBmp[1] = new mainManR2Bmp();
			MMBmp[2] = new mainManL1Bmp();
			MMBmp[3] = new mainManL2Bmp();
			
			MMX = theParent.stage.stageWidth/2-MMW/2;
			
			for (var i=0; i<4; i++)
			{
				MM[i] = Title.makeSprite(MMBmp[i], MMW, MMH);
				theParent.stage.addChild(MM[i]);
				MMY = theParent.stage.stageHeight-2*MMH-7;
				MM[i].x = MMX;
				MM[i].y = MMY;
			}
			MMYFloor = MMY;
			MMYCeiling = MMY-100;
			MMJumpSpeed = 10;
			MM[0].visible = true;
			theParent.stage.addEventListener(KeyboardEvent.KEY_DOWN,KeyDown);
			theParent.stage.addEventListener(KeyboardEvent.KEY_UP,KeyUp);
			
			atLeftEdge = true;
			leftEdge = theLevel.bg.x + MMX;
			atRightEdge = false;
			rightEdge = theParent.stage.stageWidth-MMX;
			
			jumpTimer = new Timer(30);
			jumpTimer.addEventListener(TimerEvent.TIMER, makeJump);
			moveTimer = new Timer(30);
			moveTimer.addEventListener(TimerEvent.TIMER,moveMan);
			moveTimer.start();
		}
		
		function KeyDown(ev:KeyboardEvent)
		{
			switch (ev.keyCode)
			{
				case LCode:
					Left = true;
					break;
				case RCode:
					Right = true;
					break;
				case SpaceCode:
					if (!isJumping) // ADDED
					{
						isJumping = true;
						jumpTimer.start();
					}
					break;
			}
		}
		
		function KeyUp(ev:KeyboardEvent)
		{
			switch (ev.keyCode)
			{
				case LCode:
					stageMovingRight = false;
					Left = false;
					break;
				case RCode:
					stageMovingLeft = false;
					Right = false;
					break;
				case SpaceCode: // ADDED
					isJumping = false;
					break;
			}
		}
		
		function moveMan(ev:TimerEvent)
		{
			var i;
			
			if (Left)
			{
				if (stageMove < 0 && !atRightEdge)
				{
					stageMove += stageSpeed;
					theLevel.bg.x = stageMove;
					theLevel.boxX += stageSpeed;
					theLevel.boxSprite.x = theLevel.boxX;
					stageMovingRight = true;
				}
				else if (stageMove == 0)
				{
					atLeftEdge = true;
					if (MMX > 0)
					{
						MMX -= stageSpeed;
					}
				}
				if (atRightEdge)
				{
					MMX -= stageSpeed;
				}
				
				if (MM[0].visible == true)
				{
					MM[0].visible = false;
				}
				if (MM[1].visible == true)
				{
					MM[1].visible = false;
				}
				if (L1)
				{
					L1 = false;
					MM[2].visible = false;
					MM[3].visible = true;
				}
				else
				{
					L1 = true;
					MM[3].visible = false;
					MM[2].visible = true;
				}
			}
			else
			{
				stageMovingRight = false;
			}
			if (Right)
			{
				if ((stageMove >= -1*theLevel.bg.width+theParent.stage.stageWidth+5) && !atLeftEdge && !atRightEdge)
				{
					stageMove -= stageSpeed;
					theLevel.bg.x = stageMove;
					theLevel.boxX -= stageSpeed;
					theLevel.boxSprite.x = theLevel.boxX;
					//trace(theLevel.boxX);
					stageMovingLeft = true;
				}
				else
				{
					atRightEdge = true;
					if (MMX < theParent.stage.stageWidth-MMW)
					{
						MMX += stageSpeed;
					}
				}
				
				if (MM[2].visible == true)
				{
					MM[2].visible = false;
				}
				if (MM[3].visible == true)
				{
					MM[3].visible = false;
				}
				if (R1)
				{
					R1 = false;
					MM[0].visible = false;
					MM[1].visible = true;
				}
				else
				{
					R1 = true;
					MM[1].visible = false;
					MM[0].visible = true;
				}				
			}
			else
			{
				stageMovingLeft = false;
			}
			if (!Left && !Right)
			{
				if (MM[1].visible == true)
				{
					MM[1].visible = false;
					MM[0].visible = true;
				}
				if (MM[3].visible == true)
				{
					MM[3].visible = false;
					MM[2].visible = true;
				}
			}
			placeMan(); // ADDED
			//trace(MMY);
		}
		
		function makeJump (ev:TimerEvent)
		{
			if (MMY <= MMYCeiling)
			{
				MMJumpSpeed = -MMJumpSpeed;
			}
			if (MMY > MMYFloor) // ADDED (Changed from >= to >)
			{
				MMJumpSpeed = -MMJumpSpeed;
				MMY = MMYFloor;
				placeMan();
				jumpTimer.stop();
				return; // ADDED
			}			
			MMY -= MMJumpSpeed;
			placeMan();
		}
		
		function placeMan()
		{
			for (var i=0; i<4; i++)
			{
				if (MM[i].visible == true)
				{
					MM[i].x = MMX;
					MM[i].y = MMY;
					break;
				}
			}
			
			if (!theLevel.hitBox && MMX+MMW >= theLevel.boxX  && MMX <= theLevel.boxX + theLevel.boxBmp.width
				&& MMY <= theLevel.boxY + theLevel.boxBmp.height && theParent.stage.stageWidth - theLevel.boxX <= 100)
			{
				trace("huh?");
				theLevel.hitBox = true;
				theLevel.explodeBox();
			}
			
			if (MMX >= leftEdge)
			{
				atLeftEdge = false;
			}
			if (MMX < rightEdge)
			{
				atRightEdge = false;
			}
		}
	}
}