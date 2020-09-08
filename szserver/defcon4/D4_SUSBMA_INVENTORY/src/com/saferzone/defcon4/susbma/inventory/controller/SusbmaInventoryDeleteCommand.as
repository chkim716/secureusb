package com.saferzone.defcon4.susbma.inventory.controller
{
	import com.saferzone.defcon4.services.vo.SusbmaInventoryStatusVO;
	import com.saferzone.defcon4.susbma.inventory.consts.LocalConst;
	import com.saferzone.defcon4.susbma.inventory.model.SusbmaInventoryRemoteProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class SusbmaInventoryDeleteCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			var proxy:SusbmaInventoryRemoteProxy = facade.retrieveProxy(SusbmaInventoryRemoteProxy.NAME) as SusbmaInventoryRemoteProxy;
			
			switch(notification.getName())
			{
				case LocalConst.USB_INVENTORY_STATUS_DELETE :			//재고 삭제
				{
					proxy.deleteUsbInventoryStatus(notification.getBody() as SusbmaInventoryStatusVO);
					break;
				}
					
				default : break;
			}
		}
	}
}