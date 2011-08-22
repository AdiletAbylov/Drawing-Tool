package com.graffix.drawingTool.view.drawing.events
{
	import flash.events.Event;
	
	import flashx.textLayout.elements.TextFlow;
	
	public class TextEditorEvent extends Event
	{
		public static const FINISH_EDIT:String = "finishEdit";
		public static const INPUT_TEXT:String = "inputText";
		public var textFlow:TextFlow;
		public function TextEditorEvent(type:String, text:TextFlow)
		{
			super(type, true);
			this.textFlow = text;
		}
	}
}