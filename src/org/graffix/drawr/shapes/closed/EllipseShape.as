package org.graffix.drawr.shapes.closed
{
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class EllipseShape extends ClosedFigureBaseShape
	{
		public function EllipseShape()
		{
			super();
			_shapeDrawData.type=ELLIPSE_SHAPE;
		}
		public static const ELLIPSE_SHAPE:int = 3;
		
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
				graphics.drawEllipse( 0, 0, width, height );
			}catch(e:Error)
			{
				graphics.clear();
			}
		}
	}
}