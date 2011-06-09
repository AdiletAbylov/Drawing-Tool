package com.graffix.drawingTool.view.drawing.shapes.complex
{
	import com.graffix.drawingTool.view.drawing.events.TextEditorEvent;
	
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
	import com.graffix.drawingTool.view.drawing.shapes.BaseShape;
	
	
	public class TextShape extends BaseShape
	{
		public static const TEXT_SHAPE:int = 6;
		private var _label:RichText;
		
		public function TextShape()
		{
			super();
			this.doubleClickEnabled = true;	
			_shapeDrawData.shapeType = TEXT_SHAPE;
		}
		
		private var textContainer:Group;
		override protected function createChildren():void
		{
			super.createChildren();
			_label = new RichText();
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
			dispatchEvent( new TextEditorEvent(TextEditorEvent.TEXT_EDIT, ss ));
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
		
		override public function destroy():void
		{
			super.destroy();
			textContainer.removeElement(_label );
			_label.textFlow = null;
			_label = null;
			removeChild(textContainer);
			textContainer = null;
			removeEventListener(MouseEvent.DOUBLE_CLICK, onDoubleClick);
		}
	}
}