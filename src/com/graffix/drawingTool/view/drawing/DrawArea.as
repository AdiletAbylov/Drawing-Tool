package com.graffix.drawingTool.view.drawing
{
	import flash.display.Sprite;
	
	import mx.core.UIComponent;
	
	import spark.components.Group;
	
	public class DrawArea extends UIComponent
	{
		public function DrawArea()
		{
			super();
		}
		private const CELL_WIDTH:Number = 25;
		private const CELL_HEIGHT:Number = 25;
		
		private var _drawGrid:Boolean;
		private var _drawGridChanged:Boolean;
		
		public function get drawGrid():Boolean
		{
			return _drawGrid;
		}

		public function set drawGrid(value:Boolean):void
		{
			_drawGrid = value;
			_drawGridChanged = true;
			invalidateDisplayList();
		}

		override protected function createChildren():void
		{
			
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			if(_drawGridChanged)
			{
				if(_drawGrid)
				{
					drawingGrid();
				}else
				{
					graphics.clear();
				}
				_drawGridChanged = false;
			}
		}
		
		private function drawingGrid():void
		{
			//graphics.clear();
			graphics.beginFill(0xFFFFFF, 0);
			graphics.drawRect(0,0, width, height );
			graphics.endFill();
			graphics.lineStyle(1, 0x000000, 0.1);
			var position:int = 0;
			for(position; position <= this.width; position += CELL_WIDTH )
			{
				this.graphics.moveTo(position, 0);
				this.graphics.lineTo(position, this.height);
			}
			
			for(position = 0; position <= this.height; position += CELL_HEIGHT )
			{
				this.graphics.moveTo(0, position);
				this.graphics.lineTo(this.width, position);
			}
		}
	}
}