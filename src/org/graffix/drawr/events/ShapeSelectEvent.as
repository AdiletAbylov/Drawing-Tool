package org.graffix.drawr.events
{
	import flash.events.Event;
	
	public class ShapeSelectEvent extends Event
	{
		public static const SHAPE_SELECT:String = "toolSelect";
		public function ShapeSelectEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}