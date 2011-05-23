package com.graffix.drawingTool.control
{
	import com.adobe.cairngorm.control.FrontController;
	import com.graffix.drawingTool.commands.net.NetStatusCommand;
	import com.graffix.drawingTool.events.net.NCStatusEvent;
	
	public class ApplicationController extends FrontController
	{
		public function ApplicationController()
		{
			super();
			netCommands();	
		}
		
		private function netCommands():void
		{
			addCommand(NCStatusEvent.NET_STATUS, NetStatusCommand);
		}
	}
}