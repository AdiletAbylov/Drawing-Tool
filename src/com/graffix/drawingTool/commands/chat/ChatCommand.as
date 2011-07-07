package com.graffix.drawingTool.commands.chat
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.graffix.drawingTool.business.delegates.ChatDelegate;
	import com.graffix.drawingTool.business.delegates.MembersDelegate;
	import com.graffix.drawingTool.events.chat.ChatEvent;
	import com.graffix.drawingTool.model.ModelLocator;
	import com.graffix.drawingTool.view.ChatView;
	
	public class ChatCommand implements ICommand
	{
		public function ChatCommand()
		{
		}
		
		public function execute(event:CairngormEvent):void
		{
			var chatDelegate:ChatDelegate = new ChatDelegate();
			var name:String = "_DEFAULT_";
			var prefix:String = "FCPrivateChat." + name + ".";
			switch(event.type)
			{
				case ChatEvent.CONNECT_SO:
					chatDelegate.connect(prefix);
					//chatDelegate.setUsername(prefix);
					break;
				
				case ChatEvent.RECEIVE_MESSAGE:
					processReceivedMessage( (event as ChatEvent).message );
					break;
				
				case ChatEvent.SEND_MESSAGE:
					chatDelegate.sendMessage((event as ChatEvent).message, (event as ChatEvent).to, prefix );
					break;
			}
		}
		
		private function processReceivedMessage(message:String):void
		{
			(ModelLocator.getInstance().chatView as ChatView).addMessage(message);
		}
	}
}