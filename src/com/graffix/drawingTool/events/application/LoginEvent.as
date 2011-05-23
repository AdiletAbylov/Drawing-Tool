package com.graffix.drawingTool.events.application
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class LoginEvent extends CairngormEvent
	{
		public static const LOGIN:String = "LOGIN";
		public var username:String;
		public function LoginEvent(username:String)
		{
			super(LOGIN);
			this.username = username;
		}
	}
}