package org.flexlayouts.containers {
	import flash.events.MouseEvent;
	
	import spark.components.Button;
	import spark.components.SkinnableContainer;

	[SkinState("opened")]
	public class Drawer extends SkinnableContainer {
		[SkinPart(required="false")]
		public var openButton:Button;

		private var _opened:Boolean = false;

		public function get opened():Boolean {
			return _opened;
		}

		public function set opened(value:Boolean):void {
			if (_opened != value) {
				_opened = value;
				invalidateSkinState();
			}
		}

		private function openHandler(e:MouseEvent):void {
			opened = !opened;
		}

		override protected function partAdded(partName:String, instance:Object):void {
			super.partAdded(partName, instance);
			if (instance == openButton) {
				openButton.addEventListener(MouseEvent.CLICK, openHandler);
			}
		}

		override protected function partRemoved(partName:String, instance:Object):void {
			super.partRemoved(partName, instance);
			if (instance == openButton) {
				openButton.removeEventListener(MouseEvent.CLICK, openHandler);
			}
		}

		override protected function getCurrentSkinState():String {
			var st:String = 'opened';
			switch(_openButtonPosition)
			{
				case "top":
					return (opened ? 'opened' : super.getCurrentSkinState());
					break;
				
				case 'bottom':
					return (opened ? 'openedBottom' : "normalBottom");
					break;
				
				case "left":
					return (opened ? 'openedLeft' : "normalLeft");
					break;
				
				case "right":
					return (opened ? 'openedRight' : "normalRight");
					break;
			}
			return (opened ? 'opened' : super.getCurrentSkinState());
		}
	
		
		private var _openButtonPosition:String = "top";

		public function get openButtonPosition():String
		{
			return _openButtonPosition;
		}

		public function set openButtonPosition(value:String):void
		{
			_openButtonPosition = value;
		}
		
	}
}