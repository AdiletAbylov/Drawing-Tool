package org.graffix.drawr.events
{
	import org.graffix.drawr.vo.ShapeDrawData;
	
	import flash.events.Event;
	
	public class ShapeChangedEvent extends Event
	{
		public static const SHAPE_ADDED:String = "shapeAdded";
		public static const SHAPE_CHANGED:String = "shapeChanged";
		public static const SHAPE_REMOVED:String = "shapeRemoved";
		public var shapeData:ShapeDrawData;
		public function ShapeChangedEvent(type:String, shapeData:ShapeDrawData)
		{
			super(type, true);
			this.shapeData = shapeData;
		}
	}
}