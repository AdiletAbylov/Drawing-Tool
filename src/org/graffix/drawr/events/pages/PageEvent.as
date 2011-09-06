package org.graffix.drawr.events.pages
{
	import org.graffix.drawr.view.area.Page;
	
	import flash.events.Event;
	
	public class PageEvent extends Event
	{
		public static const PAGE_ADDED:String = "pageAdded";
		public static const PAGE_REMOVED:String = "pageRemoved";
		public static const PAGE_SELECTED:String = "pageSelected";
		public var pageUID:String;
		public function PageEvent(type:String, pageUID:String)
		{
			super(type, bubbles, cancelable);
			this.pageUID = pageUID;
		}
		
		override public function clone():Event
		{
			return new PageEvent(type, pageUID);
		}
		
		override public function toString():String
		{
			return formatToString("PageEvent", "type", "bubbles", "cancelable",
				"eventPhase");
		}
	}
}