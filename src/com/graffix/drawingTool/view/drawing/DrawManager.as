package com.graffix.drawingTool.view.drawing
{
	import com.graffix.drawingTool.view.drawing.editors.TextEditorWindow;
	import com.graffix.drawingTool.view.drawing.events.TextEditEvent;
	import com.graffix.drawingTool.view.drawing.events.ToolSelectEvent;
	import com.graffix.drawingTool.view.drawing.tools.AbstractTool;
	import com.graffix.drawingTool.view.drawing.tools.SelectTool;
	import com.graffix.drawingTool.view.drawing.tools.TextTool;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import flashx.textLayout.conversion.ConversionType;
	import flashx.textLayout.conversion.TextConverter;
	
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	
	import spark.components.Group;
	
	public class DrawManager
	{
		public function DrawManager(drawArea:Group)
		{
			_drawArea = drawArea;
			_drawArea.addEventListener(MouseEvent.CLICK, onMouseClick );
			_drawArea.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove );
			_drawArea.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown );
			_drawArea.addEventListener( MouseEvent.MOUSE_UP, onMouseUp);
			_drawArea.addEventListener(ToolSelectEvent.TOOL_SELECT, onToolSelect);
			_drawArea.addEventListener(TextEditEvent.TEXT_EDIT, onTextEdit);
			
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
		
		public function clear():void
		{
			currentTool = null;
			selectedShape = null;
			_drawArea.removeAllElements();
		}
		
		private var _drawArea:Group;
		
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
			}
		}
		
		[Bindable]
		public var currentTool:AbstractTool;
		
		
		protected function onMouseClick(event:MouseEvent):void
		{
			if(event.target == event.currentTarget)
			{
				//
				//If there was selection
				if(selectedShape && selectedShape.transforming)
				{
					selectedShape.hideTransformControls();
				}
			}
		}
		
		
		
		protected function onMouseMove(event:MouseEvent):void
		{
			if(_operationType == SelectTool.TRANSFORM_TOOL )
			{
				//
				//do nothing
			}else 
				if(currentTool)
				{
					currentTool.setPoints( new Point(0,0), currentTool.globalToLocal( new Point(event.stageX, event.stageY )));
					currentTool.draw();
				}
		}
		
		private var _textEditorPopuped:Boolean;
		private var _startPoint:Point;
		
		private var _textEditorWindow:TextEditorWindow;
		
		protected function onMouseDown(event:MouseEvent):void
		{	
			switch(_operationType)
			{
				case SelectTool.TRANSFORM_TOOL:
					//
					//do not draw
					return;
				case TextTool.TEXT_TOOL:
					if(!_textEditorPopuped)
					{
						createTool(event.stageX, event.stageY);
						showTextEditor();
					}
					return;
				default:
					createTool(event.stageX, event.stageY);
					break;
			}
		}
		
		private function showTextEditor(text:String=null):void
		{
			if(!_textEditorWindow)
			{
				_textEditorWindow = new TextEditorWindow();
				_textEditorWindow.addEventListener(CloseEvent.CLOSE, onTextEditorClose);
				PopUpManager.addPopUp( _textEditorWindow, _drawArea );
				PopUpManager.centerPopUp(_textEditorWindow);
			}else
			{
				PopUpManager.addPopUp( _textEditorWindow, _drawArea );
			}
			
			_textEditorPopuped = true;
			if(text)
			{
				_textEditorWindow.setText(text);
			}
		}
		
		private function createTool(stageX:Number, stageY:Number):void
		{
			var tool:AbstractTool = ToolFactory.createTool( _operationType );
			_startPoint = new Point(stageX, stageY);
			_startPoint = _drawArea.globalToLocal( _startPoint );
			tool.x = _startPoint.x;
			tool.y = _startPoint.y;
			tool.startDraw();
			_drawArea.addElement( tool );
			currentTool = tool;
		}
		
		protected function onMouseUp(event:MouseEvent):void
		{
			if(currentTool && currentTool.type != TextTool.TEXT_TOOL)
			{
				currentTool.finishDraw();
				currentTool = null;
			}
		}
		
		[Bindable]
		public var selectedShape:ISelectable;
		
		protected function onToolSelect(event:ToolSelectEvent):void
		{
			if(selectedShape)
			{
				selectedShape.hideTransformControls();
			}
			
			selectedShape = event.target as AbstractTool;
			currentTool = event.target as AbstractTool;
			if( _operationType == SelectTool.TRANSFORM_TOOL && !selectedShape.transforming )
			{	
				selectedShape.showTransformControls();
			}
		}
	}
}