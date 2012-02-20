package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Render extends Sprite
	{
		public var treeIndex:int = 0;
		public var maxTrees:int = 50;
		public var treeX:int = 0;
		public var treeY:int = 0;
		
		public var finalBitmap:Bitmap = new Bitmap(new BitmapData(640, 480, true, 0x000000));
		public var finalBitmapData:BitmapData;
		
		
		public function Render() 
		{
			finalBitmapData = finalBitmap.bitmapData;
			addChild(finalBitmap);
		}
		
		
		public function makeRenders():void
		{
			addEventListener("TreeMade", renderTree);
			dispatchEvent(new Event("TreeMade"));
		}
		
		public function renderTree(e:Event):void
		{
			trace("render", treeIndex);
			if (treeIndex != maxTrees)
			{
				var s:Sprite = new Sprite();
				
				//holds tree layers
				var layers:Vector.<TreeLayer> = new Vector.<TreeLayer>(15, true);
				
				//create tree layers
				var lay:TreeLayer;
				var originalDim:int = 190;
				treeX = Math.random() * 640-320;
				treeY = Math.random() * 480-240;
				for (var i:int = 0; i < layers.length; i++)
				{
					lay = new TreeLayer();
					lay.rotation = Math.random() * 360;
					lay.x =  i * treeX / 50;
					lay.y =  i * treeY / 50;
					lay.scaleX = (layers.length - i) / layers.length/2;
					lay.scaleY = lay.scaleX;	
					if (i == 0) originalDim = lay.width;
					layers[i] = lay;
					s.addChild(lay);
				}
				//NTree.renders[(treeX + 320) / 5][(treeY + 240) / 5] = null;
				treeIndex++;
				s.x = treeX;
				s.y = treeY;
				//addChild(s);
				
				
				trace("xxxxxxxx" + originalDim);
				var bt:Bitmap = new Bitmap(new BitmapData(200, 200, true, 0x000000));
				//bt.bitmapData.fillRect(new Rectangle(0, 0, 200, 200), 0x55FF00FF);
				bt.bitmapData.draw(s, new Matrix(1,0,0,1,200/2,200/2),new ColorTransform(1,1.2 + Math.random()*0.4,1,1,10,5));
				bt.x = s.x;
				bt.y = s.y;
				//addChild(bt);
				finalBitmapData.draw(bt, new Matrix(1, 0, 0, 1, treeX+320-200/2, treeY+240-200/2) );
				//removeChild(s);
				
				
				this.dispatchEvent(new Event("TreeMade"));
			}
			else
			{
				removeEventListener("TreeMade", renderTree);
			}
		}
	}

}