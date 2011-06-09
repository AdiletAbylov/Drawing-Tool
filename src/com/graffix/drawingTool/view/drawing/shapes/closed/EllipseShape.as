package com.graffix.drawingTool.view.drawing.shapes.closed
{
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class EllipseShape extends ClosedFigureBaseShape
	{
		public function EllipseShape()
		{
			super();
			_shapeDrawData.shapeType=ELLIPSE_SHAPE;
		}
		public static const ELLIPSE_SHAPE:int = 3;
		
		override public function draw():void
		{
			try
			{
				_spriteToDraw.graphics.clear();
				if(_hasFill)
				{
					_spriteToDraw.graphics.beginFill(_fillColor);
				}else
				{
					_spriteToDraw.graphics.beginFill(_fillColor, 0);
				}
				_spriteToDraw.graphics.lineStyle( _shapeDrawData.lineSize, _lineColor );
				_spriteToDraw.graphics.drawEllipse( _shapeDrawData.drawData.x, _shapeDrawData.drawData.y, _shapeDrawData.drawData.width, _shapeDrawData.drawData.height );
			}catch(e:Error)
			{
				_spriteToDraw.graphics.clear();
			}
		}
	}
}