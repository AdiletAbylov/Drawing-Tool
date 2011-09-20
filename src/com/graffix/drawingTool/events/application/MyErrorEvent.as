package com.graffix.drawingTool.events.application
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class MyErrorEvent extends CairngormEvent
	{
		public static const ERROR_HAPPENED:String = "errorHappened";
		public var error:Error;
		public function MyErrorEvent( error:Error)
		{
			super(ERROR_HAPPENED, bubbles, cancelable);
			this.error = error;
		}
	}
}