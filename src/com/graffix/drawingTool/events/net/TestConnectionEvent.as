package com.graffix.drawingTool.events.net
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class TestConnectionEvent extends CairngormEvent
	{
		public static const TEST_CONNECTION:String = "TEST_CONNECTION";
		public function TestConnectionEvent()
		{
			super(TEST_CONNECTION);
		}
	}
}