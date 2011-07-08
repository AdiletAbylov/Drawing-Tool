package com.graffix.drawingTool.business.delegates
{
	import com.graffix.drawingTool.business.services.NetConnectionServices;
	
	import flash.net.SharedObject;
	
	import mx.collections.ArrayCollection;

	public class ImageGalleryDelegate
	{
		public function ImageGalleryDelegate()
		{
			
		}
		
		public function connect():void
		{
			NetConnectionServices.instance.createImagesSO();
		}
		
		public function getFilesList():ArrayCollection
		{
			var list:ArrayCollection = new ArrayCollection();
			var imagesSO:SharedObject = NetConnectionServices.instance.imagesSO;
			return list;
		}
	}
}