package com.graffix.drawingTool.view.drawing.shapes.closed
{
	import com.graffix.drawingTool.view.drawing.events.ShapeChangedEvent;
	import com.graffix.drawingTool.view.drawing.shapes.BaseShape;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * Basic class for closed figures like rectangle or ellipse.  
	 * @author adiletabylov
	 * 
	 */	
	public class ClosedFigureBaseShape extends BaseShape
	{
		public function ClosedFigureBaseShape()
		{
			super();
		}
		
		override public function setProperty(name:String, value:Object):void
		{
			switch(name)
			{
				case PROPERTY_LINE_SIZE:
					_shapeDrawData.lineSize = value as int;
					_lineSizeChanged = true;
					break;
				
				case PROPERTY_LINE_COLOR:
					_shapeDrawData.lineColor = value as uint;
					_lineSizeChanged = true;
					break;
				
				case PROPERTY_FILL_ENABLED:
					_shapeDrawData.hasFill = value as Boolean;
					_hasFillChanged = true;
					break;
				
				case PROPERTY_FILL_COLOR:
					_shapeDrawData.fillColor = value as uint;
					_fillColorChanged = true;
					break;
			}
			invalidateDisplayList();
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			var redrawed:Boolean = _lineSizeChanged || _lineColorChanged || _drawDataChanged || _hasFillChanged || _fillColorChanged;
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
			
			
			if(redrawed)
			{
				//dispatchEvent( new ShapeChangedEvent(ShapeChangedEvent.SHAPE_CHANGED, shapeDrawData ));
			}
		}
		
		override public function setPoints(startPoint:Point, endPoint:Point):void
		{
			var rectWidth:Number = endPoint.x - startPoint.x;
			var rectHeight:Number = endPoint.y - startPoint.y;
			var rectStartPoint:Point = findTopLeftCorner(startPoint, endPoint);
			_shapeDrawData.drawData = new Rectangle(rectStartPoint.x, rectStartPoint.y, Math.abs(rectWidth), Math.abs(rectHeight));
			_drawDataChanged = true;
			invalidateDisplayList();
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