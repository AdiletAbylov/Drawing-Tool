package org.graffix.drawr.shapes.selection
{
	import org.graffix.drawr.shapes.IPropertyChangable;

	public interface ISelectable extends IPropertyChangable
	{
		function showTransformControls():void;
		function hideTransformControls():void;
		function get transforming():Boolean;		
	}
}