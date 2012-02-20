package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Render extends Sprite
	{
		public var treeIndex:int = 0;
		public var treeX:int = - 320;
		public var treeY:int = -240;
		public function Render() 
		{
			
		}
		
		
		public function makeRenders():void
		{
			addEventListener("TreeMade", renderTree);
			dispatchEvent(new Event("TreeMade"));
		}
		
		public function renderTree(e:Event):void
		{
			trace("render", treeIndex);
			if (treeIndex != 1)
			{
				var s:Sprite = new Sprite();
				
				//holds tree layers
				var layers:Vector.<TreeLayer> = new Vector.<TreeLayer>(15, true);
				
				//create tree layers
				var lay:TreeLayer;
				for (var i:int = 0; i < layers.length; i++)
				{
					lay = new TreeLayer();
					lay.rotation = Math.random() * 360;
					lay.x =  i * treeX / 50;
					lay.y =  i * treeY / 50;
					lay.scaleX = (layers.length - i) / layers.length;
					lay.scaleY = lay.scaleX;					
					layers[i] = lay;
					s.addChild(lay);
				}
				//NTree.renders[(treeX + 320) / 5][(treeY + 240) / 5] = null;
				treeIndex++;
				s.x = treeX + 320 + 100;
				s.y = treeY + 240 + 100;
				addChild(s);
				trace(s.width);
				
				
				s.graphics.lineStyle(2, 0x000000, 1);
				s.graphics.drawRect( -s.width / 2, -s.height / 2, s.width, s.height);
				
				
				var bt:Bitmap = new Bitmap(new BitmapData(190, 190, false,0x000000));
				bt.bitmapData.draw(s, new Matrix(1,0,0,1,190/2,190/2));
				bt.x = s.x;
				bt.y = s.y + 150;
				addChild(bt);
				
				
				
				
				treeX += 5;
				if (treeX > 320)
				{
					treeX = -320;
					treeY += 5;
				}
				this.dispatchEvent(new Event("TreeMade"));
			}
			else
			{
				removeEventListener("TreeMade", renderTree);
			}
		}
	}

}