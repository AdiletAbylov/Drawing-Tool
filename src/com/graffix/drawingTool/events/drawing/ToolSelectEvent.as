package com.graffix.drawingTool.events.drawing
{
	import flash.events.Event;
	
	public class ToolSelectEvent extends Event
	{
		public static const TOOL_SELECT:String = "TOOL_SELECT";
		public var toolType:int;
		public var data:Object;
		public function ToolSelectEvent(toolType:int, data:Object = null)
		{
			super(TOOL_SELECT);
			this.toolType = toolType;
			this.data = data;
		}
	}
}