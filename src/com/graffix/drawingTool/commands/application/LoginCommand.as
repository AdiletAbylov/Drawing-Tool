package com.graffix.drawingTool.commands.application
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.graffix.drawingTool.business.delegates.LoginDelegate;
	import com.graffix.drawingTool.events.application.LoginEvent;
	import com.graffix.drawingTool.model.ModelLocator;
	
	import mx.rpc.IResponder;
	
	public class LoginCommand implements ICommand, IResponder
	{
		public function LoginCommand()
		{
			
		}
		private var __model:ModelLocator = ModelLocator.getInstance();
		public function execute(event:CairngormEvent):void
		{
			var delegate:LoginDelegate = new LoginDelegate(this);
			delegate.login( __model.settings.roomInstance, (event as LoginEvent).username);
		}
		
		public function result(data:Object):void
		{
			
		}
		
		public function fault(info:Object):void
		{
			
		}
	}
}