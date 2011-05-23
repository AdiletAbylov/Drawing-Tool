package com.graffix.drawingTool.control
{
	import com.adobe.cairngorm.control.FrontController;
	import com.graffix.drawingTool.commands.application.InitCommand;
	import com.graffix.drawingTool.commands.net.NetStatusCommand;
	import com.graffix.drawingTool.events.application.InitEvent;
	import com.graffix.drawingTool.events.net.NCStatusEvent;
	
	public class ApplicationController extends FrontController
	{
		public function ApplicationController()
		{
			super();
			netCommands();	
		}
		
		private function appCommands():void
		{
			addCommand(InitEvent.INIT, InitCommand );
		}
		private function netCommands():void
		{
			addCommand(NCStatusEvent.NET_STATUS, NetStatusCommand);
		}
	}
}