package com.graffix.drawingTool.business.delegates
{
	import mx.rpc.IResponder;

	public class TestPortsDelagate
	{
		public function TestPortsDelagate(responder:IResponder)
		{
			_responder = responder;
		}
		private var _responder:IResponder;
		
		public function startTest(ports:Array, serverURL:String):void
		{
			
		}
	}
}