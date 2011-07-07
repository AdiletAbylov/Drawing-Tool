package com.graffix.drawingTool.business.delegates
{
	import com.graffix.drawingTool.business.services.NetConnectionServices;
	
	import flash.net.NetConnection;

	public class RoomNetConnectionDelegate
	{
		public function RoomNetConnectionDelegate()
		{
		}
		public function connect(url:String, username:String, role:String):void
		{
			var nc:NetConnection = NetConnectionServices.instance.netConnection;
			nc.connect(url, username, role);
		}
	}
}