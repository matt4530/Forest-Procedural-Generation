package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Tree extends Sprite
	{
		public var world:TestWorld;
		public var layers:Vector.<TreeLayer> = new Vector.<TreeLayer>(12, true);
		
		public function Tree(w:TestWorld ) 
		{
			world = w;
			
			var lay:TreeLayer;
			for (var i:int = 0; i < layers.length; i++)
			{
				lay = new TreeLayer();
				lay.transform.colorTransform = new ColorTransform(1, 1.2 + Math.random() * 0.5, 1, 1, 20, 5);
				lay.rotation = Math.random() * 360;
				lay.scaleX = (layers.length - i) / layers.length;
				lay.scaleY = lay.scaleX;
				layers[i] = lay;
				addChild(lay);
			}
			frame(null);
		}
		
		
		public function frame(e:Event):void
		{
			var dx:Number = x - world.xPos;// - x;
			var dy:Number = y - world.yPos;// - y;
			
			for (var i:int = 0; i < layers.length; i++)
			{
				var lay:TreeLayer = layers[i];
				lay.x =  i * dx / 50;
				lay.y =  i * dy / 50;
			}
			//trace(Math.cos(radians) * 20, x, world.xPos);
		}
		
	}

}