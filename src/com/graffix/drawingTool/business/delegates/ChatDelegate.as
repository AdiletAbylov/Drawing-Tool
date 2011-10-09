package com.graffix.drawingTool.business.delegates
{
	import com.graffix.drawingTool.business.services.NetConnectionServices;
	
	import flash.net.NetConnection;
	import flash.net.SharedObject;

	public class ChatDelegate
	{
		public function ChatDelegate()
		{
			
		}
		
		public function connect(prefix:String):void
		{
			NetConnectionServices.instance.createChatSO(prefix);
			var nc:NetConnection = NetConnectionServices.instance.netConnection;
			nc.call(prefix+"connect", null);
		}
				
		
		public function sendMessage(message:String, to:String, prefix:String):void
		{
			var nc:NetConnection = NetConnectionServices.instance.netConnection;
			nc.call( prefix + "sendMessage", null, message, to);
		}
		
		public function setUsername( prefix:String):void
		{
			var nc:NetConnection = NetConnectionServices.instance.netConnection;
			nc.call(prefix+"changeName", null);
		}
		
		public function setBroadcastStream(streamname:String):void
		{
			var so:SharedObject = NetConnectionServices.instance.chatSO;
			so.setProperty("broadcast", streamname);
			so.setDirty("broadcast");
		}
	}
}