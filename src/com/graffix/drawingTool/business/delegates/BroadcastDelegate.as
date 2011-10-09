package com.graffix.drawingTool.business.delegates
{
	import com.graffix.drawingTool.business.services.NetConnectionServices;
	
	import flash.net.SharedObject;

	public class BroadcastDelegate
	{
		public function BroadcastDelegate()
		{
		}
		public function connect():void
		{
			NetConnectionServices.instance.broadcastSO;
		}
		public function setBroadcastStream(streamname:String):void
		{
			var so:SharedObject = NetConnectionServices.instance.broadcastSO;
			so.setProperty("broadcast", streamname);
			so.setDirty("broadcast");
		}
	}
}