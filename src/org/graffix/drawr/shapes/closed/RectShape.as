package org.graffix.drawr.shapes.closed
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.sampler.NewObjectSample;
	
	public class RectShape extends ClosedFigureBaseShape
	{
		public function RectShape()
		{
			super();
			_shapeDrawData.type = RECT_SHAPE;
		}
		
		public static const RECT_SHAPE:int = 1;
		
		
		override public function draw():void
		{
			try
			{
				graphics.clear();
				if(_shapeDrawData.hasFill)
				{
					graphics.beginFill(_shapeDrawData.fillColor);
				}else
				{
					graphics.beginFill(_shapeDrawData.fillColor, 0);
				}
				
				graphics.lineStyle( _shapeDrawData.lineSize, _shapeDrawData.lineColor );
				graphics.drawRect( 0, 0, width, height );
			}catch(e:Error)
			{
				graphics.clear();
			}
		}
	}
}