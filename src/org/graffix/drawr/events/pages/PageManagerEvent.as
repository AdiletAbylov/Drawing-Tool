package org.graffix.drawr.events.pages
{
	import flash.events.Event;
	
	public class PageManagerEvent extends Event
	{
		public static const INIT_COMPLETE:String = "pagesInitComplete";
		
		public function PageManagerEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		override public function clone():Event
		{
			return new PageManagerEvent(type, bubbles, cancelable);
		}
		override public function toString():String
		{
			return formatToString("PageManagerEvent", "type", "bubbles", "cancelable",
				"eventPhase");
		}
	}
}