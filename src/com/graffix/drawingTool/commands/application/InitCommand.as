package com.graffix.drawingTool.commands.application
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.graffix.drawingTool.events.net.TestConnectionEvent;
	import com.graffix.drawingTool.model.ModelLocator;
	import com.graffix.drawingTool.view.LoginView;
	
	import mx.core.FlexGlobals;
	
	public class InitCommand implements ICommand
	{
		public function InitCommand()
		{
		}
		
		public function execute(event:CairngormEvent):void
		{
			var __model:ModelLocator = ModelLocator.getInstance();
			__model.settings.roomID = FlexGlobals.topLevelApplication.parameters.roomname;
			__model.settings.roomID = "1";
			if(!__model.settings.roomID)
			{
				__model.initStatus = LoginView.ERROR;
				__model.message = "Roomname error";
				return;
			}
			__model.settings.roomID.replace(" ", "");
			if(__model.settings.roomID == "")
			{
				__model.initStatus = LoginView.ERROR;
				__model.message = "Roomname error";
				return;
			}
			
			__model.settings.role = FlexGlobals.topLevelApplication.parameters.role;
			if(!__model.settings.role || __model.settings.role == "")
			{
				__model.settings.role = "admin";
			}
			
			//__model.settings.rtmpServerUrl = FlexGlobals.topLevelApplication.parameters.serveraddress;
			//__model.settings.rtmpServerUrl = "kym85f42dv.rtmphost.com";
			//
			// test bandwidth
			
			__model.initStatus = LoginView.LOGIN;
		}
	}
}