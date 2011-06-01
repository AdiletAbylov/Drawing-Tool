package com.graffix.drawingTool.view.drawing.shapes.closed
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.sampler.NewObjectSample;

	public class RectShape extends ClosedFigureBaseShape
	{
		public function RectShape()
		{
			super();
			_type = RECT_SHAPE;
		}
		
		public static const RECT_SHAPE:int = 1;
		
		
		override public function draw():void
		{
			_spriteToDraw.graphics.clear();
			if(_hasFill)
			{
				_spriteToDraw.graphics.beginFill(_fillColor);
			}else
			{
				_spriteToDraw.graphics.beginFill(_fillColor, 0);
			}
			
			_spriteToDraw.graphics.lineStyle( _lineSize, _lineColor );
			_spriteToDraw.graphics.drawRect( (_shapeDrawData as Rectangle).x, (_shapeDrawData as Rectangle).y, (_shapeDrawData as Rectangle).width, (_shapeDrawData as Rectangle).height );
		}
	}
}