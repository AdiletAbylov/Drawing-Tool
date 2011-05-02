package com.graffix.drawingTool.view.drawing.events
{
	import com.graffix.drawingTool.view.drawing.shapes.BaseShape;
	
	import flash.events.Event;
	
	public class ShapeLayoutEvent extends Event
	{
		public static const LAYOUT_EVENT:String = "shapeLayoutEvent";
		public var shape:BaseShape;
		public var direction:String;
		public function ShapeLayoutEvent(type:String, shape:BaseShape, direction:String)
		{
			super(type, bubbles, cancelable);
			this.shape = shape;
			this.direction = direction;
		}
	}
}