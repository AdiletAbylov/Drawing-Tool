package org.graffix.drawr.shapes.complex
{
	import flash.display.DisplayObject;
	import flash.text.TextLineMetrics;
	
	import org.graffix.drawr.shapes.BaseShape;
	
	import spark.components.Group;
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
			_label.setStyle("color", 0x000000);
			_label.setStyle("fontSize", 20);
			_label.setStyle("textAlign", "center");	
			_label.width = 20;
			_label.height = 20;
			_label.mouseEnabled = false;
			width = 20;
			height = 22;
			_shapeDrawData.width = width;
			_shapeDrawData.height = height;
		}
		override protected function createChildren():void
		{
			super.createChildren();
			addElement( _label );
		}
		
		private var _textChanged:Boolean;
		
		public function set symbol(value:String):void
		{
			_shapeDrawData.text = value;
			_textChanged = true;
			invalidateDisplayList();
		}
		
		
		override public function draw():void
		{
			_label.cacheAsBitmap = false;
			
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
			var xratio:Number = (width / _label.width);
			var yratio:Number = (height / _label.height);
			
			_label.scaleX = xratio;
			_label.scaleY = yratio;
			graphics.clear();
			graphics.beginFill(0xFFFFFF, 0);
			graphics.drawRect(0,0, width, height);
		}
	}
}