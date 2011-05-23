package com.graffix.drawingTool.events.net
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class ConnectEvent extends CairngormEvent
	{
		public function ConnectEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}