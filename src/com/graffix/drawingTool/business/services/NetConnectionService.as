package com.graffix.drawingTool.business.services
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.graffix.drawingTool.events.net.NCStatusEvent;
	
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;

	public class NetConnectionService
	{
		
		private static var __instance:NetConnectionService = null;
		
		public static function get instance():NetConnectionService
		{
			if (__instance == null)
			{
				__instance = new NetConnectionService();
			}
			return __instance;
		}
		
		public function NetConnectionService()
		{
			if (__instance)
			{
				throw new Error("Only one instance of NetConnectionService should be instantiated!");
			}
		}
		
		private var _netConnection:NetConnection;
		public function get netConnection():NetConnection
		{
			if (!_netConnection)
			{
				_netConnection = new NetConnection();
				_netConnection.client = this;
				_netConnection.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus );
			}
			
			return _netConnection;
		}
		
		private function onNetStatus(event:NetStatusEvent):void
		{
			trace(event.info.code);
			MonsterDebugger.trace(this, event.info.code );
			var netStatusEvent:NCStatusEvent = new NCStatusEvent(event.info.code);
			netStatusEvent.dispatch();
		}
	}
}