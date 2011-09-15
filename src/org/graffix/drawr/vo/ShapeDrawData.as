package org.graffix.drawr.vo
{
	import org.graffix.drawr.shapes.complex.FreehandShape;
	
	[Bindable]
	public class ShapeDrawData
	{
		
		public function ShapeDrawData(data:Object = null)
		{
			if(data)
			{
				serialize(data);
			}
		}
		//
		// TRANSFORMING PROPERTIES
		public var x:Number;
		public var y:Number;
		public var width:Number;
		public var height:Number;
		public var rotation:Number;
		
		public var shapeID:String;
		public var type:int;
		public var drawData:Object;
		
		public var zIndex:int;
		public var lineSize:int = 2;
		public var lineColor:uint;
		public var hasFill:Boolean;
		public var fillColor:uint = 0xFFFFFF;
		
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
				rotation = data.rotation;
				width = data.width;
				height = data.height;
				
				zIndex = data.zIndex;
				lineColor = data.lineColor;
				lineSize = data.lineSize;
				hasFill = data.hasFill;
				fillColor = data.fillColor;
				pageUID = data.pageUID;
				text = data.text;
				drawData = data.drawData;
//				if(type == FreehandShape.FREEHAND_SHAPE )
//				{
//					drawData = {};
//					drawData.commands = new Vector.<int>;
//					for(var i:String in data.drawData.commands)
//					{
//						drawData.commands[i] = data.drawData.commands[i];
//					}
//					
//					drawData.coords = new Vector.<Number>;
//					for(i in data.drawData.coords)
//					{
//						drawData.coords[i] = data.drawData.coords[i];
//					}
//				}
				
			}catch(e:Error)
			{
				trace("serialize error");
			}
		}
		
//		public function toObject():Object
//		{
//			var data:Object = {};
//			data.shapeID = shapeID;
//			data.type = type;
//			data.x = x;
//			data.y = y;
//			data.rotation = rotation;
//			data.width = width;
//			data.height = height;
//			
//			data.zIndex = zIndex;
//			data.lineColor = lineColor;
//			data.lineSize = lineSize;
//			data.hasFill = hasFill;
//			data.fillColor = fillColor;
//			data.pageUID = pageUID;
//			data.text = text;
//			
//			data.drawData = {};
//			
//			if(type == FreehandShape.FREEHAND_SHAPE)
//			{
//				data.drawData.commands = {};
//				var length:int = (drawData.commands as Vector.<int>).length;
//				for(var i:int = 0; i < length; ++i)
//				{
//					data.drawData.commands[i] = (drawData.commands as Vector.<int>)[i];
//				}
//				
//				length = (drawData.coords as Vector.<Number>).length;
//				data.drawData.coords = {};
//				for(i= 0; i < length; ++i)
//				{
//					data.drawData.coords[i] = (drawData.coords as Vector.<Number>)[i];
//				}
//			}
//			
//			return data;
//		}
	}
}