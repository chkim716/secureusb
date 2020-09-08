//------------------------------------------------------------------------------
//
//   Copyright 2011 
//   Saferzone All rights reserved. 
//
//------------------------------------------------------------------------------

package com.saferzone.defcon4.susbma.usbmanage.controller
{
	import com.saferzone.defcon4.susbma.usbmanage.consts.LocalConst;
	import com.saferzone.defcon4.susbma.usbmanage.model.SusbmaUsbManageRemoteProxy;
	import com.saferzone.defcon4.services.vo.SusbUsbMasterVO;
	
	import mx.collections.IList;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class SusbmaUsbManageDeleteCommand extends SimpleCommand
	{
		
		//------------------------------------------------------------------------------
		//
		// Methods 
		//
		//------------------------------------------------------------------------------
		
		//--------------------------------------
		// Overriden Methods 
		//--------------------------------------
		
		override public function execute(notification:INotification):void
		{
			var proxy:SusbmaUsbManageRemoteProxy = facade.retrieveProxy(SusbmaUsbManageRemoteProxy.NAME) as SusbmaUsbManageRemoteProxy;
			switch(notification.getName())
			{
				case LocalConst.SUSBMA_USBMANAGE_USB_DELETE:
					proxy.deleteSusbmaMaster(notification.getBody() as IList);
					break;
				
				case LocalConst.D4LC_CMD_USB_RETURN:
					proxy.returnSusbmaMaster(notification.getBody() as SusbUsbMasterVO);
					break;
				
				default:
					break;
			}
		}
	}
}
