package com.graffix.drawingTool.commands.drawing
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.graffix.drawingTool.business.delegates.ImageGalleryDelegate;
	import com.graffix.drawingTool.events.drawing.ImageGalleryEvent;
	import com.graffix.drawingTool.model.ModelLocator;
	
	public class ImageGalleryCommand implements ICommand
	{
		public function ImageGalleryCommand()
		{
		}
		
		public function execute(event:CairngormEvent):void
		{
			var delegate:ImageGalleryDelegate = new ImageGalleryDelegate();
			switch(event.type)
			{
				case ImageGalleryEvent.CONNECT_IMAGE_SO:
					delegate.connect();
					break;
				
				case ImageGalleryEvent.IMAGES_SYNC:
					ModelLocator.getInstance().imagesList = delegate.getFilesList();
					break;
			}
		}
	}
}