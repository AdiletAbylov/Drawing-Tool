package com.graffix.drawingTool.commands.application
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.graffix.drawingTool.events.chat.ChatEvent;
	import com.graffix.drawingTool.events.members.MembersListEvent;
	import com.graffix.drawingTool.model.ModelLocator;
	import com.graffix.drawingTool.view.ChatView;
	import com.graffix.drawingTool.view.UsersListView;
	
	import flash.display.DisplayObject;
	
	import mx.core.FlexGlobals;
	import mx.core.IFlexDisplayObject;
	import mx.managers.PopUpManager;
	
	public class StartApplicationCommand implements ICommand
	{
		public function StartApplicationCommand()
		{
		}
		
		private var __model:ModelLocator;
		public function execute(event:CairngormEvent):void
		{
			__model.currentState = "MainState";
			var membersEvent:MembersListEvent = new MembersListEvent(MembersListEvent.GONNECT_MEMBERS_LIST);
			membersEvent.dispatch();
			var chatEvent:ChatEvent = new ChatEvent(ChatEvent.CONNECT_SO);
			chatEvent.dispatch();
			
			createPopups();
		}
		
		private function createPopups():void
		{
			var usersListPopup:IFlexDisplayObject = PopUpManager.createPopUp(FlexGlobals.topLevelApplication as DisplayObject, UsersListView );
			usersListPopup.x = FlexGlobals.topLevelApplication.width - usersListPopup.width -10; 
			usersListPopup.y =  FlexGlobals.topLevelApplication.height - usersListPopup.height -10;
			
			__model.chatView = PopUpManager.createPopUp( FlexGlobals.topLevelApplication as DisplayObject, ChatView);
			__model.chatView.x =  usersListPopup.x - usersListPopup.width - 10;
			__model.chatView.y =  FlexGlobals.topLevelApplication.height - __model.chatView.height -10;
		}
	}
}