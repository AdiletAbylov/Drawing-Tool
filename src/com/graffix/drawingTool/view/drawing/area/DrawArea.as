package com.graffix.drawingTool.view.drawing.area
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.containers.ViewStack;
	import mx.core.IVisualElement;
	import mx.core.UIComponent;
	import mx.events.IndexChangedEvent;
	
	import spark.components.Group;
	
	public class DrawArea extends UIComponent
	{
		public function DrawArea()
		{
			super();
			_pages = new ArrayCollection();
		}
		
		
		private const CELL_WIDTH:Number = 25;
		private const CELL_HEIGHT:Number = 25;
		
		private var _drawGrid:Boolean;
		private var _drawGridChanged:Boolean;
		
		private var _currentPage:Page;
		
		[Bindable (event="currentPageChange")]
		public function get currentPage():Page
		{
			return _currentPage;
		}
		
		public function set currentPage(value:Page):void
		{
			_currentPage = value;
		}
		
		
		public function set drawGrid(value:Boolean):void
		{
			_drawGrid = value;
			_drawGridChanged = true;
			invalidateDisplayList();
		}
		
		override protected function createChildren():void
		{
			_viewStack = new ViewStack();
			_viewStack.addEventListener(IndexChangedEvent.CHANGE, onViewStackChange );
			addChild( _viewStack);
			//
			//create first page
			addPage();
		}
		
		
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			if(_drawGridChanged)
			{
				if(_drawGrid)
				{
					drawingGrid();
				}else
				{
					graphics.clear();
				}
				_drawGridChanged = false;
			}
			_viewStack.width = width;
			_viewStack.height = height;
			
		}
		
		private function drawingGrid():void
		{
			graphics.clear();
			
			graphics.lineStyle(1, 0x000000, 0.1);
			var position:int = 0;
			for(position = CELL_WIDTH; position <= this.width; position += CELL_WIDTH )
			{
				this.graphics.moveTo(position, 0);
				this.graphics.lineTo(position, this.height);
			}
			
			for(position = CELL_HEIGHT; position <= this.height; position += CELL_HEIGHT )
			{
				this.graphics.moveTo(0, position);
				this.graphics.lineTo(this.width, position);
			}
		}
		
		
		//
		//-------- PAGES
		//
		private var _viewStack:ViewStack;
		private function onViewStackChange(event:IndexChangedEvent):void
		{
			_currentPage = _viewStack.selectedChild as Page;
		}
		
		private function createPage():Page
		{
			var page:Page = new Page();
			page.percentWidth = 100;
			page.percentHeight = 100;
			page.label = "Page " + (_pages.length + 1);
			return page;
		}
		
		public function addChildToCurrentPage(child:IVisualElement):void
		{
			if(_currentPage)
			{
				_currentPage.addElement(child);
			}
		}
		
		public function removeChildFromCurrentPage(child:IVisualElement):void
		{
			if(_currentPage)
			{
				_currentPage.removeElement(child);
			}
		}
		
		public function addPage():Page
		{
			var page:Page = createPage();
			_viewStack.addChild(page);
			_pages.addItem( page );
			
			dispatchEvent(new Event("pagesChangeEvent"));
			selectPage( _viewStack.length - 1);
			return page;
		}
		
		public function selectPage(index:int):void
		{
			_viewStack.selectedIndex = index;
			_currentPage = _viewStack.selectedChild as Page;
			dispatchEvent(new Event("currentPageChange"));
		}
		
		public function removeCurrentPage():void
		{
			if(_viewStack.length > 1)
			{
				var currentIndex:int = _viewStack.selectedIndex;
				_currentPage.destroy();
				_pages.removeItemAt( currentIndex );
				_viewStack.removeChild(_currentPage);
				dispatchEvent(new Event("pagesChangeEvent"));
				selectPage( _viewStack.length - 1);
			}
		}
		
		private var _pages:ArrayCollection;
		[Bindable(event='pagesChangeEvent')]
		public function get pages():ArrayCollection
		{
			return _pages;
		}
	}
}