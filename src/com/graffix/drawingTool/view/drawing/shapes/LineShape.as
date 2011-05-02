package com.graffix.drawingTool.view.drawing.shapes
{
	import flash.geom.Point;

	public class LineShape extends BaseShape
	{
		public static const LINE_TOOL:int = 2;
		
		public function LineShape(type:int)
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
			if(_drawDataChanged)
			{
				draw();
				_drawDataChanged = false;
			}
		}
		
		
		override public function draw():void
		{
			_spriteToDraw.graphics.clear();
			_spriteToDraw.graphics.lineStyle( _lineSize, _lineColor );
			_spriteToDraw.graphics.moveTo( _drawData.startPoint.x, _drawData.startPoint.y );
			_spriteToDraw.graphics.lineTo( _drawData.endPoint.x, _drawData.endPoint.y );
		}
	}
}