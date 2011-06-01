package com.graffix.drawingTool.view.drawing.shapes.factory
{
	import com.graffix.drawingTool.view.drawing.shapes.simpleshapes.FreehandShape;
	import com.graffix.drawingTool.view.drawing.shapes.simpleshapes.LineShape;
	import com.graffix.drawingTool.view.drawing.shapes.closed.EllipseShape;
	import com.graffix.drawingTool.view.drawing.shapes.closed.RectShape;
	import com.graffix.drawingTool.view.drawing.shapes.BaseShape;
	import com.graffix.drawingTool.view.drawing.shapes.complex.EraserShape;
	import com.graffix.drawingTool.view.drawing.shapes.complex.ImageShape;
	import com.graffix.drawingTool.view.drawing.shapes.selection.SelectTool;
	import com.graffix.drawingTool.view.drawing.shapes.complex.TextShape;
	
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