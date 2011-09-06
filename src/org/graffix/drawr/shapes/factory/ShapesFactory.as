package org.graffix.drawr.shapes.factory
{
	import org.graffix.drawr.shapes.BaseShape;
	import org.graffix.drawr.shapes.closed.EllipseShape;
	import org.graffix.drawr.shapes.closed.RectShape;
	import org.graffix.drawr.shapes.complex.EraserShape;
	import org.graffix.drawr.shapes.complex.ImageShape;
	import org.graffix.drawr.shapes.complex.SymbolShape;
	import org.graffix.drawr.shapes.complex.TextShape;
	import org.graffix.drawr.shapes.selection.SelectTool;
	import org.graffix.drawr.shapes.simple.FreehandShape;
	import org.graffix.drawr.shapes.simple.LineShape;
	
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
					
				case SymbolShape.SYMBOL_SHAPE:
					return new SymbolShape();
			}
			
			return null;
		}
		
	}
}