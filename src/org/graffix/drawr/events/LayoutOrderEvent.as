package org.graffix.drawr.events
{
	import org.graffix.drawr.shapes.BaseShape;
	
	import flash.events.Event;
	
	public class LayoutOrderEvent extends Event
	{
		public static const CHANGE_LAYOUT_ORDER:String = "changeLayoutOrder";
		public var shape:BaseShape;
		public var direction:String;
		public function LayoutOrderEvent(type:String, shape:BaseShape, direction:String)
		{
			super(type, bubbles, cancelable);
			this.shape = shape;
			this.direction = direction;
		}
	}
}