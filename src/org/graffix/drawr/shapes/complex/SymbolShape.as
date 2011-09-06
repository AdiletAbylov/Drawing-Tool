package org.graffix.drawr.shapes.complex
{
	import org.graffix.drawr.shapes.BaseShape;
	
	import flash.display.DisplayObject;
	import flash.text.TextLineMetrics;
	
	import spark.components.Label;

	public class SymbolShape extends BaseShape
	{
		public static const SYMBOL_SHAPE:int = 66;
		private var _label:Label;
		public function SymbolShape()
		{
			super();
			_shapeDrawData.type = SYMBOL_SHAPE;
			_label = new Label();
			_label.maxDisplayedLines = 1;
			_label.text = " ";
			_label.setStyle("fontSize", 20);
			_label.setStyle("textAlign", "center");	
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			addChild( _label );
		}
		
		private var _textChanged:Boolean;
		public function set symbol(value:String):void
		{
			_shapeDrawData.text = value;
			_textChanged = true;
			invalidateDisplayList();
		}
		private function meauserLabel():void
		{
			var lineMetrics:TextLineMetrics = _label.measureText(_label.text);
			_label.width = lineMetrics.width + 10;
			_label.height = 20;
		}
		
		override public function draw():void
		{
			_label.text = _shapeDrawData.text;
			_label.cacheAsBitmap = true;
		}
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			if(_textChanged)
			{
				draw();
				
				_textChanged = false;
			}
			meauserLabel();
		}
		override protected function get viewObject():DisplayObject
		{
			return _label;
		}
	}
}