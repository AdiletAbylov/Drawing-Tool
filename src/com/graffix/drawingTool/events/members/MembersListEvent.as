package com.graffix.drawingTool.events.members
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class MembersListEvent extends CairngormEvent
	{
		public static const GONNECT_MEMBERS_LIST:String = "GONNECT_MEMBERS_LIST";
		public static const MEMBERS_LIST_SYNC:String = "MEMBERS_LIST_SYNC";
		
		public function MembersListEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}