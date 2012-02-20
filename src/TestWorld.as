package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class TestWorld extends Sprite
	{
		//virtual coords. Must start centered All objects orient off these coords
		public var xPos:int = 0;
		public var yPos:int = 0;
		
		
		public var left:Boolean = false;
		public var right:Boolean = false;
		public var down:Boolean = false;
		public var up:Boolean = false;
		
		public var trees:Vector.<Tree> = new Vector.<Tree>()
		
		public function TestWorld() 
		{
			var r:Render = new Render();
			addChild(r);
			r.makeRenders();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		public function init(e:Event):void
		{
			x = stage.stageWidth / 2;
			y = stage.stageHeight / 2;
			trace("[TestWorld] Loaded");
			var t:Tree;
			for (var i:int = 0; i < 10; i++)
			{
				t = new Tree(this);
				t.x = Math.random() * 600 - 320 + 20;
				t.y = Math.random() * 440 - 240 + 20;
				trees.push(t);
				addChild(t);
			}
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, kDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, kUp);
			addEventListener(Event.ENTER_FRAME, frame);
		}
		
		public function move(X:int, Y:int):void
		{
			xPos = X;
			yPos = Y;
		}
		
		
		public function frame(e:Event):void
		{
			var i:int = 0;
			if (up)
			{
				for (i = 0; i < trees.length; i++)
				{
					trees[i].y += 2;
					trees[i].frame(e);
				}
				//yPos++;
			}
			else if (down)
			{
				for (i = 0; i < trees.length; i++)
				{
					trees[i].y -= 2;
					trees[i].frame(e);
				}
				//yPos--;
			}
			if (right)
			{
				for (i = 0; i < trees.length; i++)
				{
					trees[i].x -= 2;
					trees[i].frame(e);
				}
				//xPos--;
			}
			else if (left)
			{
				for (i = 0; i < trees.length; i++)
				{
					trees[i].x += 2;
					trees[i].frame(e);
				}
				//xPos++;
			}
		}
		
		public function kDown(e:KeyboardEvent):void
		{
			if (e.keyCode == 37 || e.keyCode == 65) //A, Left
			{
				left = true;
			}
			if (e.keyCode == 39 || e.keyCode == 68) //D, Right
			{
				right = true;
			}
			if (e.keyCode == 40 || e.keyCode == 83) //S, Down
			{
				down = true;
			}
			if (e.keyCode == 38 || e.keyCode == 87) //W, Up 
			{
				up = true;
			}
		}
		public function kUp(e:KeyboardEvent):void
		{
			if (e.keyCode == 37 || e.keyCode == 65) //A, Left
			{
				left = false;
			}
			if (e.keyCode == 39 || e.keyCode == 68) //D, Right
			{
				right = false;
			}
			if (e.keyCode == 40 || e.keyCode == 83) //S, Down
			{
				down = false;
			}
			if (e.keyCode == 38 || e.keyCode == 87) //W, Up 
			{
				up = false;
			}
		}
		
	}

}