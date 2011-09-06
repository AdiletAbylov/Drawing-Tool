package org.graffix.drawr.events
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class DrawAreaEvent extends Event
	{
		public static const UP:String = "drawAreaMouseUp";
		public static const MOVE:String = "drawAreaMouseMove";
		public static const DOWN:String = "drawAreaMouseDown";
		public static const CLICK:String = "drawAreaMouseClick";
		public var mouseEvent:MouseEvent;
		public var hasShapeUnderClick:Boolean;
		public function DrawAreaEvent(type:String, mouseEvent:MouseEvent, hasShapeUnderClick:Boolean = false)
		{
			super(type, true, cancelable);
			this.mouseEvent = mouseEvent;
			this.hasShapeUnderClick = hasShapeUnderClick;
		}
	}
}