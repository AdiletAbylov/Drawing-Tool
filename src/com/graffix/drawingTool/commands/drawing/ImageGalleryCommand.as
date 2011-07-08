package com.graffix.drawingTool.commands.drawing
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.graffix.drawingTool.events.drawing.ImageGalleryEvent;
	
	public class ImageGalleryCommand implements ICommand
	{
		public function ImageGalleryCommand()
		{
		}
		
		public function execute(event:CairngormEvent):void
		{
			switch(event.type)
			{
				case ImageGalleryEvent.CONNECT_IMAGE_SO:
					
					break;
			}
		}
	}
}