package com.graffix.drawingTool.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class StartApllicationEvent extends CairngormEvent
	{
		public static const START_APPLICATION:String = "START_APPLICATION";
		public function StartApllicationEvent()
		{
			super(START_APPLICATION);
		}
	}
}