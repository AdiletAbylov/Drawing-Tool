package com.graffix.drawingTool.business.delegates
{
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	
	import mx.rpc.IResponder;
	
	public class LoginDelegate
	{
		public function LoginDelegate(responder:IResponder)
		{
			_responder = responder;
		}
		private var _responder:IResponder;
		
		private var _nc:NetConnection;
		public function login(url:String, username:String):void
		{
			_nc = new NetConnection();
			_nc.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
			_nc.connect(url, username);
		}
		
		private function onNetStatus(event:NetStatusEvent):void
		{
			trace("event.info.code: " + event.info.code);
			switch(event.info.code)
			{
				case "NetConnection.Connect.Success":
				{
					_responder.result("success");
					break;
				}
				default:
					_responder.fault("fault");
					break;
			}
			_nc.removeEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
			_nc.close();
			_nc = null;
			_responder = null;
		}
	}
}