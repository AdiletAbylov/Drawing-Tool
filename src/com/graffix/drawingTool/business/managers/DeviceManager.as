package com.graffix.drawingTool.business.managers
{
	import flash.media.Camera;
	import flash.media.Microphone;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class DeviceManager
	{
		public static const NORMAL_MODE:String = "normal";
		public static const HD_MODE:String = "hdMode";
		public static const HD_WIDE_MODE:String = "hdWideMode";
		public static const HD_MODE_2:String = "hdMode2";
		
		public static const DEFAULT_BANDWIDTH:int = 1048576;
		public static const HD_BANDWIDTH:int = 2097152;
		
		public static const DEFAULT_MIC_GAIN:int = 75;
		
		private static var __instance:DeviceManager = new DeviceManager();
		
		public static function get instance():DeviceManager
		{
			return __instance;
		}
		
		public function DeviceManager()
		{
			if (__instance)
			{
				throw new Error("You can not create class instances with constructor. For access to instance use DeviceManager.instance.");
			}
		}
		
		public var selectedCameraModeIndex:int = 0;
		
		public var accessMuted:Boolean;
		
		public var microphoneMuted:Boolean = false;
		
		private const VIDEO_HEIGHT:int = 240;
		private const VIDEO_WIDTH:int = 320;
		
		private const HD_VIDEO_WIDTH:int = 640;
		private const HD_VIDEO_HEIGHT:int = 480;
		
		private const HD_VIDEO2_WIDTH:int = 720;
		private const HD_VIDEO2_HEIGHT:int = 480;
		
		private const HD_WIDE_VIDEO_WIDTH:int = 1280;
		private const HD_WIDE_VIDEO_HEIGHT:int = 720;
		private const DEFAULT_FPS:int = 15;
		
		public var currentMode:String = NORMAL_MODE;
		
		private var _automaicQuality:Boolean = false;
		
		private var _bandwidth:Number = 1048576;
		
		private var _camera:Camera;
		
		private var _camerasList:ArrayCollection;
		
		private var _micGainOldValue:Number = 25;
		
		private var _microphone:Microphone;
		
		private var _microphonesList:ArrayCollection;
		
		private var _oldCameraIndex:int;
		
		private var _oldMicrophoneIndex:int;
		
		public function get automaticVideoQuality():Boolean
		{
			return _automaicQuality;
		}
		
		public function set automaticVideoQuality(value:Boolean):void
		{
			_automaicQuality = value;
			
			if (_automaicQuality)
			{
				_camera.setQuality(_bandwidth, 0);
			}
		}
		
		public function get bandwidth():int
		{
			return _camera.bandwidth;
		}
		
		public function set bandwidth(value:int):void
		{
			_camera.setQuality(value, _camera.quality);
		}
		
		public function get camera():Camera
		{
			return _camera;
		}
		
		public function set camera(value:Camera):void
		{
			_camera = value;
		}
		
		public function get cameraFPS():int
		{
			return _camera.fps;
		}
		
		public function set cameraFPS(fps:int):void
		{
			setCameraMode(fps);
		}
		
		private function setCameraMode(fps:int):void
		{
			switch(currentMode)
			{
				case NORMAL_MODE:
					_camera.setMode(VIDEO_WIDTH, VIDEO_HEIGHT, fps, false);
					_camera.setQuality(DEFAULT_BANDWIDTH, 90);
					break;
				
				case HD_MODE:
					_camera.setMode(HD_VIDEO_WIDTH, HD_VIDEO_HEIGHT, fps, false);
					_camera.setQuality(DEFAULT_BANDWIDTH, 90);
					break;
				
				case HD_MODE_2:
					_camera.setMode(HD_VIDEO2_WIDTH, HD_VIDEO2_HEIGHT, fps, false);
					_camera.setQuality(DEFAULT_BANDWIDTH, 90);
					
				case HD_WIDE_MODE:
					_camera.setMode(HD_WIDE_VIDEO_WIDTH, HD_WIDE_VIDEO_HEIGHT, fps, false);
					_camera.setQuality(DEFAULT_BANDWIDTH, 80);
					break;
			}
		}
		
		public function resetCameraMode():void
		{
			setCameraMode( _camera.fps);
		}
		
		public function get cameraQuality():Number
		{
			if (!_camera)
			{
				return 0;
			}
			return _camera.quality;
		}
		
		public function set cameraQuality(q:Number):void
		{
			_camera.setQuality(_bandwidth, q);
		}
		
		public function get camerasList():ArrayCollection
		{
			return _camerasList;
		}
		
		public function disableCamera():void
		{
			_oldCameraIndex = _camera.index;
			camera = null;
		}
		
		public function disableMicrophone():void
		{
			if (_microphone)
			{
				_oldMicrophoneIndex = _microphone.index;
				_micGainOldValue = _microphone.gain;
				_microphone = null;
			}
		}
		
		public function enableCamera():void
		{
			selectCamera(_oldCameraIndex);
		}
		
		public function enableMicrophone():void
		{	
			selectMicrophone(_oldMicrophoneIndex);
		}
		
		public function get hasCamera():Boolean
		{
			return (_camerasList.length > 0) ? true : false;
		}
		
		public function get hasMic():Boolean
		{
			return (_microphonesList.length > 0) ? true : false;
		}
		
		public function initDevices():void
		{
			_microphonesList = new ArrayCollection();
			
			for (var i:int = 0; i < Microphone.names.length; ++i)
			{
				_microphonesList.addItem({ label: Microphone.names[i]});
			}
			
			_microphone = Microphone.getMicrophone();
			
			if (_microphone != null)
			{	
				_microphone.setUseEchoSuppression(true);
				_microphone.gain = DEFAULT_MIC_GAIN;
			}
			_camerasList = new ArrayCollection();
			
			for (i = 0; i < Camera.names.length; ++i)
			{
				_camerasList.addItem({ label: Camera.names[i]});
			}
			
			_camera = Camera.getCamera();
			
			if (_camera != null)
			{
				_camera.setLoopback(true);
				setCameraMode(DEFAULT_FPS);
				
			}
		}
		
		public function get microphone():Microphone
		{
			return _microphone;
		}
		
		public function get microphoneActivity():int
		{
			return _microphone.activityLevel;
		}
		
		public function set microphoneEchoSuppression(value:Boolean):void
		{
			if (_microphone)
			{
				_microphone.setUseEchoSuppression(value);
			}
		}
		
		public function get microphonesList():ArrayCollection
		{
			return _microphonesList;
		}
		
		
		public function selectCamera(index:int):void
		{   
			camera = Camera.getCamera(index.toString());
			_camera.setLoopback(true);
			setCameraMode(DEFAULT_FPS);
			//_camera.setQuality(DEFAULT_BANDWIDTH, 90);
		}
		
		public function selectMicrophone(index:int):void
		{
			_microphone = Microphone.getMicrophone(index);
			_microphone.gain = _micGainOldValue;
		}
		
		public function setMicrophoneGain(gain:Number):void
		{
			_microphone.gain = gain;
		}
		
		public function toggleMicrophoneMute():void
		{
			microphoneMuted = microphoneMuted ? false : true;
			
			if (microphoneMuted)
			{
				_micGainOldValue = _microphone.gain;
				_microphone.gain = 0;
			}
			else
			{
				_microphone.gain = _micGainOldValue;
			}
		}
	}
}