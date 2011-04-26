package com.graffix.drawingTool.model
{
	public class ModelLocator
	{
		
		private static var __instance:ModelLocator = null;
		
		public static function getInstance():ModelLocator
		{
			if (__instance == null)
			{
				__instance = new ModelLocator();
			}
			return __instance;
		}
		
		public function ModelLocator()
		{
			if (__instance)
			{
				throw new Error("Only one instance of model should be instantiated!");
			}
		}
	}
}