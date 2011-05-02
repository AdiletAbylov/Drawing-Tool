package com.graffix.drawingTool.view.drawing.shapes
{
	public class SelectTool extends BaseShape
	{
		public static const TRANSFORM_TOOL:int = 0;
		public function SelectTool()
		{
			super();
			_type = TRANSFORM_TOOL;
		}
	}
}