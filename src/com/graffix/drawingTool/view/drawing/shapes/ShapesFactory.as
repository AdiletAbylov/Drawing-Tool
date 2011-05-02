package com.graffix.drawingTool.view.drawing.shapes
{
	
	public class ShapesFactory
	{
		public static function createTool(type:int):BaseShape
		{
			switch(type)
			{
				
				case SelectTool.TRANSFORM_TOOL:
					return new SelectTool();
					
				case LineShape.LINE_SHAPE:
					return new LineShape();
					
				case RectShape.RECT_SHAPE:
					return new RectShape();
					
				case EllipseShape.ELLIPSE_SHAPE:
					return new EllipseShape();
					
				case FreehandShape.FREEHAND_SHAPE:
					return new FreehandShape();
					
				case TextShape.TEXT_SHAPE:
					return new TextShape();
					
				case ImageShape.IMAGE_SHAPE:
					return new ImageShape();
					
				case EraserShape.ERASER_SHAPE:
					return new EraserShape();
			}
			
			return null;
		}
		
	}
}