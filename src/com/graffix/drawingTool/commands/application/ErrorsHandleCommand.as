package com.graffix.drawingTool.commands.application
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.graffix.drawingTool.events.application.MyErrorEvent;
	
	import mx.controls.Alert;
	
	public class ErrorsHandleCommand implements ICommand
	{
		public function ErrorsHandleCommand()
		{
		}
		
		public function execute(event:CairngormEvent):void
		{
			Alert.show( (event as MyErrorEvent).error.toString(), "Error");
		}
	}
}