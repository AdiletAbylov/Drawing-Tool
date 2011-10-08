package com.graffix.drawingTool.model
{
	import com.graffix.drawingTool.vo.MembersList;
	import com.graffix.drawingTool.vo.Settings;
	import com.graffix.drawingTool.vo.User;
	
	import flash.media.Video;
	
	import mx.collections.ArrayCollection;
	import mx.core.IFlexDisplayObject;

	[Bindable]
	public class ModelLocator
	{
		
		private static var __instance:ModelLocator = null;
		
		public static function getInstance():ModelLocator
		{
			if (!__instance)
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
			settings = new Settings();
			user = new User();
			membersList = new MembersList();
			membersListWithEveryOne = new MembersList();
		}
		
		public var settings:Settings;
		
		public var message:String;
		
		public var initStatus:String = "connecting";
		
		public var username:String;
		
		public var currentState:String = "InitState";
		
		public var user:User;
		
		public var membersList:MembersList;
		
		public var membersListWithEveryOne:MembersList;
		
		public var chatView:IFlexDisplayObject;
		
		public var imagesList:ArrayCollection;
		
		public var video:Video;
		
		public var isBroadcasting:Boolean;
	}
}