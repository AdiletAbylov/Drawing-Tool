package com.graffix.drawingTool.business.services
{
	import com.graffix.drawingTool.events.chat.ChatEvent;

	public class ChatSOClientListener
	{
		public function ChatSOClientListener()
		{
			
		}
		
		public function message(text:String):void
		{
			trace("received: " + text);
			var chatEvent:ChatEvent = new ChatEvent(ChatEvent.RECEIVE_MESSAGE, text);
			chatEvent.dispatch();
		}
		
		public function clearHistory(message:String):void
		{
			
		}
				
	}
}