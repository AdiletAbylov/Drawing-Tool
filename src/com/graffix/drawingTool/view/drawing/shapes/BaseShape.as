package com.graffix.drawingTool.view.drawing.shapes
{	
	import com.graffix.drawingTool.view.drawing.events.LayoutOrderEvent;
	import com.graffix.drawingTool.view.drawing.events.ShapeSelectEvent;
	import com.senocular.display.TransformTool;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.setTimeout;
	
	import mx.core.UIComponent;
	
	import spark.primitives.Rect;
	import com.graffix.drawingTool.view.drawing.shapes.selection.ISelectable;

	public class BaseShape extends UIComponent implements IDrawable, ISelectable
	{
		public static const PROPERTY_LINE_SIZE:String = "lineSize";
		public static const PROPERTY_LINE_COLOR:String = "lineColor";
		public static const PROPERTY_FILL_ENABLED:String = "hasFill";
		public static const PROPERTY_FILL_COLOR:String = "fillColor";
		
		public function BaseShape()
		{
			_type = type;
			_transformTool = new TransformTool();
			_spriteToDraw = new Sprite();
			
		}
		
		override protected function createChildren():void
		{
			addChild( _spriteToDraw );
			addChild( _transformTool );
		}
		
		
		protected var _spriteToDraw:Sprite;
		protected var _drawData:Object;
		protected var _drawDataChanged:Boolean;
		
		protected var _type:int;
		public function get type():int
		{
			return _type;
		}
		
		//
		// Tool Properties
		[Bindable]
		protected var _lineSize:int = 2;
		protected var _lineSizeChanged:Boolean;
		
		public function get lineSize():int
		{
			return _lineSize;
		}

		protected var _lineColor:uint = 0x000000;
		protected var _lineColorChanged:Boolean;
		public function get lineColor():uint
		{
			return _lineColor;
		}
			
		protected var _hasFill:Boolean;
		protected var _hasFillChanged:Boolean;
		public function get hasFill():Boolean
		{
			return _hasFill;
		}
		
		protected var _fillColor:uint = 0xFFFFFF;
		protected var _fillColorChanged:Boolean;
		public function get fillColor():uint
		{
			return _fillColor;
		}

		public function set hasFill(value:Boolean):void
		{
			_hasFill = value;
		}
		
		
		public function setProperty(name:String, value:Object):void
		{
			/*override in childs*/
		}
		
		

		public function get transforming():Boolean
		{
			return _transforming;
		}

		public function setPoints(startPoint:Point, endPoint:Point):void
		{
			_drawData = {startPoint:startPoint, endPoint:endPoint};
			_drawDataChanged = true;
			invalidateDisplayList();
		}
		
		
		
		public function draw():void
		{/*override in childs*/}
		
		public function startDraw():void
		{/*override in childs*/}
		
		public function finishDraw():void
		{	
			addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		public function clear():void
		{
			_spriteToDraw.graphics.clear();
		}

		
		//
		// TRANSFORM AND SELECTION
		//
		protected var _transformTool:TransformTool;
		protected var _transforming:Boolean;
		
		public function showTransformControls():void
		{
			showTransform();
		}
		
		protected function showTransform():void
		{
			_transformTool.target = _spriteToDraw;
			_transformTool.registration = _transformTool.boundsCenter;
			_transforming = true;
		}
		
		public function hideTransformControls():void
		{
			hideTransform();
		}
		
		protected function hideTransform():void
		{
			_transformTool.target = null;
			_transforming = false;
		}
		
		protected function onMouseClick(event:MouseEvent):void
		{
			//
			// workaround 
			// because dispathicg event here
			// stops of dispatching dblClick event
			setTimeout( dispatchSelectEvent, 200);
		}
		
		private function dispatchSelectEvent():void
		{
			dispatchEvent(new ShapeSelectEvent(ShapeSelectEvent.SHAPE_SELECT));
		}
		
		
		public function changeOrder(direction:String):void
		{
			var event:LayoutOrderEvent = new LayoutOrderEvent(LayoutOrderEvent.CHANGE_LAYOUT_ORDER, this, direction);
			dispatchEvent(event);
		}
		
		
		override protected function keyDownHandler(event:KeyboardEvent):void
		{
			if(event.ctrlKey)
			{
				if(_transforming)
				{
					_transformTool.constrainScale = true;
				}
			}
		}
		
		override protected function keyUpHandler(event:KeyboardEvent):void
		{
			if(_transformTool.constrainScale){
				_transformTool.constrainScale = false;
			}
		}
		
		public function destroy():void
		{
			clear();
			removeChild(_spriteToDraw);
			_spriteToDraw = null;
			removeChild(_transformTool);
			_transformTool = null;
			removeEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		
		private var _toRemove:Boolean;

		public function get toRemove():Boolean
		{
			return _toRemove;
		}

		public function set toRemove(value:Boolean):void
		{
			_toRemove = value;
		}

	}
}