package com.graffix.drawingTool.view.video
{
    import flash.events.Event;
    import flash.media.Camera;
    import flash.media.Video;
    import flash.net.NetStream;
    
    import mx.core.UIComponent;

    public class VideoContainer extends UIComponent
    {

        public function VideoContainer()
        {
            super();
            addEventListener(Event.RESIZE, resizeHandler);
        }

        /**
        * Video object instance.
        */
        private var _video:Video;

        public function set camera(value:Camera):void
        {
            var video:Video = new Video();
            video.attachCamera(value);
            this.video = video;
        }

        public function set stream(stream:NetStream):void
        {
            var video:Video = new Video();
            video.attachNetStream(stream);
            this.video = video;
        }
		
		
		private var _saveHDAspectRatio:Boolean;

		public function get saveHDAspectRatio():Boolean
		{
			return _saveHDAspectRatio;
		}

		public function set saveHDAspectRatio(value:Boolean):void
		{
			if(_saveHDAspectRatio != value)
			{
				_saveHDAspectRatio = value;
				_redrawVideo = true;
				invalidateDisplayList();
			}	
		}
		
		

        /**
         * Accept a Video object as source input.
         * @param video Object displaying live or on-demand streaming video.
         */
        public function set video(video:Video):void
        {
			if (_video)
			{
				try
				{
					removeChild(_video);
				}
				catch (e:Error)
				{
					// do nothing
				}
			}
           _video = video;
		   _redrawVideo = true;
		   invalidateDisplayList();
        }

		private var _redrawVideo:Boolean;
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			if(_redrawVideo)
			{
				
				if (_video)
				{
					_video.smoothing = true;
					if(_saveHDAspectRatio)
					{
						_video.width = width;
						_video.height = width * 0.5625;
						_video.y = (height - _video.height) / 2;
						
					}else{
						_video.y = 0;
						_video.width = width;
						_video.height = height;
						
					}
					addChild(_video);
					
				}
				
				_redrawVideo = false;
			}
			
			if(_saveHDAspectRatio)
			{
				graphics.beginFill(0);
				graphics.drawRect(0,0, width, height);
				graphics.endFill();
			}else
			{
				graphics.clear();
			}
			
		}
        /**
         * Resize the <code>Video</code> object so it matches the dimensions of
         * the interface component.
         * @param event <code>Event.RESIZE</code>
         */
        private function resizeHandler(event:Event):void
        {
			_redrawVideo = true;
			invalidateDisplayList();
        }
    }
}