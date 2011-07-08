package com.graffix.drawingTool.business.services
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.graffix.drawingTool.events.drawing.ImageGalleryEvent;
	import com.graffix.drawingTool.events.members.MembersListEvent;
	import com.graffix.drawingTool.events.net.NCStatusEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.events.SyncEvent;
	import flash.net.NetConnection;
	import flash.net.SharedObject;

	public class NetConnectionServices extends EventDispatcher
	{
		
		private static var __instance:NetConnectionServices = null;
		
		public static function get instance():NetConnectionServices
		{
			if (!__instance)
			{
				__instance = new NetConnectionServices();
			}
			return __instance;
		}
		
		public function NetConnectionServices()
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
		
		public function getMembersSO(prefix:String=""):SharedObject
		{
			if(!_membersSO)
			{	
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
		
		
		//
		// SharedObject for chat
		
		private var _chatSO:SharedObject;
		
		public function get chatSO():SharedObject
		{
			if(!_chatSO)
			{
				throw new Error("SharedObject is not created yet. Call createChatSO method first.");
			}
			return _chatSO;
		}
		
		public function createChatSO(prefix:String=""):void
		{
			_chatSO = SharedObject.getRemote(prefix + "message", netConnection.uri );
			_chatSO.connect( _netConnection);
			var clientObject:ChatSOClientListener = new ChatSOClientListener();
			_chatSO.client = clientObject;
		}
		
		//
		// SharedObject for image files
		private var _imagesSO:SharedObject;
		
		public function get imagesSO():SharedObject
		{
			if(!_imagesSO)
			{
				throw new Error("SharedObject is not created yet. Call createChatSO method first.");
			}
			return _imagesSO;
		}
		
		public function createImagesSO():void
		{
			_imagesSO = SharedObject.getRemote("filelist", netConnection.uri, true );
			_imagesSO.connect( _netConnection);
			_imagesSO.addEventListener(SyncEvent.SYNC, onImagesSOSync);
		}
		
		private function onImagesSOSync(event:SyncEvent):void
		{
			var imageEvent:ImageGalleryEvent  = new ImageGalleryEvent(ImageGalleryEvent.IMAGES_SYNC);
			imageEvent.dispatch();
		}
	}
}