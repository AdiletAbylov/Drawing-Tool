package com.graffix.drawingTool.business.services
{
	public class ChatSOClientListener
	{
		public function ChatSOClientListener()
		{
			
		}
		
		public function message(text:String):void
		{
			trace("received: " + text);
		}
		
		public function clearHistory(message:String):void
		{
			
		}
				
	}
}