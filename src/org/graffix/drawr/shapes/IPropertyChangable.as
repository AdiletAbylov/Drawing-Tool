package org.graffix.drawr.shapes
{
	public interface IPropertyChangable
	{
		function get lineSize():int;
		function get lineColor():uint;
		function get fillColor():uint;
		function get hasFill():Boolean;
		function setProperty(name:String, value:Object):void; 
		function get type():int;
	}
}