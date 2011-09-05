package com.graffix.drawingTool.view.drawing.managers
{
	import com.graffix.drawingTool.view.drawing.events.pages.PageEvent;
	import com.graffix.drawingTool.view.drawing.events.pages.PageManagerEvent;
	import com.graffix.drawingTool.view.drawing.view.area.DrawArea;
	import com.graffix.drawingTool.view.drawing.view.area.Page;
	import com.graffix.drawingTool.view.drawing.vo.ShapeDrawData;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.SyncEvent;
	import flash.net.SharedObject;
	
	import mx.collections.ArrayCollection;
	import mx.messaging.channels.StreamingAMFChannel;


	public class PagesManager extends EventDispatcher
	{
		
		public function PagesManager(so:SharedObject, drawArea:DrawArea)
		{
			_so = so;
			_so.addEventListener(SyncEvent.SYNC, onSync);
			_drawArea = drawArea;
			_drawArea.addEventListener(PageEvent.PAGE_ADDED, onPageAdded);
			_drawArea.addEventListener(PageEvent.PAGE_REMOVED, onPageRemoved);
			_drawArea.addEventListener(PageEvent.PAGE_SELECTED, onPageSelect);
		}
		
		protected function onPageSelect(event:PageEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function onPageRemoved(event:PageEvent):void
		{
			savePage(event.page.pageUID, null);
		}
		
		protected function onPageAdded(event:PageEvent):void
		{
			savePage(event.page.pageUID, {type:Page.PAGE_TYPE});
		}
		
		private var _drawArea:DrawArea;
		private var _so:SharedObject;
		
		private var _firstTime:Boolean = true;
		private function onSync(event:SyncEvent):void
		{
			for (var i:int = 0; i<event.changeList.length; ++i) 
			{
				var uid:String = event.changeList[i].name;
				var dataObject:Object = _so.data[uid];
				
				if(dataObject && dataObject.type != Page.PAGE_TYPE)
				{
					//
					// do not process shapes and other data
					// only pages
					continue;
				}
				
				switch(event.changeList[i].code)
				{
					case "delete":
						removePage(uid);
						break;
					
					case "change":
						addPage(uid);
						break;
				}
			}
			
			if(_firstTime)
			{
				if(_drawArea.pagesStack.length == 0)
				{
					savePage(_drawArea.addPage().pageUID, {type:Page.PAGE_TYPE});
				}
				dispatchEvent( new PageManagerEvent(PageManagerEvent.INIT_COMPLETE));
				_firstTime = false;
			}
		}
		
		
		/**
		 * 
		 * adds page to page stack of draw area
		 * param uid String page UID
		 * */
		private function addPage(uid:String):void
		{
			if(uid)
			{
				_drawArea.addPage(uid); 
			}
			savePage(uid, {type:Page.PAGE_TYPE});
		}
		
		
		private function savePage(uid:String, typeObject:Object):void
		{
			_so.setProperty(uid, typeObject );
			_so.setDirty(uid);
		}
		
		private function removePage(uid:String):void
		{
			if(uid)
			{
				_drawArea.removePageByUID( uid );
			}
			savePage(uid, null);
		}
		
		
		private function get pagesData():Array
		{
			var pages:Array = [];
			for(var uid:String in _so.data)
			{
				if(_so.data[uid].type == Page.PAGE_TYPE)
				{
					pages[pages.length] = _so.data[uid];
				}
			}
			return pages;
		}
		
		
		
		public function getShapesByPageID(pageUID:String):Array
		{
			var shapes:Array = [];
			for(var id:String in _so.data)
			{
				if(_so.data[id].pageUID && _so.data[id].pageUID == pageUID)
				{
					shapes[shapes.length] = _so.data[id]; 
				}
			}
			return shapes;
		}
	}
}