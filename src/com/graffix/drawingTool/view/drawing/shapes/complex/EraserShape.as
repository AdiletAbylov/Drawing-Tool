package com.graffix.drawingTool.view.drawing.shapes.complex
{
	import com.graffix.drawingTool.view.drawing.events.EraseEvent;
	
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Rectangle;
	import com.graffix.drawingTool.view.drawing.shapes.simple.FreehandShape;

	public class EraserShape extends FreehandShape
	{
		public static const ERASER_SHAPE:int = 666;
		public function EraserShape()
		{
			super();
			_type = ERASER_SHAPE;
			_lineColor = 0xFFFFFF;
			_lineSize = 80;
		}
		
		private var _eraserIcon:Shape;
		override protected function createChildren():void
		{
			super.createChildren();
			_eraserIcon = new Shape();
			_eraserIcon.graphics.beginFill(0xFFFFFF, 0.9);
			_eraserIcon.graphics.lineStyle(1);
			_eraserIcon.graphics.drawCircle(0,0, 40);
			_eraserIcon.graphics.endFill();
			addChild(_eraserIcon);
		}
		
		override public function draw():void
		{
			super.draw();
			_eraserIcon.x = _coords[_coords.length-2];
			_eraserIcon.y = _coords[_coords.length-1];
		}
		
		override public function finishDraw():void
		{
			//clear();
			dispatchEvent(new EraseEvent(this));
		}
		
		
		
		override public function destroy():void
		{
			super.destroy();
			removeChild(_eraserIcon);
			_eraserIcon=null;
		}
	}
}