package org.graffix.drawr.events
{
	import flash.events.Event;
	
	public class SymbolSelectEvent extends Event
	{
		public static const SELECT:String="symbolSelect";
		public var symbol:String;
		public function SymbolSelectEvent( symbol:String)
		{
			super(SELECT, bubbles, cancelable);
			this.symbol = symbol;
		}
	}
}