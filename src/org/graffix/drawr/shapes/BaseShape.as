package org.graffix.drawr.shapes
{	
	import flash.events.Event;
	import flash.geom.Point;
	
	import mx.binding.utils.ChangeWatcher;
	import mx.utils.UIDUtil;
	
	import org.graffix.drawr.events.LayoutOrderEvent;
	import org.graffix.drawr.events.ShapeChangedEvent;
	import org.graffix.drawr.vo.ShapeDrawData;
	
	import spark.components.Group;
	
	public class BaseShape extends Group implements IDrawable
	{
		public static const PROPERTY_LINE_SIZE:String = "lineSize";
		public static const PROPERTY_LINE_COLOR:String = "lineColor";
		public static const PROPERTY_FILL_ENABLED:String = "hasFill";
		public static const PROPERTY_FILL_COLOR:String = "fillColor";
		
		public function BaseShape()
		{
			id = UIDUtil.createUID();
			_shapeDrawData = new ShapeDrawData();
		}
		
		private var _watchersArray:Array = [];
		private function startWatchModel():void
		{
			_watchersArray.push(ChangeWatcher.watch(_shapeDrawData, "x", onDrawDataChange));
			_watchersArray.push(ChangeWatcher.watch(_shapeDrawData, "y", onDrawDataChange));
			_watchersArray.push(ChangeWatcher.watch(_shapeDrawData, "width", onDrawDataChange));
			_watchersArray.push(ChangeWatcher.watch(_shapeDrawData, "height", onDrawDataChange));
			_watchersArray.push( ChangeWatcher.watch(_shapeDrawData, "rotation", onDrawDataChange));
		}
		
		private function stopWatchModel():void
		{
			for(var i:int=0; i < _watchersArray.length; ++i)
			{
				(_watchersArray[i] as ChangeWatcher).unwatch();
			}
		}
		
		protected function onDrawDataChange(event:Event):void
		{
			_redrawAll = true;
			invalidateDisplayList();
			dispatchEvent( new ShapeChangedEvent(ShapeChangedEvent.SHAPE_CHANGED, _shapeDrawData));
		}
		
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
			_shapeDrawData.pageUID = _pageUID;
			_shapeDrawData.x = x;
			_shapeDrawData.y = y;
			_shapeDrawData.zIndex = zIndex;
			_shapeDrawData.width = width;
			_shapeDrawData.height = height;
			_shapeDrawData.rotation = rotation;
			return _shapeDrawData;
		}
		
		protected var _drawDataChanged:Boolean;
		protected var _redrawAll:Boolean;
		
		public function get type():int
		{
			return shapeDrawData.type;
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
		
		public function setPoints(startPoint:Point, endPoint:Point):void
		{
			_shapeDrawData.drawData = {startPoint:startPoint, endPoint:endPoint};
			width = _shapeDrawData.drawData.startPoint.x - _shapeDrawData.drawData.endPoint.x * -1;
			height = _shapeDrawData.drawData.startPoint.y - _shapeDrawData.drawData.endPoint.y * -1;
			_shapeDrawData.width = width;
			_shapeDrawData.height = height;
			invalidateDisplayList();
		}
		
		public function draw():void
		{/*override in childs*/}
		
		public function startDraw():void
		{/*override in childs*/}
		
		public function finishDraw():void
		{	
			dispatchEvent( new ShapeChangedEvent(ShapeChangedEvent.SHAPE_ADDED, shapeDrawData ));
			startWatchModel();
		}
		
		public function clear():void
		{
			graphics.clear();
		}
		
		
		public function changeOrder(direction:String):void
		{
			var event:LayoutOrderEvent = new LayoutOrderEvent(LayoutOrderEvent.CHANGE_LAYOUT_ORDER, this, direction);
			dispatchEvent(event);
		}
		
		public function destroy():void
		{
			clear();
			stopWatchModel();
			
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
			
			
			if(_redrawAll)
			{
				width = _shapeDrawData.width;
				height = _shapeDrawData.height;
				x = _shapeDrawData.x;
				y = _shapeDrawData.y;
				rotation = _shapeDrawData.rotation;
				_redrawAll = false;
			}
			draw();
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
		
		//
		// uid of page shape in
		private var _pageUID:String;
		
		public function get pageUID():String
		{
			return _pageUID;
		}
		
		public function set pageUID(value:String):void
		{
			_pageUID = value;
		}
	}
}