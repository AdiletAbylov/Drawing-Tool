package com.graffix.drawingTool.events.members
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class ChangeStatusEvent extends CairngormEvent
	{
		public static const CHANGE_STATUS:String = "CHANGE_STATUS";
		public var status:int;
		public function ChangeStatusEvent(status:int)
		{
			super(CHANGE_STATUS);
			this.status = status;
		}
	}
}