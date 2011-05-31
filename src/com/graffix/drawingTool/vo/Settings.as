package com.graffix.drawingTool.vo
{
	[Bindable]
	public class Settings
	{
		public function Settings()
		{
		}
		
		public var rtmpServerUrl:String = "kym85f42dv.rtmphost.com"
		public var ports:Array = [0, 1935, 8080, 21, 23, 110, 143, 993, 995, 80];
		public var roomID:String;
		public var role:String = "guest";
		
		
		public var roomAppname:String = "eroom/";
		public var speedTestAppname:String = "speedTest/";
		
		public function get roomInstance():String
		{
			return "rtmp://" + rtmpServerUrl + ":1935/" + roomAppname  + roomID;
		}
	}
}