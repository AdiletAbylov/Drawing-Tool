package com.graffix.drawingTool.business.delegates
{
	import com.graffix.drawingTool.business.services.NetConnectionService;
	
	import flash.net.NetConnection;
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
			var membersSO:SharedObject = NetConnectionService.instance.getMembersSO();
			return list; 
		}
		
		public function connect(prefix:String):void
		{
			var membersSO:SharedObject = NetConnectionService.instance.getMembersSO(prefix);
			var nc:NetConnection = NetConnectionService.instance.netConnection;
			nc.call(prefix+"connect", null);
		}
		
		public function setStatus(status:String, prefix:String):void
		{
			var nc:NetConnection = NetConnectionService.instance.netConnection;
			nc.call(prefix+"setStatus", null, status);
		}
		
		public function setUsername(username:String, prefix:String):void
		{
			var nc:NetConnection = NetConnectionService.instance.netConnection;
			nc.call(prefix+"changeName", null, username);
		}
	}
}