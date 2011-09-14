package org.graffix.drawr.shapes.complex
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Rectangle;
	
	import mx.core.UIComponent;
	
	import org.graffix.drawr.events.EraseEvent;

	public class EraserShape extends FreehandShape
	{
		public static const ERASER_SHAPE:int = 666;
		public function EraserShape()
		{
			super();
			_shapeDrawData.type = ERASER_SHAPE;
			_shapeDrawData.lineColor = 0x000000;
			_shapeDrawData.lineSize = 80;
		}
		
		private var _eraserIcon:Shape;
		private var container:UIComponent;
		override protected function createChildren():void
		{
			super.createChildren();
			_eraserIcon = new Shape();
			_eraserIcon.graphics.beginFill(0xFFFFFF, 0.9);
			_eraserIcon.graphics.lineStyle(1);
			_eraserIcon.graphics.drawCircle(0,0, 40);
			_eraserIcon.graphics.endFill();
			container = new UIComponent();
			container.addChild(_eraserIcon);
			addElement(container);
		}
		
		override public function draw():void
		{
			super.draw();
			if(_coords.length >= 2)
			{
				_eraserIcon.x = _coords[_coords.length-2];
				_eraserIcon.y = _coords[_coords.length-1];
			}
		}
		
		override public function finishDraw():void
		{
			//clear();
			dispatchEvent(new EraseEvent(this));
		}
		
		override public function destroy():void
		{
			super.destroy();
			removeElement( container );
			container.removeChild(_eraserIcon);
			_eraserIcon=null;
			container = null;
		}
	}
}