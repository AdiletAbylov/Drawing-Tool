package org.graffix.drawr.events
{
	import org.graffix.drawr.shapes.complex.EraserShape;
	
	import flash.events.Event;
	
	public class EraseEvent extends Event
	{
		public static const ERASE_EVENT:String = "eraseEvent";
		public var eraser:EraserShape;
		public function EraseEvent(eraser:EraserShape)
		{
			super(ERASE_EVENT, true, cancelable);
			this.eraser = eraser;
		}
	}
}