package com.graffix.drawingTool.commands.video
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.graffix.drawingTool.business.delegates.ChatDelegate;
	import com.graffix.drawingTool.business.delegates.video.StreamDelegate;
	import com.graffix.drawingTool.events.video.BroadcastEvent;
	import com.graffix.drawingTool.model.ModelLocator;
	
	import mx.utils.UIDUtil;
	
	public class VideoCommand implements ICommand
	{
		public function VideoCommand()
		{
		}
		
		public function execute(event:CairngormEvent):void
		{
			var streamDelegate:StreamDelegate = new StreamDelegate();
			var chatDelegate:ChatDelegate = new ChatDelegate();
			var __model:ModelLocator = ModelLocator.getInstance();
			switch(event.type)
			{
				case BroadcastEvent.PLAY_STREAM:
					__model.video = null;
					__model.video = streamDelegate.playStream( (event as BroadcastEvent).streamname );
					__model.isBroadcasting = true;
					break;
				
					
				case BroadcastEvent.STOP_STREAM:
					streamDelegate.stopStream();
					__model.video = null;
					__model.isBroadcasting = false;
					break;
				
				
				case BroadcastEvent.START_BROADCAST:
					var streamname:String = __model.user.username + UIDUtil.createUID();
					__model.video = streamDelegate.startBroadcast(streamname);
					chatDelegate.setBroadcastStream(streamname);
					break;
				
				case BroadcastEvent.STOP_BROADCAST:
					streamDelegate.stopBroadcast();
					chatDelegate.setBroadcastStream(null);
					break;
			}
		}
	}
}