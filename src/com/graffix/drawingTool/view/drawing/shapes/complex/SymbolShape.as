package com.graffix.drawingTool.view.drawing.shapes.complex
{
	import com.graffix.drawingTool.view.drawing.shapes.BaseShape;
	
	import spark.components.Label;

	public class SymbolShape extends BaseShape
	{
		public static const SYMBOL_SHAPE:int = 66;
		private var _label:Label;
		public function SymbolShape()
		{
			super();
			_shapeDrawData.shapeType = SYMBOL_SHAPE;
			_label = new Label();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			_label.setStyle("align", "center");
			addChild( _label );
		}
		
		private var _textChanged:Boolean;
		public function set symbol(value:String):void
		{
			_shapeDrawData.text = value;
			_textChanged = true;
			invalidateDisplayList();
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			if(_textChanged)
			{
				_label.text = shapeDrawData.text;
				_textChanged = false;
			}
		}
	}
}