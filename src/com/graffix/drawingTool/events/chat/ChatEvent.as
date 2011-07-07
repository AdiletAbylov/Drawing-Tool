package com.graffix.drawingTool.events.chat
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class ChatEvent extends CairngormEvent
	{
		public static const SEND_MESSAGE:String = "SEND_MESSAGE";
		public static const RECEIVE_MESSAGE:String = "RECEIVE_MESSAGE";
		public var message:String;
		public var to:String;
		public function ChatEvent(type:String, message:String, to:String = "everyone")
		{
			super(type, bubbles, cancelable);
			this.message = message;
			this.to = to;
		}
	}
}