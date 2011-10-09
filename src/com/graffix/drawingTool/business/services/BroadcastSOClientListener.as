package com.graffix.drawingTool.business.services
{
	import com.graffix.drawingTool.events.video.BroadcastEvent;
	
	import flash.events.SyncEvent;
	import flash.net.SharedObject;

	public class BroadcastSOClientListener
	{
		public function BroadcastSOClientListener()
		{
		}
		
		public function syncDataHandler(event:SyncEvent):void
		{
			var name:String;
			var code:String;
			var broadcastEvent:BroadcastEvent;
			for (var i:int = 0; i<event.changeList.length; ++i) 
			{
				name = event.changeList[i].name;
				code = event.changeList[i].code;
				if (name == "broadcast")
				{
					switch(code)
					{
						case "change":
							broadcastEvent = new BroadcastEvent(BroadcastEvent.PLAY_STREAM, (event.currentTarget as SharedObject).data[name]);
							broadcastEvent.dispatch();
							break;
						
						case "delete":
							broadcastEvent = new BroadcastEvent(BroadcastEvent.STOP_STREAM);
							broadcastEvent.dispatch();
							break;
					}
				}
			}
		}	
	}
}