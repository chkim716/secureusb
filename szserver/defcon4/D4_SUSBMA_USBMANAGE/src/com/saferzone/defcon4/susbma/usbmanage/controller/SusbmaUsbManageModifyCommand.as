//------------------------------------------------------------------------------
//
//   Copyright 2011 
//   Saferzone All rights reserved. 
//
//------------------------------------------------------------------------------

package com.saferzone.defcon4.susbma.usbmanage.controller
{
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	import com.saferzone.defcon4.services.vo.SusbChangeHistoryVO;
	import com.saferzone.defcon4.services.vo.SusbUsbMasterVO;
	import com.saferzone.defcon4.susbma.usbmanage.consts.LocalConst;
	import com.saferzone.defcon4.susbma.usbmanage.model.SusbmaUsbManageRemoteProxy;
	
	public class SusbmaUsbManageModifyCommand extends SimpleCommand
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
				case LocalConst.SUSBMA_USBMANAGE_USB_MODIFY:
					proxy.updateSusbMaster(notification.getBody() as SusbChangeHistoryVO);
					break;
				// 관리책임자 일괄 변경
				case LocalConst.SUSBMA_USBMANAGE_MNGEMPID_MODIFY:
					proxy.updateMngEmpId(notification.getBody() as SusbUsbMasterVO);
					break;
				default:
					break;
			}
		}
	}
}
