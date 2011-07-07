package com.graffix.drawingTool.commands.chat
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.graffix.drawingTool.events.chat.ChatEvent;
	
	public class ChatCommand implements ICommand
	{
		public function ChatCommand()
		{
		}
		
		public function execute(event:CairngormEvent):void
		{
			switch()
			{
				case ChatEvent.RECEIVE_MESSAGE:
					break;
				
				case ChatEvent.SEND_MESSAGE:
					break;
			}
		}
	}
}