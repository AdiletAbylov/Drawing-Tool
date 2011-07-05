package com.graffix.drawingTool.view.drawing.shapes.complex
{
	import com.graffix.drawingTool.view.drawing.events.ShapeChangedEvent;
	import com.graffix.drawingTool.view.drawing.events.TextEditorEvent;
	import com.graffix.drawingTool.view.drawing.shapes.BaseShape;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.text.TextLineMetrics;
	
	import flashx.textLayout.conversion.TextConverter;
	
	import spark.components.Group;
	import spark.components.RichText;
	
	
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
			dispatchEvent( new TextEditorEvent(TextEditorEvent.TEXT_EDIT, _shapeDrawData.text ));
		}
		
		public function setText(text:String):void
		{
			_shapeDrawData.text = text;
			_textChanged = true;
			dispatchEvent( new ShapeChangedEvent(ShapeChangedEvent.SHAPE_CHANGED, shapeDrawData ));
			invalidateDisplayList();
		}
		
		
		
		private var _textChanged:Boolean;
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			if(_textChanged)
			{
				draw();
				_textChanged = false;
			}
		}
		
		override public function draw():void
		{
			_label.textFlow = TextConverter.importToFlow(_shapeDrawData.text, TextConverter.TEXT_LAYOUT_FORMAT );
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
		
		override protected function get viewObject():DisplayObject
		{
			return textContainer;
		}
	}
}