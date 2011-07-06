package com.graffix.drawingTool.commands.members
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class ChangeStatusEvent extends CairngormEvent
	{
		public static const CHANGE_STATUS:String = "CHANGE_STATUS";
		public var status:String;
		public function ChangeStatusEvent(status:String)
		{
			super(CHANGE_STATUS);
			this.status = status;
		}
	}
}