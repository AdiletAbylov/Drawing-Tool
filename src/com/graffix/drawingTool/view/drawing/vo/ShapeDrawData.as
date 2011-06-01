package com.graffix.drawingTool.view.drawing.vo
{
	public class ShapeDrawData
	{
		public function ShapeDrawData(data:Object = null)
		{
			if(data)
			{
				serialize(data);
			}
		}
		public var shapeID:String;
		public var shapeType:int;
		public var drawData:Object;
		public var x:Number;
		public var y:Number;
		private function serialize(data:Object):void
		{
			shapeID = data.shapeID;
			shapeType = data.shapeType;
			x = data.x;
			y = data.y;
			drawData = data.drawData;
		}
	}
}