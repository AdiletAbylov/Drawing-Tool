package com.graffix.drawingTool.view.drawing.shapes
{
	public interface ISelectable extends IPropertyChangable
	{
		function showTransformControls():void;
		function hideTransformControls():void;
		function get transforming():Boolean;		
	}
}