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
			_shapeDrawData.shapeType = RECT_SHAPE;
		}
		
		public static const RECT_SHAPE:int = 1;
		
		
		override public function draw():void
		{
			try
			{
				_spriteToDraw.graphics.clear();
				if(_shapeDrawData.hasFill)
				{
					_spriteToDraw.graphics.beginFill(_fillColor);
				}else
				{
					_spriteToDraw.graphics.beginFill(_fillColor, 0);
				}
				
				_spriteToDraw.graphics.lineStyle( _shapeDrawData.lineSize, _shapeDrawData.lineColor );
				_spriteToDraw.graphics.drawRect( _shapeDrawData.drawData.x, _shapeDrawData.drawData.y, _shapeDrawData.drawData.width, _shapeDrawData.drawData.height );
			}catch(e:Error)
			{
				_spriteToDraw.graphics.clear();
			}
		}
	}
}