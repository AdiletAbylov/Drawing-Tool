package com.graffix.drawingTool.view.drawing.shapes.selection
{
	import com.graffix.drawingTool.view.drawing.shapes.IPropertyChangable;

	public interface ISelectable extends IPropertyChangable
	{
		function showTransformControls():void;
		function hideTransformControls():void;
		function get transforming():Boolean;		
	}
}