package com.graffix.drawingTool.view.drawing.shapes
{
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	public class EllipseShape extends ClosedFigureShape
	{
		public function EllipseShape()
		{
			super();
			_type=ELLIPSE_SHAPE;
		}
		public static const ELLIPSE_SHAPE:int = 3;
		
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
			_spriteToDraw.graphics.drawEllipse( (_drawData as Rectangle).x, (_drawData as Rectangle).y, (_drawData as Rectangle).width, (_drawData as Rectangle).height );
		}
	
	
	}
}