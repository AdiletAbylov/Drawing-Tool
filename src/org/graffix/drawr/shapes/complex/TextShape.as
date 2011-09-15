package org.graffix.drawr.shapes.complex
{
	import flash.events.MouseEvent;
	import flash.text.TextLineMetrics;
	
	import flashx.textLayout.conversion.TextConverter;
	
	import mx.states.OverrideBase;
	
	import org.graffix.drawr.events.ShapeChangedEvent;
	import org.graffix.drawr.shapes.BaseShape;
	
	import spark.components.RichText;
	
	
	public class TextShape extends BaseShape
	{
		public static const TEXT_SHAPE:int = 6;
		private var _label:RichText;
		
		public function TextShape()
		{
			super();
			this.doubleClickEnabled = true;	
			_shapeDrawData.type = TEXT_SHAPE;
			_label = new RichText();
			_label.text = "Text Label";
			_label.mouseEnabled = false;
			
			width = 120;
			height = 25;
			_shapeDrawData.width = width;
			_shapeDrawData.height = height;
			addElement( _label );
		}
		
		
		
		public function editText():void
		{
			//dispatchEvent( new TextEditorEvent(TextEditorEvent.FINISH_EDIT, _shapeDrawData.text ));
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
			_label.width = width
			_label.height = height;
		}
		
		override public function draw():void
		{
			_label.cacheAsBitmap = false;
			_label.textFlow = TextConverter.importToFlow(_shapeDrawData.text, TextConverter.TEXT_LAYOUT_FORMAT );
			_label.cacheAsBitmap = true;
		}
		
		override public function destroy():void
		{
			super.destroy();
			
			_label.textFlow = null;
			_label = null;
		}
	}
}