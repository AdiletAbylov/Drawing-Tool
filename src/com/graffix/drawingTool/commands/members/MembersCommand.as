package com.graffix.drawingTool.commands.members
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.graffix.drawingTool.business.delegates.MembersDelegate;
	import com.graffix.drawingTool.events.members.ChangeStatusEvent;
	import com.graffix.drawingTool.events.members.MembersListEvent;
	import com.graffix.drawingTool.model.ModelLocator;
	
	public class MembersCommand implements ICommand
	{
		public function MembersCommand()
		{
		}
		
		public function execute(event:CairngormEvent):void
		{
			var membersDelegate:MembersDelegate = new MembersDelegate();
			var name:String = "_DEFAULT_";
			var prefix:String = "FuncitonPeopleList." + name + ".";
			switch(event.type)
			{
				case MembersListEvent.GONNECT_MEMBERS_LIST:
					membersDelegate.connect(prefix);
					membersDelegate.setUsername(ModelLocator.getInstance().user.username, prefix);
					break;
				
				case MembersListEvent.MEMBERS_LIST_SYNC:
					ModelLocator.getInstance().membersList = membersDelegate.getMembersList();
					//ModelLocator.getInstance().membersList.sort();
					break;
				
				case ChangeStatusEvent.CHANGE_STATUS:
					membersDelegate.setStatus( (event as ChangeStatusEvent).status, prefix );
					break;
			}
		}
	}
}