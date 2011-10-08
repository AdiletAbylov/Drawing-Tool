package com.graffix.drawingTool.control
{
	import com.adobe.cairngorm.control.FrontController;
	import com.graffix.drawingTool.commands.application.ErrorsHandleCommand;
	import com.graffix.drawingTool.commands.application.InitCommand;
	import com.graffix.drawingTool.commands.application.LoginCommand;
	import com.graffix.drawingTool.commands.application.StartApplicationCommand;
	import com.graffix.drawingTool.commands.chat.ChatCommand;
	import com.graffix.drawingTool.commands.drawing.ImageGalleryCommand;
	import com.graffix.drawingTool.commands.members.MembersCommand;
	import com.graffix.drawingTool.commands.net.NetStatusCommand;
	import com.graffix.drawingTool.commands.net.TestConnectionCommand;
	import com.graffix.drawingTool.commands.video.VideoCommand;
	import com.graffix.drawingTool.events.application.StartApllicationEvent;
	import com.graffix.drawingTool.events.video.BroadcastEvent;
	import com.graffix.drawingTool.events.application.InitEvent;
	import com.graffix.drawingTool.events.application.LoginEvent;
	import com.graffix.drawingTool.events.application.MyErrorEvent;
	import com.graffix.drawingTool.events.chat.ChatEvent;
	import com.graffix.drawingTool.events.drawing.ImageGalleryEvent;
	import com.graffix.drawingTool.events.members.ChangeStatusEvent;
	import com.graffix.drawingTool.events.members.MembersListEvent;
	import com.graffix.drawingTool.events.net.NCStatusEvent;
	import com.graffix.drawingTool.events.net.TestConnectionEvent;
	
	public class ApplicationController extends FrontController
	{
		public function ApplicationController()
		{
			super();
			netCommands();	
			appCommands();
			membersCommand();
			chatCommand();
			drawingCommands();
			videoCommands();
		}
		
		private function videoCommands():void
		{
			addCommand(BroadcastEvent.PLAY_STREAM, VideoCommand);
			addCommand(BroadcastEvent.STOP_STREAM, VideoCommand);
			addCommand(BroadcastEvent.START_BROADCAST, VideoCommand);
			addCommand(BroadcastEvent.STOP_BROADCAST, VideoCommand);
		}
		
		private function appCommands():void
		{
			addCommand(InitEvent.INIT, InitCommand );
			addCommand(LoginEvent.LOGIN, LoginCommand);
			addCommand(StartApllicationEvent.START_APPLICATION, StartApplicationCommand);
			addCommand(MyErrorEvent.ERROR_HAPPENED, ErrorsHandleCommand);
		}
		private function netCommands():void
		{
			addCommand(NCStatusEvent.NET_STATUS, NetStatusCommand);
			addCommand(TestConnectionEvent.TEST_CONNECTION, TestConnectionCommand );
		}
		
		private function membersCommand():void
		{
			addCommand(MembersListEvent.GONNECT_MEMBERS_LIST, MembersCommand );
			addCommand(MembersListEvent.MEMBERS_LIST_SYNC, MembersCommand);
			addCommand(ChangeStatusEvent.CHANGE_STATUS, MembersCommand );
		}
		
		private function chatCommand():void
		{
			addCommand(ChatEvent.CONNECT_CHAT_SO, ChatCommand);
			addCommand(ChatEvent.RECEIVE_MESSAGE, ChatCommand);
			addCommand(ChatEvent.SEND_MESSAGE, ChatCommand);
		}
		
		private function drawingCommands():void
		{
			addCommand(ImageGalleryEvent.CONNECT_IMAGE_SO, ImageGalleryCommand);
			addCommand(ImageGalleryEvent.IMAGES_SYNC, ImageGalleryCommand);
		}
	}
}