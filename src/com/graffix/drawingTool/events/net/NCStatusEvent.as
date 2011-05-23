package com.graffix.drawingTool.events.net
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class NCStatusEvent extends CairngormEvent
	{
		public static const NET_STATUS:String = "NET_STATUS";
		public var netStatus:String;
		public function NCStatusEvent(netStatus:String)
		{
			super(NET_STATUS);
			this.netStatus = netStatus;
		}
	}
}