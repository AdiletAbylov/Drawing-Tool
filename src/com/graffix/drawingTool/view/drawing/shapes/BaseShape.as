package com.graffix.drawingTool.view.drawing.shapes
{	
	import com.graffix.drawingTool.view.drawing.events.LayoutOrderEvent;
	import com.graffix.drawingTool.view.drawing.events.ShapeChangedEvent;
	import com.graffix.drawingTool.view.drawing.events.ShapeSelectEvent;
	import com.graffix.drawingTool.view.drawing.shapes.selection.ISelectable;
	import com.graffix.drawingTool.view.drawing.vo.ShapeDrawData;
	import com.senocular.display.TransformTool;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.setTimeout;
	
	import mx.core.UIComponent;
	import mx.utils.UIDUtil;

	public class BaseShape extends UIComponent implements IDrawable, ISelectable
	{
		public static const PROPERTY_LINE_SIZE:String = "lineSize";
		public static const PROPERTY_LINE_COLOR:String = "lineColor";
		public static const PROPERTY_FILL_ENABLED:String = "hasFill";
		public static const PROPERTY_FILL_COLOR:String = "fillColor";
		
		public function BaseShape()
		{
			_transformTool = new TransformTool();
			_spriteToDraw = new Sprite();
			id = UIDUtil.createUID();
			_shapeDrawData = new ShapeDrawData();
			addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		override protected function createChildren():void
		{
			addChild( _spriteToDraw );
			addChild( _transformTool );
		}
		
		
		protected var _spriteToDraw:Sprite;
		protected var _shapeDrawData:ShapeDrawData;
		
		[Bindable]	
		public function set shapeDrawData(value:ShapeDrawData):void
		{
			_shapeDrawData = value;
			_redrawAll = true;
			invalidateDisplayList();
		}
		
		public function get shapeDrawData():ShapeDrawData
		{
			_shapeDrawData.shapeID = id;
			_shapeDrawData.x = x;
			_shapeDrawData.y = y;
			_shapeDrawData.zIndex = zIndex;
			_shapeDrawData.width = width;
			_shapeDrawData.height = height;
			if(viewObject)
			{
				_shapeDrawData.matrix = viewObject.transform.matrix;
			}
			return _shapeDrawData;
		}
		
		protected var _drawDataChanged:Boolean;
		protected var _redrawAll:Boolean;
		
		public function get type():int
		{
			return shapeDrawData.shapeType;
		}
		
		//
		// Tool Properties
		protected var _lineSizeChanged:Boolean;
		
		public function get lineSize():int
		{
			return _shapeDrawData.lineSize;
		}

		protected var _lineColorChanged:Boolean;
		public function get lineColor():uint
		{
			return _shapeDrawData.lineColor;
		}
			
		
		protected var _hasFillChanged:Boolean;
		[Bindable]
		public function get hasFill():Boolean
		{
			return _shapeDrawData.hasFill;
		}
		
		
		protected var _fillColorChanged:Boolean;
		public function get fillColor():uint
		{
			return _shapeDrawData.fillColor;
		}

		public function set hasFill(value:Boolean):void
		{
			_shapeDrawData.hasFill = value;
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
			_shapeDrawData.drawData = {startPoint:startPoint, endPoint:endPoint};
			_drawDataChanged = true;
			invalidateDisplayList();
		}
		
		public function draw():void
		{/*override in childs*/}
		
		public function startDraw():void
		{/*override in childs*/}
		
		public function finishDraw():void
		{	
			dispatchEvent( new ShapeChangedEvent(ShapeChangedEvent.SHAPE_ADDED, shapeDrawData ));
		}
		
		public function clear():void
		{
			if(_spriteToDraw)
			{
				_spriteToDraw.graphics.clear();
			}
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
			_transformTool.target = viewObject;
			_transformTool.registration = _transformTool.boundsCenter;
			_transforming = true;
			_transformTool.addEventListener(TransformTool.TRANSFORM_TARGET, onTransformTarget);
		}
		
		private function onTransformTarget(event:Event):void
		{
			dispatchEvent( new ShapeChangedEvent(ShapeChangedEvent.SHAPE_CHANGED, shapeDrawData ));
		}
		
		public function hideTransformControls():void
		{
			hideTransform();
		}
		
		protected function hideTransform():void
		{
			_transformTool.target = null;
			_transforming = false;
			_transformTool.removeEventListener(TransformTool.TRANSFORM_TARGET, onTransformTarget);
		}
		
		protected function onMouseClick(event:MouseEvent):void
		{
			// !!!!!!!!!!
			// workaround 
			// because dispathing event here
			// stops of dispatching dblClick event
			if(!transforming)
			{
				setTimeout( dispatchSelectEvent, 200);
			}
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
		
		public function destroy():void
		{
			clear();
			if(_spriteToDraw)
			{
				removeChild(_spriteToDraw);
				_spriteToDraw = null;
			}
			if(_transformTool)
			{
				removeChild(_transformTool);
				_transformTool = null;
			}
			removeEventListener(MouseEvent.CLICK, onMouseClick);
			dispatchEvent( new ShapeChangedEvent(ShapeChangedEvent.SHAPE_REMOVED, shapeDrawData));
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
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			if(_drawDataChanged)
			{
				_drawDataChanged = false;
				draw();
			}
			
			if(_redrawAll)
			{
				draw();
				if(_shapeDrawData.matrix)
				{
					viewObject.transform.matrix = _shapeDrawData.matrix;
				}
				x = _shapeDrawData.x;
				y = _shapeDrawData.y;
				_redrawAll = false;
			}
		}
		
		protected function get viewObject():DisplayObject
		{
			return _spriteToDraw;
		}
		
		
		

		public function get zIndex():uint
		{
			return _shapeDrawData.zIndex;
		}

		public function set zIndex(value:uint):void
		{
			_shapeDrawData.zIndex = value;
			dispatchEvent( new ShapeChangedEvent(ShapeChangedEvent.SHAPE_CHANGED, shapeDrawData ));
		}

	}
}