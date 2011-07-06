package com.graffix.drawingTool.events.members
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class MembersListEvent extends CairngormEvent
	{
		public static const GET_MEMBERS_LIST:String = "GET_MEMBERS_LIST";
		public function MembersListEvent(type:String="GET_MEMBERS_LIST", bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}