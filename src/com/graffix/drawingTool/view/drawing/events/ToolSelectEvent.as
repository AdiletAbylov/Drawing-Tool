package com.graffix.drawingTool.view.drawing.events
{
	import flash.events.Event;
	
	public class ToolSelectEvent extends Event
	{
		public static const TOOL_SELECT:String = "toolSelect";
		public function ToolSelectEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}