package com.graffix.drawingTool.view.drawing.shapes.simple
{
	import com.graffix.drawingTool.view.drawing.events.ShapeChangedEvent;
	import com.graffix.drawingTool.view.drawing.shapes.BaseShape;

	public class LineShape extends BaseShape
	{
		public static const LINE_SHAPE:int = 2;
		
		public function LineShape()
		{
			super();
			_shapeDrawData.shapeType = LINE_SHAPE;
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
			}
			invalidateDisplayList();
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			var redrawed:Boolean = _lineSizeChanged || _lineColorChanged || _drawDataChanged;
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
			if(_drawDataChanged)
			{
				draw();
				_drawDataChanged = false;
			}
			
			if(redrawed)
			{
				//dispatchEvent( new ShapeChangedEvent(ShapeChangedEvent.SHAPE_CHANGED, shapeDrawData ));
			}
		}
		
		override public function draw():void
		{
			try
			{
				_spriteToDraw.graphics.clear();
				_spriteToDraw.graphics.lineStyle( _shapeDrawData.lineSize, _shapeDrawData.lineColor );
				_spriteToDraw.graphics.moveTo( _shapeDrawData.drawData.startPoint.x, _shapeDrawData.drawData.startPoint.y );
				_spriteToDraw.graphics.lineTo( _shapeDrawData.drawData.endPoint.x, _shapeDrawData.drawData.endPoint.y );
			}catch(e:Error)
			{
				_spriteToDraw.graphics.clear();
			}
		}
	}
}