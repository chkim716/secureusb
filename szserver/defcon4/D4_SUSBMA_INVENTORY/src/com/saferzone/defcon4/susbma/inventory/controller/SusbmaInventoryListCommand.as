package com.saferzone.defcon4.susbma.inventory.controller
{
	import com.saferzone.defcon4.services.vo.SusbmaInventoryStatusVO;
	import com.saferzone.defcon4.services.vo.SusbmaInventoryHistoryVO;
	import com.saferzone.defcon4.susbma.inventory.consts.LocalConst;
	import com.saferzone.defcon4.susbma.inventory.model.SusbmaInventoryRemoteProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class SusbmaInventoryListCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			var proxy:SusbmaInventoryRemoteProxy = facade.retrieveProxy(SusbmaInventoryRemoteProxy.NAME) as SusbmaInventoryRemoteProxy;
			
			switch(notification.getName()) 
			{
				case LocalConst.USB_INVENTORY_STATUS_LIST :				//재고 리스트
				{
					proxy.selectUsbInventoryStatusList(notification.getBody() as SusbmaInventoryStatusVO);
					break;
				}
				
				case LocalConst.USB_INVENTORY_HISTORY_LIST :			//이력 리스트
				{
					proxy.selectUsbInventoryHistoryList(notification.getBody() as SusbmaInventoryHistoryVO);
					break;
				}
					
				default : break;
			}
		}
	}
}