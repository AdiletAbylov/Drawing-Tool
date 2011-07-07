package com.graffix.drawingTool.commands.chat
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.graffix.drawingTool.business.delegates.ChatDelegate;
	import com.graffix.drawingTool.business.delegates.MembersDelegate;
	import com.graffix.drawingTool.events.chat.ChatEvent;
	import com.graffix.drawingTool.model.ModelLocator;
	
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
					var membersDelegate:MembersDelegate = new MembersDelegate();
					membersDelegate.setUsername(ModelLocator.getInstance().user.username, prefix);
					break;
				
				case ChatEvent.RECEIVE_MESSAGE:
					break;
				
				case ChatEvent.SEND_MESSAGE:
					chatDelegate.sendMessage((event as ChatEvent).message, (event as ChatEvent).to, prefix );
					break;
			}
		}
	}
}