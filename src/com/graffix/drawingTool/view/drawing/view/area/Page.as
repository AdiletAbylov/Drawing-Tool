package com.graffix.drawingTool.view.drawing.view.area
{
	import com.graffix.drawingTool.view.drawing.events.DrawAreaEvent;
	import com.graffix.drawingTool.view.drawing.events.EraseEvent;
	import com.graffix.drawingTool.view.drawing.events.LayoutOrderEvent;
	import com.graffix.drawingTool.view.drawing.managers.LayoutOrderManager;
	import com.graffix.drawingTool.view.drawing.shapes.BaseShape;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.FileReference;
	import flash.utils.Dictionary;
	
	import mx.controls.Label;
	import mx.core.IVisualElement;
	import mx.core.IVisualElementContainer;
	import mx.core.UIComponent;
	import mx.events.ResizeEvent;
	import mx.graphics.ImageSnapshot;
	
	import spark.components.NavigatorContent;
	
	public class Page extends NavigatorContent
	{
		public function Page()
		{
			super();
			addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove );
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown );
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(MouseEvent.CLICK, onMouseClick);
			addEventListener(ResizeEvent.RESIZE, onResize);
			addEventListener(EraseEvent.ERASE_EVENT, onEraseEvent);
		}
		
		
		private function onEraseEvent(event:EraseEvent):void
		{
			for(var i:int = 0; i < _objectsToErase.length; ++i)
			{
				removeElement( _objectsToErase[i] );
			}
			removeElement(event.eraser);
			_objectsToErase.length = 0;
		}
		
		private var _objectsToErase:Vector.<IVisualElement> = new Vector.<IVisualElement>();;
		public function detectObjectsToErase(stageMouseCoord:Point):void
		{
			stageMouseCoord = globalToLocal( stageMouseCoord);
			var eraserRect:Rectangle = new Rectangle( stageMouseCoord.x - 20, stageMouseCoord.y - 20, 40, 40);
			var length:int = numElements - 1;
			var i:int = 1;
			var visElement:IVisualElement;
			var objRect:Rectangle;
			while(i < length)
			{
				visElement = getElementAt( i );
				if(!(visElement as BaseShape).toRemove)
				{
					objRect = (visElement as DisplayObject).getBounds( this );
					if(eraserRect.intersects(objRect))
					{
						_objectsToErase[_objectsToErase.length] = visElement;
						(visElement as BaseShape).toRemove = true;
					}
				}
				++i;
			}
		}
		
		private function getBitmapData(source:DisplayObject):BitmapData
		{
			var bdata:BitmapData = new BitmapData(source.width, source.height);
			bdata.draw( source );
			return bdata;
		}
		
		
		private var _pageLabel:Label;
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			if(_redrawBackground)
			{
				drawBackground(true);
			}
			
		}
		
		override protected function createChildren():void
		{
			_background = new UIComponent();
			addElement(_background);
		}
		
		private function onMouseClick(event:MouseEvent):void
		{
			var hasShape:Boolean;
			var objects:Array = getObjectsUnderPoint(new Point(event.stageX, event.stageY));
		}
		
		private function onMouseMove(event:MouseEvent):void
		{
			dispatchEvent( new DrawAreaEvent(DrawAreaEvent.MOVE, event));
		}
		
		private function onMouseDown(event:MouseEvent):void
		{
			dispatchEvent( new DrawAreaEvent(DrawAreaEvent.DOWN, event));
		}
		
		private function onMouseUp(event:MouseEvent):void
		{
			dispatchEvent( new DrawAreaEvent(DrawAreaEvent.UP, event));
		}
		
		private var _redrawBackground:Boolean;
		private var _background:UIComponent;
		private function onResize(event:ResizeEvent):void
		{
			_redrawBackground = true;
			invalidateDisplayList();
		}
		
		private function drawBackground(transparent:Boolean):void
		{
			_background.graphics.clear();
			_background.graphics.beginFill(0xFFFFFF, transparent ? 0 : 1);
			_background.graphics.drawRect(0,0,width,height);
		}
		
		private var _filereference:FileReference;
		public function makeScreenshot():void
		{
			drawBackground(false);
			var snapShot:ImageSnapshot = ImageSnapshot.captureImage(this);
			drawBackground(true);
			_filereference = new FileReference();
			_filereference.save(snapShot.data, label + "_snapshot.png" );
		}
		
		public function clear():void
		{
			while(numElements > 1)
			{
				removeElementAt(1);
			}
		}
		
		public function destroy():void
		{
			clear();
		}
		
		private function onLayoutEvent(event:LayoutOrderEvent):void
		{
			var shape:IVisualElement = event.shape;
			_orderManager.changeElementZIndex( shape, event.direction);
		}
		
		private var _elementsByID:Dictionary = new Dictionary();
		
		public function removeShapeByID(shapeID:String):void
		{
			var element:IVisualElement = _elementsByID[shapeID] ;
			if(element)
			{
				removeElement( element);
			}
		}	
		
		public function getShapeByID(shapeID:String):BaseShape
		{
			return _elementsByID[shapeID];
		}
		
		override public function addElement(element:IVisualElement):IVisualElement
		{
			element.addEventListener(LayoutOrderEvent.CHANGE_LAYOUT_ORDER, onLayoutEvent);
			var el:IVisualElement  = super.addElement(element);
			if(element is BaseShape)
			{
				_elementsByID[ (element as BaseShape).id ] = element;
				callLater(updateElementLayout, [ element ]);
			}
			return el;
		}
		
		override public function removeElement(element:IVisualElement):IVisualElement
		{
			if(element is BaseShape)
			{
				delete _elementsByID[ (element as BaseShape).id ];
				element.removeEventListener(LayoutOrderEvent.CHANGE_LAYOUT_ORDER, onLayoutEvent);
				(element as BaseShape).destroy();
				callLater(_orderManager.updateZIndexes);
			}
			return super.removeElement(element);
		}
		
		override public function removeElementAt(index:int):IVisualElement
		{
			var element:IVisualElement = getElementAt(index);
			if(element is BaseShape)
			{
				delete _elementsByID[ (element as BaseShape).id ];
				element.removeEventListener(LayoutOrderEvent.CHANGE_LAYOUT_ORDER, onLayoutEvent);
				(element as BaseShape).destroy();
				callLater(_orderManager.updateZIndexes);
			}
			return super.removeElementAt(index);
		}
		
		private var _orderManager:LayoutOrderManager = new LayoutOrderManager(this as IVisualElementContainer);
		
		public function updateElementLayout(element:IVisualElement):void
		{
			setElementIndex( element, (element as BaseShape).zIndex);
			setElementIndex(_background, 0);
//			for(var i:int = 0; i < numElements; ++i)
//			{
//				trace("element " + i + ": " + getElementAt(i));
//			}
		}
	}
}