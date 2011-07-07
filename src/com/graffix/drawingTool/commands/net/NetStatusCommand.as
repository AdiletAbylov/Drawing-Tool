package com.graffix.drawingTool.commands.net
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.graffix.drawingTool.events.net.NCStatusEvent;
	import com.graffix.drawingTool.model.ModelLocator;
	import com.graffix.drawingTool.view.ChatView;
	import com.graffix.drawingTool.view.UsersListView;
	
	import flash.display.DisplayObject;
	
	import mx.core.FlexGlobals;
	import mx.core.IFlexDisplayObject;
	import mx.managers.PopUpManager;
	
	public class NetStatusCommand implements ICommand
	{
		public function NetStatusCommand()
		{
			
		}
		
		public function execute(event:CairngormEvent):void
		{
			switch ((event as NCStatusEvent).netStatus)
			{
				case "NetConnection.Connect.Success":
				{
					ModelLocator.getInstance().currentState = "MainState";
					createPopups();
					break;
				}
					
				case "NetConnection.Connect.Closed":
				{
					//ModelLocator.getInstance().messageText = LabelStrings.CONNECT_CLOSED;
					break;
				}
					
				case "NetConnection.Connect.Failed":
				{
					//ModelLocator.getInstance().messageText = LabelStrings.CONNECT_FAILED;
					break;
				}
					
				case "NetConnection.Connect.Rejected":
				{
					//ModelLocator.getInstance().messageText = LabelStrings.CONNECT_REJECTED;
					break;
				}
			}
		}
		private function createPopups():void
		{
			var usersListPopup:IFlexDisplayObject = PopUpManager.createPopUp(FlexGlobals.topLevelApplication as DisplayObject, UsersListView );
			usersListPopup.x = FlexGlobals.topLevelApplication.width - usersListPopup.width -10; 
			usersListPopup.y =  FlexGlobals.topLevelApplication.height - usersListPopup.height -10;
			
			ModelLocator.getInstance().chatView = PopUpManager.createPopUp( FlexGlobals.topLevelApplication as DisplayObject, ChatView);
			ModelLocator.getInstance().chatView.x =  usersListPopup.x - usersListPopup.width - 10;
			ModelLocator.getInstance().chatView.y =  FlexGlobals.topLevelApplication.height - ModelLocator.getInstance().chatView.height -10;
		}
	}
}