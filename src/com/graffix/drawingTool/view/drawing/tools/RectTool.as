package com.graffix.drawingTool.view.drawing.tools
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.sampler.NewObjectSample;

	public class RectTool extends ClosedFigure
	{
		public function RectTool(type:int)
		{
			super(type);
		}
		
		public static const RECT_TOOL:int = 1;
		
		
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
			_spriteToDraw.graphics.drawRect( (_drawData as Rectangle).x, (_drawData as Rectangle).y, (_drawData as Rectangle).width, (_drawData as Rectangle).height );
		}
	}
}