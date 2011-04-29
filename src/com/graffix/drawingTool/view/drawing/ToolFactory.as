package com.graffix.drawingTool.view.drawing
{
	import com.graffix.drawingTool.view.drawing.tools.BaseTool;
	import com.graffix.drawingTool.view.drawing.tools.EllipseTool;
	import com.graffix.drawingTool.view.drawing.tools.FreehandTool;
	import com.graffix.drawingTool.view.drawing.tools.ImageTool;
	import com.graffix.drawingTool.view.drawing.tools.LineTool;
	import com.graffix.drawingTool.view.drawing.tools.RectTool;
	import com.graffix.drawingTool.view.drawing.tools.SelectTool;
	import com.graffix.drawingTool.view.drawing.tools.TextTool;
	
	public class ToolFactory
	{
		public static function createTool(type:int):BaseTool
		{
			switch(type)
			{
				
				case SelectTool.TRANSFORM_TOOL:
					return new SelectTool(SelectTool.TRANSFORM_TOOL);
					
				case LineTool.LINE_TOOL:
					return new LineTool(LineTool.LINE_TOOL);
					
				case RectTool.RECT_TOOL:
					return new RectTool(RectTool.RECT_TOOL);
					
				case EllipseTool.ELLIPSE_TOOL:
					return new EllipseTool(EllipseTool.ELLIPSE_TOOL);
					
				case FreehandTool.FREEHAND_TOOL:
					return new FreehandTool(FreehandTool.FREEHAND_TOOL);
					
				case TextTool.TEXT_TOOL:
					return new TextTool(TextTool.TEXT_TOOL);
					
				case ImageTool.IMAGE_TOOL:
					return new ImageTool(ImageTool.IMAGE_TOOL);
			}
			
			return null;
		}
		
	}
}