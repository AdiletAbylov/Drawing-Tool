package com.graffix.drawingTool.view.drawing.shapes
{
	import com.graffix.drawingTool.view.drawing.events.TextEditEvent;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextLineMetrics;
	
	import flashx.textLayout.conversion.ConversionType;
	import flashx.textLayout.conversion.TextConverter;
	import flashx.textLayout.elements.TextFlow;
	
	import mx.controls.Label;
	import mx.core.mx_internal;
	
	import spark.components.Group;
	import spark.components.RichText;
	
	
	public class TextShape extends BaseShape
	{
		public static const TEXT_TOOL:int = 6;
		private var _label:RichText;
		
		public function TextShape(type:int)
		{
			super(type);
			this.doubleClickEnabled = true;	
			_label = new RichText();
		}
		
		private var textContainer:Group;
		override protected function createChildren():void
		{
			super.createChildren();
			
			_label.text = "Text Label";
			_label.percentWidth = 100;
			_label.percentHeight = 100;
			textContainer = new Group();
			addChild(textContainer);
			textContainer.doubleClickEnabled = true;
			_label.doubleClickEnabled = true;
			textContainer.addElement( _label );
			meauserLabel();
		}
		
		override public function finishDraw():void
		{
			super.finishDraw();
			addEventListener(MouseEvent.DOUBLE_CLICK, onDoubleClick );
		}
		
		private function onDoubleClick(event:MouseEvent):void
		{
			editText();
		}
		
		public function editText():void
		{
			var ss:String = TextConverter.export(_label.textFlow, TextConverter.TEXT_LAYOUT_FORMAT, ConversionType.STRING_TYPE).toString();
			dispatchEvent( new TextEditEvent(TextEditEvent.TEXT_EDIT, ss ));
		}
		
		public function setText(flow:String):void
		{
			_label.textFlow = TextConverter.importToFlow(flow,  TextConverter.TEXT_LAYOUT_FORMAT );
			meauserLabel();
			if(_transforming)
			{
				_transformTool.target = null;
				_transforming = false;
				//_transformTool.target = textContainer;
			}
		}
		
		private function meauserLabel():void
		{
			var lineMetrics:TextLineMetrics = _label.measureText(_label.text);
			textContainer.width = lineMetrics.width+40;
			textContainer.height = 100;
		}
		
		override protected function showTransform():void
		{
			//_transformTool.doubleClickEnabled = true;
			_transformTool.target = textContainer;
			_transformTool.registration = _transformTool.boundsCenter;
			_transforming = true;
		}
	}
}