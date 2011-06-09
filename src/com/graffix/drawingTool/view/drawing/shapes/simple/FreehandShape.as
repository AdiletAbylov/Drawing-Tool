package com.graffix.drawingTool.view.drawing.shapes.simple
{
	import com.graffix.drawingTool.view.drawing.vo.ShapeDrawData;
	
	import flash.geom.Point;

	public class FreehandShape extends LineShape
	{
		public function FreehandShape()
		{
			super();
			_shapeDrawData.shapeType = FREEHAND_SHAPE;
			_commands = new Vector.<int>();
			_coords = new Vector.<Number>();
		}
		public static const FREEHAND_SHAPE:int = 4;
		
		protected var _commands:Vector.<int>;
		protected var _coords:Vector.<Number>;
		
		override public function setPoints(startPoint:Point, endPoint:Point):void
		{
			if(_commands.length == 0)
			{
				
				_commands[0] = 1;
				_coords[0] = 0;
				_coords[1] = 1;
			}
			_commands[_commands.length] = 2;
			_coords[_coords.length] = endPoint.x;
			_coords[_coords.length] = endPoint.y;
			_drawDataChanged = true;
			invalidateDisplayList();
		}
		
		override public function draw():void
		{	
			try
			{
				_spriteToDraw.graphics.lineStyle( _shapeDrawData.lineSize, _lineColor );
				_spriteToDraw.graphics.drawPath(_commands, _coords);
			}catch(e:Error)
			{
				_spriteToDraw.graphics.clear();
			}
		}
		
		override public function set shapeDrawData(value:ShapeDrawData):void
		{	
			_commands = (value.drawData.commands as Vector.<int>);
			_coords = value.drawData.coords;
			super.shapeDrawData = value;
		}
		
		override public function get shapeDrawData():ShapeDrawData
		{
			_shapeDrawData.drawData = {commands: _commands, coords:_coords};
			return super.shapeDrawData;
		}
	}
}