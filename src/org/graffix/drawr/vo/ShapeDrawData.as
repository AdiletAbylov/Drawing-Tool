package org.graffix.drawr.vo
{
	import flash.geom.Matrix;
	
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
		public var type:int;
		public var drawData:Object;
		public var x:Number;
		public var y:Number;
		public var width:Number;
		public var height:Number;
		public var zIndex:int;
		public var lineSize:int = 2;
		public var lineColor:uint;
		public var hasFill:Boolean;
		public var fillColor:uint = 0xFFFFFF;
		public var matrix:Matrix;
		
		public var text:String;
		
		public var pageUID:String;
		
		private function serialize(data:Object):void
		{
			try
			{
				shapeID = data.shapeID;
				type = data.type;
				x = data.x;
				y = data.y;
				drawData = data.drawData;
				width = data.width;
				height = data.height;
				zIndex = data.zIndex;
				lineColor = data.lineColor;
				lineSize = data.lineSize;
				hasFill = data.hasFill;
				fillColor = data.fillColor;
				pageUID = data.pageUID;
				text = data.text;
				
				if(data.matrix)
				{
					matrix = new Matrix(data.matrix.a,data.matrix.b, data.matrix.c, data.matrix.d, data.matrix.tx, data.matrix.ty);
				}
			}catch(e:Error)
			{
				trace("serialize error");
			}
		}
	}
}