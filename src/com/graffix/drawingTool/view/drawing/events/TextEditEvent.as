package com.graffix.drawingTool.view.drawing.events
{
	import flash.events.Event;
	
	public class TextEditEvent extends Event
	{
		public static const TEXT_EDIT:String = "textEdit";
		public var text:String;
		public function TextEditEvent(type:String, text:String)
		{
			super(type, true);
			this.text = text;
				
		}
	}
}