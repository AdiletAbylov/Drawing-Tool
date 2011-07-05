package com.graffix.drawingTool.view.drawing.managers
{
	import com.graffix.drawingTool.view.drawing.shapes.BaseShape;
	
	import mx.core.IVisualElement;
	import mx.core.IVisualElementContainer;

	public class LayoutOrderManager
	{
		public function LayoutOrderManager(viewHost:IVisualElementContainer)
		{
			_viewHost = viewHost;
		}
		
		private var _viewHost:IVisualElementContainer;
		
		public function arrangeElementsByZIndex(elements:Array):void
		{
			var length:int = elements.length;
			var element:IVisualElement;
			for(var i:int = 0; i < length; ++i)
			{
				element = elements[i];
				_viewHost.setElementIndex(element, (element as BaseShape).zIndex);
			}
		}
		
		public function changeElementZIndex(element:IVisualElement, direction:String):void
		{
			var shapeIndex:int = _viewHost.getElementIndex( element );
			
			if(direction == "up")
			{
				if( shapeIndex < _viewHost.numElements - 1)
				{
					shapeIndex++;
					_viewHost.setElementIndex(element, shapeIndex);
				}
			}else
			{
				if(shapeIndex > 1)
				{
					shapeIndex--;
					_viewHost.setElementIndex(element, shapeIndex);
				}
			}
		}
	}
}