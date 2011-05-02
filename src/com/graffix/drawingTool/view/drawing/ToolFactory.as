package com.graffix.drawingTool.view.drawing
{
	import com.graffix.drawingTool.view.drawing.shapes.BaseShape;
	import com.graffix.drawingTool.view.drawing.shapes.EllipseShape;
	import com.graffix.drawingTool.view.drawing.shapes.FreehandShape;
	import com.graffix.drawingTool.view.drawing.shapes.ImageShape;
	import com.graffix.drawingTool.view.drawing.shapes.LineShape;
	import com.graffix.drawingTool.view.drawing.shapes.RectShape;
	import com.graffix.drawingTool.view.drawing.shapes.SelectTool;
	import com.graffix.drawingTool.view.drawing.shapes.TextShape;
	
	public class ToolFactory
	{
		public static function createTool(type:int):BaseShape
		{
			switch(type)
			{
				
				case SelectTool.TRANSFORM_TOOL:
					return new SelectTool(SelectTool.TRANSFORM_TOOL);
					
				case LineShape.LINE_TOOL:
					return new LineShape(LineShape.LINE_TOOL);
					
				case RectShape.RECT_TOOL:
					return new RectShape(RectShape.RECT_TOOL);
					
				case EllipseShape.ELLIPSE_TOOL:
					return new EllipseShape(EllipseShape.ELLIPSE_TOOL);
					
				case FreehandShape.FREEHAND_TOOL:
					return new FreehandShape(FreehandShape.FREEHAND_TOOL);
					
				case TextShape.TEXT_TOOL:
					return new TextShape(TextShape.TEXT_TOOL);
					
				case ImageShape.IMAGE_TOOL:
					return new ImageShape(ImageShape.IMAGE_TOOL);
			}
			
			return null;
		}
		
	}
}