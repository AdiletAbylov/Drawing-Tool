package com.graffix.drawingTool.business.delegates
{
	import com.graffix.drawingTool.business.services.NetConnectionService;
	
	import flash.net.NetConnection;

	public class RoomNetConnectionDelegate
	{
		public function RoomNetConnectionDelegate()
		{
		}
		public function connect(url:String, role:String):void
		{
			var nc:NetConnection = NetConnectionService.instance.netConnection;
			nc.connect(url, role);
		}
	}
}