package org.graffix.drawr.events
{
	import flash.events.Event;
	
	public class ToolPropertiesEvent extends Event
	{
		public static const PROPERTY_CHANGED:String = "propertyChanged";
		public var propertyName:String;
		public var propertyValue:Object;
		public function ToolPropertiesEvent(type:String, propertyName:String, propertyValue:Object)
		{
			super(type);
			this.propertyName = propertyName;
			this.propertyValue = propertyValue;
		}
	}
}