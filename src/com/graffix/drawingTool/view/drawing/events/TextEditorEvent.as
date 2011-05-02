package com.graffix.drawingTool.view.drawing.events
{
	import flash.events.Event;
	
	public class TextEditorEvent extends Event
	{
		public static const TEXT_EDIT:String = "textEdit";
		public var text:String;
		public function TextEditorEvent(type:String, text:String)
		{
			super(type, true);
			this.text = text;
				
		}
	}
}