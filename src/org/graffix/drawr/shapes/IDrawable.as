package org.graffix.drawr.shapes
{
	import flash.geom.Point;
	
	import mx.core.IVisualElement;

	public interface IDrawable extends IVisualElement
	{
		function setPoints(startPoint:Point, endPoint:Point):void;
		function draw():void;
		function clear():void;
		function startDraw():void;
		function finishDraw():void;
		function destroy():void;
	}
}