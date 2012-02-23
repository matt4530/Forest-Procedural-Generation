package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
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
		public var maxTrees:int = 85;
		public var treeX:int = 0;
		public var treeY:int = 0;
		
		public var grassIndex:int = 0;
		public var maxGrass:int = 4;
		
		public var finalBitmap:Bitmap = new Bitmap(new BitmapData(640, 480, true, 0x000000));
		public var finalBitmapData:BitmapData;
		
		public static const DEBUG:Boolean = false;
		
		public function Render() 
		{
			finalBitmapData = finalBitmap.bitmapData;
			addChild(finalBitmap);
		}
		
		
		public function makeRenders():void
		{			
			addEventListener("GrassSpot", renderGrassSpot);
			dispatchEvent(new Event("GrassSpot"));
			addEventListener("TreeMade", renderTree);
			dispatchEvent(new Event("TreeMade"));
		}
		
		private function makeTreeSlice():Sprite
		{
			var s:Sprite = new Sprite();
			s.graphics.beginFill(0x5E2605, 1);
			s.graphics.drawCircle(0, 0, 5);
			s.graphics.endFill();
			s.graphics.beginFill(0x002200, .2);
			s.graphics.drawCircle(0, 0, 50);
			s.graphics.endFill();
			for (var i:int = 0; i < 6; i++)
			{
				s.graphics.beginFill(Math.random() * 200 << 8, .2);
				s.graphics.drawCircle(Math.random() * 20 - 10, Math.random() * 20 - 10, Math.random() * 15 + 15);
				s.graphics.endFill();
			}
			return s;
		}
		
		public function renderGrassSpot(e:Event):void
		{
			if (grassIndex != maxGrass)
			{
				var spot:BitmapData = new BitmapData(640, 480,true, 0xff000000); 
				var seed:Number = Math.floor(Math.random() * 100); 
				var channels:uint = BitmapDataChannel.GREEN | BitmapDataChannel.RED  
				spot.perlinNoise(100, 80, 20, seed, false, true, channels, false, null); 
				spot.colorTransform(new Rectangle(0, 0, 640, 480), new ColorTransform(.3, .5, .9, .55, 0, 0));
				var patch:Bitmap = new Bitmap(spot); 
				//addChild(patch);
				finalBitmapData.draw(patch);
				
				
				grassIndex++;
				this.dispatchEvent(new Event("GrassSpot"));
			}
			else
			{
				removeEventListener("GrassSpot", renderGrassSpot);
			}
			
		}
		
		public function renderTree(e:Event):void
		{
			trace("render", treeIndex);
			if (treeIndex != maxTrees)
			{
				var s:Sprite = new Sprite();
				
				//holds tree layers
				//var layers:Vector.<TreeLayer> = new Vector.<TreeLayer>(15, true);
				var layers:Vector.<Sprite> = new Vector.<Sprite>(15, true);
				
				//create tree layers
				//var lay:TreeLayer;
				var lay:Sprite;
				var originalDim:int = 190;
				treeX = Math.random() * 620-310;
				treeY = Math.random() * 460-230;
				for (var i:int = 0; i < layers.length; i++)
				{
					//lay = new TreeLayer();
					lay = makeTreeSlice();
					lay.rotation = Math.random() * 360;
					lay.x =  i * treeX / 50;
					lay.y =  i * treeY / 50;
					lay.scaleX = (layers.length - i) / layers.length/2;
					lay.scaleY = lay.scaleX;	
					if (i == 0) originalDim = lay.width;
					layers[i] = lay;
					if (DEBUG)
					{
						lay.graphics.lineStyle(2, 0xFF0000);
						lay.graphics.drawCircle(0, 0, originalDim*lay.scaleX + 10);
					}
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