package com.graffix.drawingTool.events.drawing
{
	import flash.events.Event;
	
	public class ToolSelectEvent extends Event
	{
		public static const TOOL_SELECT:String = "TOOL_SELECT";
		public var toolType:int;
		public function ToolSelectEvent(toolType:int)
		{
			super(TOOL_SELECT);
			this.toolType = toolType;
		}
	}
}