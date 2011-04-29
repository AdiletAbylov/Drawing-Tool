package com.graffix.drawingTool.view.drawing
{
	import com.graffix.drawingTool.view.drawing.area.DrawArea;
	import com.graffix.drawingTool.view.drawing.editors.ImagesGallery;
	import com.graffix.drawingTool.view.drawing.editors.TextEditorWindow;
	import com.graffix.drawingTool.view.drawing.events.DrawAreaEvent;
	import com.graffix.drawingTool.view.drawing.events.ImageToolEvent;
	import com.graffix.drawingTool.view.drawing.events.TextEditEvent;
	import com.graffix.drawingTool.view.drawing.events.ToolSelectEvent;
	import com.graffix.drawingTool.view.drawing.tools.BaseTool;
	import com.graffix.drawingTool.view.drawing.tools.ImageTool;
	import com.graffix.drawingTool.view.drawing.tools.SelectTool;
	import com.graffix.drawingTool.view.drawing.tools.TextTool;
	
	import flash.geom.Point;
	
	import flashx.textLayout.conversion.ConversionType;
	import flashx.textLayout.conversion.TextConverter;
	
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	
	public class DrawManager
	{
		public function DrawManager(drawArea:DrawArea)
		{
			_drawArea = drawArea;
			_drawArea.addEventListener(DrawAreaEvent.CLICK, onMouseClick );
			_drawArea.addEventListener(DrawAreaEvent.MOVE, onMouseMove );
			_drawArea.addEventListener(DrawAreaEvent.DOWN, onMouseDown );
			_drawArea.addEventListener( DrawAreaEvent.UP, onMouseUp);
			_drawArea.addEventListener(ToolSelectEvent.TOOL_SELECT, onToolSelect);
			_drawArea.addEventListener(TextEditEvent.TEXT_EDIT, onTextEdit);
			_drawArea.addEventListener(ImageToolEvent.SHOW_GALLERY, onShowGallery);
		}
		
		//
		// --------------- CATCH TOOLS EVENTS-----------------
		//
		protected function onMouseDown(event:DrawAreaEvent):void
		{	
			switch(_operationType)
			{
				case SelectTool.TRANSFORM_TOOL:
					//
					//do nothing
					return;
				case TextTool.TEXT_TOOL:
					if(!_textEditorPopuped)
					{
						createTool(event.mouseEvent.stageX, event.mouseEvent.stageY);
						showTextEditor();
					}
					return;
					
				case ImageTool.IMAGE_TOOL:
					if(!_galleryWindowPopuped)
					{
						createTool(event.mouseEvent.stageX, event.mouseEvent.stageY);
						showGalleryWindow();
					}
					return;
					
				default:
					createTool(event.mouseEvent.stageX, event.mouseEvent.stageY);
					break;
			}
		}
		
		protected function onMouseClick(event:DrawAreaEvent):void
		{
			if(!event.hasShapeUnderClick)
			{
				if(selectedShape && selectedShape.transforming)
				{
					selectedShape.hideTransformControls();
				}
			}
		}
		
		protected function onMouseMove(event:DrawAreaEvent):void
		{
			if(_operationType == SelectTool.TRANSFORM_TOOL )
			{
				//
				//do nothing
			}else 
				if(currentTool)
				{
					currentTool.setPoints( new Point(0,0), currentTool.globalToLocal( new Point(event.mouseEvent.stageX, event.mouseEvent.stageY )));
				}
		}
		
		protected function onMouseUp(event:DrawAreaEvent):void
		{
			if(currentTool && currentTool.type != TextTool.TEXT_TOOL && currentTool.type != ImageTool.IMAGE_TOOL)
			{
				currentTool.finishDraw();
				currentTool = null;
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
			}else
			{
				_galleryWindow = new ImagesGallery();
				_galleryWindow.addEventListener(CloseEvent.CLOSE, onGalleryWindowClose);
				_galleryWindow.addEventListener(ImageToolEvent.INSERT_IMAGE, onInsertImage);
				PopUpManager.addPopUp( _galleryWindow, _drawArea );
				PopUpManager.centerPopUp( _galleryWindow);
			}
			_galleryWindowPopuped = true;
		}
		
		private function onInsertImage(event:ImageToolEvent):void
		{
			(currentTool as ImageTool).insertImage( event.image, event.width, event.height );
		}
		
		private function onGalleryWindowClose(event:CloseEvent):void
		{
			_galleryWindowPopuped = false;
			currentTool.finishDraw();
			currentTool = null;
		}
		
		private function onShowGallery(event:ImageToolEvent):void
		{
			showGalleryWindow();
		}
		
		//
		// -------------- TEXT EDITOR WINDOW -------------------
		//
		
		private var _textEditorPopuped:Boolean;
		
		private var _textEditorWindow:TextEditorWindow;
		
		private function showTextEditor(text:String=null):void
		{
			if(_textEditorWindow)
			{	
				PopUpManager.addPopUp( _textEditorWindow, _drawArea );
			}else
			{
				_textEditorWindow = new TextEditorWindow();
				_textEditorWindow.addEventListener(CloseEvent.CLOSE, onTextEditorClose);
				PopUpManager.addPopUp( _textEditorWindow, _drawArea );
				PopUpManager.centerPopUp(_textEditorWindow);
			}
			
			_textEditorPopuped = true;
			if(text)
			{
				_textEditorWindow.setText(text);
			}
		}
		
		private function onTextEdit(event:TextEditEvent):void
		{
			if( _operationType == SelectTool.TRANSFORM_TOOL)
			{
				if(_textEditorPopuped)
				{
					_textEditorWindow.setText(event.text);
				}else
				{
					showTextEditor(event.text);
				}
			}
		}
		
		private function onTextEditorClose(event:CloseEvent):void
		{
			var ss:String = TextConverter.export(_textEditorWindow.richTextEditor.textFlow, TextConverter.TEXT_LAYOUT_FORMAT, ConversionType.STRING_TYPE).toString();
			(currentTool as TextTool).setText(ss);
			_textEditorPopuped = false;
			_textEditorWindow.richTextEditor.textFlow = null;
			currentTool.finishDraw();
		}
		
		//
		// ---------------------------------------------------
		//
		private var _drawArea:DrawArea;
		
		private var _operationType:int = SelectTool.TRANSFORM_TOOL;
		public function get operationType():int
		{
			return _operationType;
		}
		
		public function set operationType(value:int):void
		{
			_operationType = value;
			if( selectedShape )
			{
				selectedShape.hideTransformControls();
				currentTool = null;
				selectedShape = null;
			}
		}
		
		[Bindable]
		public var currentTool:BaseTool;
		private var _startPoint:Point;
		private function createTool(stageX:Number, stageY:Number):void
		{
			var tool:BaseTool = ToolFactory.createTool( _operationType );
			_startPoint = new Point(stageX, stageY);
			_startPoint = _drawArea.globalToLocal( _startPoint );
			tool.x = _startPoint.x;
			tool.y = _startPoint.y;
			tool.startDraw();
			_drawArea.addChildToCurrentPage( tool );
			currentTool = tool;
		}
		
		[Bindable]
		public var selectedShape:ISelectable;
		protected function onToolSelect(event:ToolSelectEvent):void
		{
			if(selectedShape)
			{
				selectedShape.hideTransformControls();
			}
			
			selectedShape = event.target as BaseTool;
			currentTool = event.target as BaseTool;
			if( _operationType == SelectTool.TRANSFORM_TOOL && !selectedShape.transforming )
			{	
				selectedShape.showTransformControls();
			}
		}
		
	}
}