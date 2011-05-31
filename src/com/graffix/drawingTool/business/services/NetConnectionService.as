package com.graffix.drawingTool.business.services
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.graffix.drawingTool.events.net.NCStatusEvent;
	
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.SharedObject;

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
		
		
		private var _boardSO:SharedObject;
		
		public function get boardSO():SharedObject
		{
			if(!_boardSO)
			{
				_boardSO = SharedObject.getRemote("FCWhiteBoard.ololo.1", _netConnection.uri, true );
				_boardSO.connect( _netConnection );
			}
			return _boardSO;
		}
		
	}
}