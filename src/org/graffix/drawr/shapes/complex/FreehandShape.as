package org.graffix.drawr.shapes.complex
{
	import flash.geom.Point;
	
	import org.graffix.drawr.shapes.simple.LineShape;
	import org.graffix.drawr.vo.ShapeDrawData;
	
	import spark.components.Group;

	public class FreehandShape extends LineShape
	{
		public function FreehandShape()
		{
			super();
			_shapeDrawData.type = FREEHAND_SHAPE;
			_commands = new Vector.<int>();
			_coords = new Vector.<Number>();
			_groupToDraw = new Group();
			addElement( _groupToDraw );
		}
		public static const FREEHAND_SHAPE:int = 4;
		
		protected var _commands:Vector.<int>;
		protected var _coords:Vector.<Number>;
		
		private var _groupToDraw:Group;
		
		private const STEP_SIZE:int = 1;
		private var _currentStep:int = 0;
		
		override public function setPoints(startPoint:Point, endPoint:Point):void
		{
			super.setPoints(startPoint, endPoint);
			if(_commands.length == 0)
			{
				
				_commands[0] = 1;
				_coords[0] = 0;
				_coords[1] = 1;
			}
			++_currentStep;
			if(_currentStep == STEP_SIZE)
			{
				_commands[_commands.length] = 2;
				_coords[_coords.length] = endPoint.x;
				_coords[_coords.length] = endPoint.y;
				_currentStep = 0;
				
				findMaxMinPoints( endPoint );
			}
		}
		
		private function findMaxMinPoints(point:Point):void
		{
			if(point.x < minx)
			{
				minx = point.x; 
			}
			
			if(point.x > maxx)
			{
				maxx = point.x;
			}
			
			if(point.y < miny)
			{
				miny = point.y;
			}
			
			if(point.y > maxy)
			{
				maxy = point.y;
			}
		}
		
		private var minx:Number = 0;
		private var miny:Number = 0;
		private var maxx:Number = 0;
		private var maxy:Number = 0;
		
		
		override public function finishDraw():void
		{
			compensateShift();
			shapeDrawData.width = width;	
			shapeDrawData.height = height;
			super.finishDraw();
		}
		
		private function compensateShift():void
		{
			_groupToDraw.width = maxx - minx;
			_groupToDraw.height = maxy - miny;
			
			width = _groupToDraw.width;
			height = _groupToDraw.height;
			
			_groupToDraw.x = minx * -1;
			_groupToDraw.y = miny * -1;
			
			x = x + minx;
			y = y + miny;
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			var rrr:Boolean = _redrawAll;
			
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			if(rrr)
			{
				var xratio:Number = (width / _groupToDraw.width);
				var yratio:Number = (height / _groupToDraw.height);
				
				_groupToDraw.scaleX = xratio;
				_groupToDraw.scaleY = yratio;
			}
		}
		override public function draw():void
		{	
			try
			{
				_groupToDraw.graphics.lineStyle( _shapeDrawData.lineSize, _shapeDrawData.lineColor );
				_groupToDraw.graphics.drawPath(_commands, _coords);
				
			}catch(e:Error)
			{
				_groupToDraw.graphics.clear();
			}
		}
		
		override public function set shapeDrawData(value:ShapeDrawData):void
		{	
			_commands = value.drawData.commands as Vector.<int>;
			_coords = value.drawData.coords as Vector.<Number>;
			var length:int = _coords.length;
			for(var i:int = 1; i < length; i+=2)
			{
				findMaxMinPoints( new Point(_coords[i -1], _coords[i]));
			}
			compensateShift();
			super.shapeDrawData = value;
		}
		
		override public function get shapeDrawData():ShapeDrawData
		{
			_shapeDrawData.drawData = {commands: _commands, coords:_coords};
			return super.shapeDrawData;
		}
	}
}