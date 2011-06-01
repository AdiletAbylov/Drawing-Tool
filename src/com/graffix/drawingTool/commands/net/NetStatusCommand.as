package com.graffix.drawingTool.commands.net
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.graffix.drawingTool.events.net.NCStatusEvent;
	import com.graffix.drawingTool.model.ModelLocator;
	
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
	}
}