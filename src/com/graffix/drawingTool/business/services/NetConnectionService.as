package com.graffix.drawingTool.business.services
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.graffix.drawingTool.events.members.MembersListEvent;
	import com.graffix.drawingTool.events.net.NCStatusEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.events.SyncEvent;
	import flash.net.NetConnection;
	import flash.net.SharedObject;

	public class NetConnectionService extends EventDispatcher
	{
		
		private static var __instance:NetConnectionService = null;
		
		public static function get instance():NetConnectionService
		{
			if (!__instance)
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
			//trace(event.info.code);
			MonsterDebugger.trace(this, event.info.code );
			var netStatusEvent:NCStatusEvent = new NCStatusEvent(event.info.code);
			netStatusEvent.dispatch();
		}
		
		
		
		//
		// SharedObject for drawing board objects
		private var _boardSO:SharedObject;
		
		[Bindable(event="netConnectionChanged")]
		public function get boardSO():SharedObject
		{
			
			if(!_boardSO)
			{
				_boardSO = SharedObject.getRemote("FCWhiteBoard.ololo.1", _netConnection.uri, true );
				_boardSO.connect( _netConnection );
			}
			return _boardSO;
		}
		
		
		//
		// SharedObject for members list
		private var _membersSO:SharedObject;
		
		public function get membersSO():SharedObject
		{
			if(!_membersSO)
			{
				var name:String = "_DEFAULT_";
				var prefix:String = "FuncitonPeopleList." + name + ".";
				_membersSO = SharedObject.getRemote( prefix + "usuarios", _netConnection.uri );
				_membersSO.connect(_netConnection);
				_membersSO.addEventListener(SyncEvent.SYNC, onMembersSync);
			}
			return _membersSO;
		}
		
		private function onMembersSync(event:SyncEvent):void
		{
			var membersListEvent:MembersListEvent = new MembersListEvent(MembersListEvent.MEMBERS_LIST_SYNC);
			membersListEvent.dispatch();
		}
			
	}
}