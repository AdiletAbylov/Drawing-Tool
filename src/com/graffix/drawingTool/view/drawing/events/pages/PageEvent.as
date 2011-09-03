package com.graffix.drawingTool.view.drawing.events.pages
{
	import com.graffix.drawingTool.view.drawing.view.area.Page;
	
	import flash.events.Event;
	
	public class PageEvent extends Event
	{
		public static const PAGE_ADDED:String = "pageAdded";
		public static const PAGE_REMOVED:String = "pageRemoved";
		public static const PAGE_SELECTED:String = "pageSelected";
		public var page:Page;
		public function PageEvent(type:String, page:Page)
		{
			super(type, bubbles, cancelable);
			this.page = page;
		}
		
		override public function clone():Event
		{
			return new PageEvent(type, page);
		}
		
		override public function toString():String
		{
			return formatToString("PageEvent", "type", "bubbles", "cancelable",
				"eventPhase");
		}
	}
}