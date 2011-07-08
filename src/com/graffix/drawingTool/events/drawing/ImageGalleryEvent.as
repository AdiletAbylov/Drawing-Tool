package com.graffix.drawingTool.events.drawing
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class ImageGalleryEvent extends CairngormEvent
	{
		public static const CONNECT_IMAGE_SO:String = "CONNECT_IMAGE_SO";
		 
		public function ImageGalleryEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}