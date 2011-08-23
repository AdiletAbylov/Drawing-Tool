package com.graffix.drawingTool.view.drawing.managers
{
	import com.graffix.drawingTool.view.drawing.events.DrawAreaEvent;
	import com.graffix.drawingTool.view.drawing.events.ImageShapeEvent;
	import com.graffix.drawingTool.view.drawing.events.ShapeSelectEvent;
	import com.graffix.drawingTool.view.drawing.shapes.BaseShape;
	import com.graffix.drawingTool.view.drawing.shapes.complex.EraserShape;
	import com.graffix.drawingTool.view.drawing.shapes.complex.ImageShape;
	import com.graffix.drawingTool.view.drawing.shapes.complex.SymbolShape;
	import com.graffix.drawingTool.view.drawing.shapes.factory.ShapesFactory;
	import com.graffix.drawingTool.view.drawing.shapes.selection.SelectTool;
	import com.graffix.drawingTool.view.drawing.view.area.DrawArea;
	import com.graffix.drawingTool.view.drawing.view.editors.ImagesGallery;
	import com.graffix.drawingTool.view.drawing.vo.ShapeDrawData;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.core.IVisualElement;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	
	public class DrawManager extends EventDispatcher
	{
		public function DrawManager(drawArea:DrawArea)
		{
			_drawArea = drawArea;
			_drawArea.addEventListener(DrawAreaEvent.CLICK, onMouseClick );
			_drawArea.addEventListener(DrawAreaEvent.MOVE, onMouseMove );
			_drawArea.addEventListener(DrawAreaEvent.DOWN, onMouseDown );
			_drawArea.addEventListener( DrawAreaEvent.UP, onMouseUp);
			_drawArea.addEventListener( MouseEvent.ROLL_OUT, onMouseOut);
			
			_drawArea.addEventListener(ShapeSelectEvent.SHAPE_SELECT, onShapeSelect);
			_drawArea.addEventListener(ImageShapeEvent.SHOW_GALLERY, onShowGalleryEvent);
			//
			// transforming mode is default 
			_selectedTool = SelectTool.TRANSFORM_TOOL;
			drawMode = DrawMode.TRANSFROM_MODE;
		}
		
		protected function onMouseOut(event:MouseEvent):void
		{
			if(_drawMode == DrawMode.DRAW_MODE)
			{
				endDraw();
			}
		}		
		
		/**
		 * Reference to the draw area
		 * */
		private var _drawArea:DrawArea;
		
		
		/**
		 * current selected tool id. By default transform tool is selected
		 * Tool draws or creates shapes
		 * */
		private var _selectedTool:int;
		
		public function get selectedTool():int
		{
			return _selectedTool;
		}
		
		public function set selectedTool(value:int):void
		{
			_selectedTool = value;
			if( _currentShape )
			{
				_currentShape.hideTransformControls();
				_currentShape = null;
			}
			
			switch(_selectedTool)
			{
				case SelectTool.TRANSFORM_TOOL:
					drawMode = DrawMode.TRANSFROM_MODE;
					break;
				
				case EraserShape.ERASER_SHAPE:
					drawMode = DrawMode.ERASE_MODE;
					break;
				
				default:
					drawMode = DrawMode.DRAW_MODE;
					break;
			}
		}
		
		/**
		 * Object handles some data received from ToolsView
		 * used for special symbols shapes
		 * */
		private var _toolData:Object;
		public function set toolData(value:Object):void
		{
			_toolData = value;
		}
		
		/**
		 * Shape what is drawing, tranforming, editing right now.
		 * */
		[Bindable]
		public var _currentShape:BaseShape;
		
		private var _drawMode:int;

		[Bindable(event="changeDrawMode")]
		/**
		 * Current draw mode.
		 * Modes are: DRAWING, TRANSFORMING, EDITING, ERASING
		 * 
		 * */
		public function get drawMode():int
		{
			return _drawMode;
		}

		/**
		 * @private
		 */
		public function set drawMode(value:int):void
		{
			if( _drawMode !== value)
			{
				_drawMode = value;
				dispatchEvent(new Event("changeDrawMode"));
			}
		}
		
		
		//
		// --------------- DRAWING METHODS -------------------
		//
		private function createShapeToDraw(stageX:Number, stageY:Number):void
		{
			var tool:BaseShape = ShapesFactory.createTool( _selectedTool );
			var startPoint:Point = new Point(stageX, stageY);
			startPoint = _drawArea.globalToLocal( startPoint );
			tool.x = startPoint.x;
			tool.y = startPoint.y;
			tool.startDraw();
			_drawArea.addChildToCurrentPage( tool );
			_currentShape = tool;
		}
		
		private function startDraw(stageX:Number, stageY:Number):void
		{
			switch(_selectedTool)
			{
				case ImageShape.IMAGE_SHAPE:
					if(!_galleryWindowPopuped)
					{
						createShapeToDraw(stageX, stageY);
						showGalleryWindow();
					}
					return;
					
				default:
					createShapeToDraw(stageX, stageY);
					break;
			}
		}
		
		private function drawShape(stageX:Number, stageY:Number):void
		{
			if(_currentShape)
			{
				_currentShape.setPoints( new Point(0,0), _currentShape.globalToLocal( new Point(stageX, stageY )));
			}
		}
		
		
		private function endDraw():void
		{
			switch(_drawMode)
			{
				case DrawMode.DRAW_MODE:
					if( _currentShape.type != ImageShape.IMAGE_SHAPE)
					{
						if(_currentShape.type == SymbolShape.SYMBOL_SHAPE)
						{
							(_currentShape as SymbolShape).symbol = _toolData as String;
						}
						_currentShape.finishDraw();
						drawMode = DrawMode.TRANSFROM_MODE;
						_currentShape.showTransformControls();
					}
					break;
				
				case DrawMode.ERASE_MODE:
					_currentShape.finishDraw();
					break;
			}
		}
		//
		// --------------- HANDLE MOUSE EVENTS-----------------
		//
		protected function onMouseDown(event:DrawAreaEvent):void
		{
			switch(_drawMode)
			{
				case DrawMode.DRAW_MODE:
					startDraw(event.mouseEvent.stageX, event.mouseEvent.stageY);
					break;
				
				case DrawMode.ERASE_MODE:
					startDraw(event.mouseEvent.stageX, event.mouseEvent.stageY);
					break;
			}
		}
		
		protected function onMouseMove(event:DrawAreaEvent):void
		{
			switch(_drawMode)
			{
				case DrawMode.DRAW_MODE:
					drawShape( event.mouseEvent.stageX, event.mouseEvent.stageY);
					break;
				
				case DrawMode.ERASE_MODE:
					drawShape(event.mouseEvent.stageX, event.mouseEvent.stageY);
					_drawArea.currentPage.detectObjectsToErase( new Point(event.mouseEvent.stageX, event.mouseEvent.stageY) );
					break;
			}
		}
		
		protected function onMouseUp(event:DrawAreaEvent):void
		{
			endDraw();
		}
		
		
		
		protected function onMouseClick(event:DrawAreaEvent):void
		{
//			if(_currentShape && _currentShape.transforming)
//			{
//				_currentShape.hideTransformControls();
//				_currentShape = null;
//			}
		}
		
		//
		// -------------- IMAGES GALLERY WINDOW --------------------
		//
		
		private var _galleryWindow:ImagesGallery;
		private var _galleryWindowPopuped:Boolean;
		
		private function showGalleryWindow():void
		{
			if(_galleryWindow)
			{
				PopUpManager.addPopUp( _galleryWindow, _drawArea);
			}
			else
			{
				_galleryWindow = new ImagesGallery();
				_galleryWindow.addEventListener(CloseEvent.CLOSE, onGalleryWindowClose);
				_galleryWindow.addEventListener(ImageShapeEvent.INSERT_IMAGE, onInsertImage);
				PopUpManager.addPopUp( _galleryWindow, _drawArea );
				PopUpManager.centerPopUp( _galleryWindow);
			}
			_galleryWindowPopuped = true;
		}
		
		private function onInsertImage(event:ImageShapeEvent):void
		{
			(_currentShape as ImageShape).insertImage( event.image, event.width, event.height );
		}
		
		private function onGalleryWindowClose(event:CloseEvent):void
		{
			_galleryWindowPopuped = false;
			if( (_currentShape as ImageShape).empty )
			{
				_drawArea.removeChildFromCurrentPage( _currentShape );
			}
			else
			{
				_currentShape.finishDraw();
			}
			_currentShape = null;
		}
		
		private function onShowGalleryEvent(event:ImageShapeEvent):void
		{
			showGalleryWindow();
		}
		
		
		protected function onShapeSelect(event:ShapeSelectEvent):void
		{
			if( _drawMode != DrawMode.DRAW_MODE)
			{
				if( _currentShape )
				{
					_currentShape.hideTransformControls();
				}
				_currentShape = event.target as BaseShape;
				_currentShape.showTransformControls();
			}
		}
		
		/**
		 * Redraws and transforms shape
		 * if shape doesn't exists creates new one and applys all transformation data
		 * */
		public function updateShape(shapeData:ShapeDrawData):void
		{
			if(shapeData)
			{
				var shape:BaseShape = _drawArea.currentPage.getShapeByID(shapeData.shapeID);
				if(shape)
				{
					shape.shapeDrawData = shapeData;
					_drawArea.currentPage.updateElementLayout(shape as IVisualElement);
					if(shape.transforming)
					{
						shape.hideTransformControls();
					}
				}
				else
				{
					shape = ShapesFactory.createTool( shapeData.shapeType );
					if(shape)
					{
						shape.id = shapeData.shapeID;
						shape.shapeDrawData = shapeData;
						_drawArea.currentPage.addElement( shape );
					}
				}
			}
		}
		
		public function eraseShape(shapeID:String):void
		{
			_drawArea.currentPage.removeShapeByID(shapeID);
		}
	}
}