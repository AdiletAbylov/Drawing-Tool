package com.graffix.drawingTool.events.application
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class InitEvent extends CairngormEvent
	{
		public static const INIT:String = "INIT";
		public function InitEvent()
		{
			super(INIT);
		}
	}
}