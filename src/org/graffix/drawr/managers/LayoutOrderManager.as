package org.graffix.drawr.managers
{
	import org.graffix.drawr.shapes.BaseShape;
	
	import mx.core.IVisualElement;
	import mx.core.IVisualElementContainer;

	public class LayoutOrderManager
	{
		public function LayoutOrderManager(viewHost:IVisualElementContainer)
		{
			_viewHost = viewHost;
		}
		
		private var _viewHost:IVisualElementContainer;
		
		public function updateZIndexes():void
		{
			var length:int = _viewHost.numElements;
			var element:IVisualElement;
			for(var i:int = 0; i < length; ++i)
			{
				element = _viewHost.getElementAt(i);
				if(element is BaseShape)
				{
					(element as BaseShape).zIndex = _viewHost.getElementIndex(element);
				}
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
			(element as BaseShape).zIndex = shapeIndex;
		}
	}
}