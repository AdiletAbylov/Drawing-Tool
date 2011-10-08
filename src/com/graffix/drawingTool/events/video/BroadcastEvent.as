package com.graffix.drawingTool.events.video
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class BroadcastEvent extends CairngormEvent
	{
		public static const PLAY_STREAM:String = "PLAY_STREAM";
		public static const STOP_STREAM:String = "STOP_STREAM";
		public static const START_BROADCAST:String = "START_BROADCAST";
		public static const STOP_BROADCAST:String  = "STOP_BROADCAST";
		public var streamname:String;
		public function BroadcastEvent(type:String, streamname:String="")
		{
			super(type, bubbles, cancelable);
			this.streamname = streamname;
		}
	}
}