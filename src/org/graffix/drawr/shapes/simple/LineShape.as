package org.graffix.drawr.shapes.simple
{
	import org.graffix.drawr.events.ShapeChangedEvent;
	import org.graffix.drawr.shapes.BaseShape;
	
	public class LineShape extends BaseShape
	{
		public static const LINE_SHAPE:int = 2;
		
		public function LineShape()
		{
			super();
			_shapeDrawData.type = LINE_SHAPE;
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
			dispatchEvent( new ShapeChangedEvent(ShapeChangedEvent.SHAPE_CHANGED, shapeDrawData ));
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
		}
		
		override public function draw():void
		{
			graphics.clear();
			graphics.lineStyle( _shapeDrawData.lineSize, _shapeDrawData.lineColor );
			graphics.moveTo( 0, 0 );
			graphics.lineTo( width, height );
		}
	}
}