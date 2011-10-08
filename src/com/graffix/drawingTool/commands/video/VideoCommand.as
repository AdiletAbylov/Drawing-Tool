package com.graffix.drawingTool.commands.video
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.graffix.drawingTool.business.delegates.video.StreamDelegate;
	import com.graffix.drawingTool.events.video.BroadcastEvent;
	import com.graffix.drawingTool.model.ModelLocator;
	
	public class VideoCommand implements ICommand
	{
		public function VideoCommand()
		{
		}
		
		public function execute(event:CairngormEvent):void
		{
			var delegate:StreamDelegate = new StreamDelegate();
			switch(event.type)
			{
				case BroadcastEvent.PLAY_STREAM:
					ModelLocator.getInstance().video = delegate.playStream( (event as BroadcastEvent).streamname );
					break;
				
					
				case BroadcastEvent.STOP_STREAM:
					delegate.stopStream();
					break;
				
				
				case BroadcastEvent.START_BROADCAST:
					ModelLocator.getInstance().video = delegate.startBroadcast((event as BroadcastEvent).streamname);
					break;
				
				case BroadcastEvent.STOP_BROADCAST:
					delegate.stopBroadcast();
					break;
			}
		}
	}
}