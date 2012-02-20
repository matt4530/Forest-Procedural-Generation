package  
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class NTree extends Sprite
	{
		public var world:TestWorld;
		
		public static var renders:Vector.<Vector.<Bitmap>> = new Vector.<Vector.<Bitmap>>(128,true);
		
		public function NTree(w:TestWorld ) 
		{
			world = w;
			
		}
		
		
		public function frame(e:Event):void
		{

		}
		
		
		
	}

}