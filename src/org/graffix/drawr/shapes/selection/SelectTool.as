package org.graffix.drawr.shapes.selection
{
	import org.graffix.drawr.shapes.BaseShape;

	public class SelectTool extends BaseShape
	{
		public static const TRANSFORM_TOOL:int = 0;
		public function SelectTool()
		{
			super();
			_shapeDrawData.type = TRANSFORM_TOOL;
		}
	}
}