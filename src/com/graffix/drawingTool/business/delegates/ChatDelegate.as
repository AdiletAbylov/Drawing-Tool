package com.graffix.drawingTool.business.delegates
{
	import com.graffix.drawingTool.business.services.NetConnectionServices;
	
	import flash.net.NetConnection;

	public class ChatDelegate
	{
		public function ChatDelegate()
		{
			
		}
		
		public function sendMessage(message:String, to:String, prefix:String):void
		{
			var nc:NetConnection = NetConnectionServices.instance.netConnection;
			nc.call( prefix + "sendMessage", null, message, to);
		}
	}
}