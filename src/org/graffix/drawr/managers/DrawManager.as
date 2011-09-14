package org.graffix.drawr.managers
{
	import com.roguedevelopment.objecthandles.Flex4ChildManager;
	import com.roguedevelopment.objecthandles.Flex4HandleFactory;
	import com.roguedevelopment.objecthandles.ObjectHandles;
	import com.roguedevelopment.objecthandles.SelectionEvent;
	import com.roguedevelopment.objecthandles.VisualElementHandle;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.core.IVisualElement;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	
	import org.graffix.drawr.events.DrawAreaEvent;
	import org.graffix.drawr.events.ImageShapeEvent;
	import org.graffix.drawr.shapes.BaseShape;
	import org.graffix.drawr.shapes.complex.EraserShape;
	import org.graffix.drawr.shapes.complex.ImageShape;
	import org.graffix.drawr.shapes.complex.SymbolShape;
	import org.graffix.drawr.shapes.factory.ShapesFactory;
	import org.graffix.drawr.shapes.selection.SelectTool;
	import org.graffix.drawr.view.area.DrawArea;
	import org.graffix.drawr.view.area.Page;
	import org.graffix.drawr.view.editors.ImagesGallery;
	import org.graffix.drawr.vo.ShapeDrawData;
	
	public class DrawManager extends EventDispatcher
	{
		public function DrawManager(drawArea:DrawArea)
		{
			_drawArea = drawArea;
			_drawArea.addEventListener(MouseEvent.CLICK, onMouseClick );
			_drawArea.addEventListener(DrawAreaEvent.MOVE, onMouseMove );
			_drawArea.addEventListener(DrawAreaEvent.DOWN, onMouseDown );
			_drawArea.addEventListener( DrawAreaEvent.UP, onMouseUp);
			_drawArea.addEventListener( MouseEvent.ROLL_OUT, onMouseOut);
			_drawArea.addEventListener(ImageShapeEvent.SHOW_GALLERY, onShowGalleryEvent);
			//
			// transforming mode is default 
			_selectedTool = SelectTool.TRANSFORM_TOOL;
			drawMode = DrawMode.TRANSFROM_MODE;
			_objectHandles = new ObjectHandles( _drawArea, null, new Flex4HandleFactory(), new Flex4ChildManager());
			_objectHandles.selectionManager.addEventListener(SelectionEvent.ADDED_TO_SELECTION, onShapeSelect);
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
				if(_drawMode == DrawMode.DRAW_MODE)
				{
					_objectHandles.selectionManager.clearSelection();
				}
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
		
		private var _objectHandles:ObjectHandles;
		private function endDraw():void
		{
			if(!_currentShape)
			{
				return;
			}
			switch(_drawMode)
			{
				case DrawMode.DRAW_MODE:
					if( _currentShape.type != ImageShape.IMAGE_SHAPE)
					{
						if(_currentShape.type == SymbolShape.SYMBOL_SHAPE)
						{
							(_currentShape as SymbolShape).symbol = _toolData as String;
						}
						
						_objectHandles.registerComponent(_currentShape.shapeDrawData, _currentShape);
						_currentShape.finishDraw();
						_objectHandles.selectionManager.setSelected(_currentShape.shapeDrawData);
						drawMode = DrawMode.TRANSFROM_MODE;
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
		
		
		
		protected function onMouseClick(event:MouseEvent):void
		{
			if(drawMode == DrawMode.TRANSFROM_MODE)
			{
				if(event.target is BaseShape) return;
				if(event.target is VisualElementHandle) return;
				_objectHandles.selectionManager.clearSelection();
			}
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
		
		
		protected function onShapeSelect(event:SelectionEvent):void
		{
			if( _drawMode == DrawMode.TRANSFROM_MODE)
			{
				var shapeData:ShapeDrawData = event.targets[0] as ShapeDrawData;
				_currentShape = _drawArea.currentPage.getShapeByID(shapeData.shapeID);
			}
			
		}
		
		/**
		 * Redraws and transforms shape
		 * if shape doesn't exists creates new one and applys all transformation data
		 * */
		public function updateShapeOnPage(shapeData:ShapeDrawData):void
		{
			if(shapeData)
			{
				var page:Page = _drawArea.getPageByUID(shapeData.pageUID);
				if(page)	
				{
					var shape:BaseShape = page.getShapeByID(shapeData.shapeID);
					if(shape)
					{
						shape.shapeDrawData = shapeData;
						page.updateElementLayout(shape as IVisualElement);
					}
					else
					{
						shape = ShapesFactory.createTool( shapeData.type );
						if(shape)
						{
							shape.id = shapeData.shapeID;
							shape.shapeDrawData = shapeData;
							page.addElement( shape );
						}
					}
				}
			}
		}
		
		public function eraseShape(shapeID:String):void
		{
			_objectHandles.selectionManager.clearSelection();
			var shape:BaseShape = _drawArea.currentPage.getShapeByID(shapeID);
			if(shape)
			{
				_objectHandles.unregisterComponent(shape);
			}
			_drawArea.currentPage.removeShapeByID(shapeID);
		}
	}
}