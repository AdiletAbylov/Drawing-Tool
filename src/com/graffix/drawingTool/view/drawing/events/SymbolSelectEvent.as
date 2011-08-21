package com.graffix.drawingTool.view.drawing.events
{
	import flash.events.Event;
	
	public class SymbolSelectEvent extends Event
	{
		public static const SELECT:String="symbolSelect";
		public var symbol:String;
		public function SymbolSelectEvent( symbol:String)
		{
			super(SELECT, bubbles, cancelable);
		}
	}
}