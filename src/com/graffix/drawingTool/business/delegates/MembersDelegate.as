package com.graffix.drawingTool.business.delegates
{
	import com.graffix.drawingTool.business.services.NetConnectionService;
	
	import flash.net.SharedObject;
	
	import mx.collections.ArrayCollection;

	public class MembersDelegate
	{
		public function MembersDelegate()
		{
		}
		
		public function getMembersList():ArrayCollection
		{
			var list:ArrayCollection = new ArrayCollection();
			
			return list; 
		}
		
		public function connect():void
		{
			var membersSO:SharedObject = NetConnectionService.instance.membersSO;
		}
		
	}
}