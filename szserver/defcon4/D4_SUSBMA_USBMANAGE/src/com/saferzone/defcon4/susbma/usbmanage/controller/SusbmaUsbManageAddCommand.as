//------------------------------------------------------------------------------
//
//   Copyright 2011 
//   Saferzone All rights reserved. 
//
//------------------------------------------------------------------------------

package com.saferzone.defcon4.susbma.usbmanage.controller
{
	import com.saferzone.defcon4.services.vo.AgntmaEmergencyKeyLogVO;
	import com.saferzone.defcon4.services.vo.SusbUsbMasterVO;
	import com.saferzone.defcon4.susbma.usbmanage.consts.LocalConst;
	import com.saferzone.defcon4.susbma.usbmanage.model.SusbmaUsbManageRemoteProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class SusbmaUsbManageAddCommand extends SimpleCommand
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
				case LocalConst.SUSBMA_USBMANAGE_USB_ADD:
					proxy.insertUsubmaMaster(notification.getBody() as SusbUsbMasterVO);
					break;
				
				case LocalConst.D4LC_CMD_MAKE_EMERGENCY_KEY:
					proxy.makeEmergencyKey(notification.getBody() as AgntmaEmergencyKeyLogVO);
					break;
				
				case LocalConst.SUSBMA_USBMANAGE_MASS_REGISTER:
					proxy.usbMassRegister(notification.getBody() as String);
					break;
				
				default:
					break;
			}
		}
	}
}
