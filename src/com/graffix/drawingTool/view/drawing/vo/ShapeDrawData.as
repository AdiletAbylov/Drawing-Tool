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
		public var width:Number;
		public var height:Number;
		public var depth:int;
		public var lineSize:int;
		public var lineColor:uint;
		public var hasFill:Boolean;
		public var fillColor:uint;
		
		private function serialize(data:Object):void
		{
			shapeID = data.shapeID;
			shapeType = data.shapeType;
			x = data.x;
			y = data.y;
			drawData = data.drawData;
			width = data.width;
			height = data.height;
			depth = data.depth;
			lineColor = data.lineColor;
			lineSize = data.lineSize;
			hasFill = data.hasFill;
			fillColor = data.fillColor;
		}
	}
}