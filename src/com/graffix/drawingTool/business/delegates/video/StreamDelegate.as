package com.graffix.drawingTool.business.delegates.video
{
	import com.graffix.drawingTool.business.managers.DeviceManager;
	import com.graffix.drawingTool.business.services.NetConnectionServices;
	
	import flash.media.Video;
	import flash.net.NetStream;

	public class StreamDelegate
	{
		public function StreamDelegate()
		{
			
		}
		
		public function playStream(streamName:String):Video
		{
			var stream:NetStream = NetConnectionServices.instance.videoStream;
			stream.play(streamName);
			var video:Video = new Video();
			video.attachNetStream(stream);
			return video;
		}
		
		public function stopStream():void
		{
			closeStream();
		}
		
		private function closeStream():void
		{	
			var stream:NetStream = NetConnectionServices.instance.videoStream;
			stream.close();
		}
		
		public function startBroadcast(streamName:String):Video
		{
			var stream:NetStream = NetConnectionServices.instance.videoStream;
			if(!DeviceManager.instance.camera)
			{
				DeviceManager.instance.initDevices();
			}
			stream.attachAudio(DeviceManager.instance.microphone);
			stream.attachCamera(DeviceManager.instance.camera);
			var video:Video = new Video();
			video.attachCamera(DeviceManager.instance.camera);
			return video;
		}
		
		public function stopBroadcast():void
		{
			closeStream();
		}
		
	}
}