package com.graffix.drawingTool.view.drawing.tools
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * Basic class for closed figures like rectangle or ellipse.  
	 * @author adiletabylov
	 * 
	 */	
	public class ClosedFigure extends AbstractTool
	{
		public function ClosedFigure(type:int)
		{
			super(type);
		}
		
		override public function setProperty(name:String, value:Object):void
		{
			switch(name)
			{
				case PROPERTY_LINE_SIZE:
					_lineSize = value as int;
					_lineSizeChanged = true;
					break;
				
				case PROPERTY_LINE_COLOR:
					_lineColor = value as uint;
					_lineSizeChanged = true;
					break;
				
				case PROPERTY_FILL_ENABLED:
					_hasFill = value as Boolean;
					_hasFillChanged = true;
					break;
				
				case PROPERTY_FILL_COLOR:
					_fillColor = value as uint;
					_fillColorChanged = true;
					break;
			}
			invalidateDisplayList();
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			if(_lineSizeChanged)
			{
				//redraw
				draw();
				_lineSizeChanged = false;
			}
			if(_lineColorChanged)
			{
				draw();
				_lineColorChanged = false;
			}
			
			if(_hasFillChanged)
			{
				draw();
				_hasFillChanged = false;
			}
			if(_fillColorChanged)
			{
				draw();
				_fillColorChanged = false;
			}
		}
		
		override public function setPoints(startPoint:Point, endPoint:Point):void
		{
			var rectWidth:Number = endPoint.x - startPoint.x;
			var rectHeight:Number = endPoint.y - startPoint.y;
			var rectStartPoint:Point = findTopLeftCorner(startPoint, endPoint);
			_drawData = new Rectangle(rectStartPoint.x, rectStartPoint.y, Math.abs(rectWidth), Math.abs(rectHeight));
		}
		
		protected function findTopLeftCorner(startPoint:Point, endPoint:Point):Point
		{
			var xDiff:Number =endPoint.x - startPoint.x;
			var yDiff:Number = endPoint.y - startPoint.y;
			var topLeftX:Number = startPoint.x;
			var topLeftY:Number = startPoint.y;
			if(xDiff < 0)
			{
				topLeftX = endPoint.x;
			}
			if(yDiff < 0)
			{
				topLeftY = endPoint.y;
			}
			return new Point(topLeftX, topLeftY);
		}
	}
}