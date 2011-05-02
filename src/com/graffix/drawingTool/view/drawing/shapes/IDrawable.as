package com.graffix.drawingTool.view.drawing.shapes
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
	}
}