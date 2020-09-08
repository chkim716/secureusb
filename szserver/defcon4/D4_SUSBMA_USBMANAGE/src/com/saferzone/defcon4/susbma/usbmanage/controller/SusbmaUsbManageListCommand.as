//------------------------------------------------------------------------------
//
//   Copyright 2011 
//   Saferzone All rights reserved. 
//
//------------------------------------------------------------------------------

package com.saferzone.defcon4.susbma.usbmanage.controller
{
	import com.saferzone.defcon4.services.vo.SearchSusbMasterVO;
	import com.saferzone.defcon4.susbma.usbmanage.consts.LocalConst;
	import com.saferzone.defcon4.susbma.usbmanage.model.SusbmaUsbManageRemoteProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class SusbmaUsbManageListCommand extends SimpleCommand
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
				case LocalConst.SUSBMA_USBMANAGE_USB_LIST:
				{
					proxy.selectSusbMasterList(notification.getBody() as SearchSusbMasterVO);
					break;
				}
				
				case LocalConst.SUSBMA_USBMANAGE_CHANGE_LIST:
				{
					proxy.selectSusbmaChangeList(notification.getBody() as String);
					break;
				}
				
				case LocalConst.SUSBMA_USBMANAGE_USE_LIST:
				{
					proxy.selectSusbmaUseList(notification.getBody() as String);
					break;
				}
				
				case LocalConst.SUSBMA_USBMANAGE_COMMON_LIST:
				{
					proxy.selectCommonList(notification.getBody());
					break;
				}
					
				case LocalConst.D4LC_NOTIFY_SUSBMA_GROUPTYPE_SEL:
				{
					proxy.getGroupType();
					break;
				}
					
				case LocalConst.SUSBMA_USBMANAGE_DELETE_LIST:
				{
					var sno:String = String(notification.getBody().sno);
					proxy.selectSusbmaDeleteList(sno);
					break;
				}
					
				case LocalConst.SUSBMA_USBMANAGE_STATUS_LIST:
				{
					var sno:String = String(notification.getBody().sno);
					var startDate:String = String(notification.getBody().startDate);
					var endDate:String = String(notification.getBody().endDate);
					proxy.selectSusbmaStatusList(sno, startDate, endDate);
					break;
				}
					
				case LocalConst.SUSBMA_USBMANAGE_FILE_DELETE_LIST:
				{
					var sno:String = String(notification.getBody().sno);
					var startDate:String = String(notification.getBody().startDate);
					var endDate:String = String(notification.getBody().endDate);
					proxy.selectSusbmafileDeleteList(sno, startDate, endDate);
					break;
				}
					
				case LocalConst.SUSBMA_USBMANAGE_UPDATE_LIST:
				{
					proxy.selectSusbmaUpdateList(notification.getBody() as String);
					break;
				}
					
				default:
					break;
			}
		}
	}
}

