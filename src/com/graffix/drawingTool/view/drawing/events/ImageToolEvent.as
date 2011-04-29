package com.graffix.drawingTool.view.drawing.events
{
	import flash.events.Event;
	
	public class ImageToolEvent extends Event
	{
		public static const SHOW_GALLERY:String = "showGallery";
		public static const INSERT_IMAGE:String = "insertImage";
		public var image:Class;
		public var width:Number;
		public var height:Number;
		public function ImageToolEvent(type:String, image:Class=null, width:Number = 0, height:Number = 0)
		{
			super(type, true, cancelable);
			this.image = image;
			this.width = width;
			this.height = height;
		}
	}
}