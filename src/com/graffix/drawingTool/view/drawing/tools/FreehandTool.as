package com.graffix.drawingTool.view.drawing.tools
{
	import flash.geom.Point;

	public class FreehandTool extends LineTool
	{
		public function FreehandTool(type:int)
		{
			super(type);
		}
		public static const FREEHAND_TOOL:int = 4;
		
		private var _commands:Vector.<int>;
		private var _coords:Vector.<Number>;
		
		override public function setPoints(startPoint:Point, endPoint:Point):void
		{
			if(!_commands)
			{
				_commands = new Vector.<int>();
				_coords = new Vector.<Number>();
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
			_spriteToDraw.graphics.lineStyle( _lineSize, _lineColor );
			_spriteToDraw.graphics.drawPath(_commands, _coords);
		}
	}
}