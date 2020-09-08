//------------------------------------------------------------------------------
//
//   Copyright 2011 
//   Saferzone All rights reserved. 
//
//------------------------------------------------------------------------------

package com.saferzone.defcon4.susbma.policy.controller
{
	import com.saferzone.defcon4.susbma.policy.consts.LocalConst;
	import com.saferzone.defcon4.susbma.policy.model.SusbmaPolicyRemoteProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import com.saferzone.defcon4.services.vo.SusbmaPolicyRawVO;
	
	public class SusbmaPolicyDeleteCommand extends SimpleCommand
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
			var proxy:SusbmaPolicyRemoteProxy = facade.retrieveProxy(SusbmaPolicyRemoteProxy.NAME) as SusbmaPolicyRemoteProxy;
			switch(notification.getName())
			{
				case LocalConst.SUSBMA_POLIICY_DEPT_DELETE:
				{
					proxy.deleteSusbmaPolicyOrg(notification.getBody() as int);
					break;
				}
				
				case LocalConst.SUSBMA_POLIICY_POLICY_GROUP_DELETE:
				{
					proxy.deleteSusbmaPolicyGrp(notification.getBody() as int);
					break;
				}
				
				case LocalConst.SUSBMA_POLIICY_POLICY_USB_DELETE:
				{
					proxy.deleteSusbmaPolicyGrpUsb(notification.getBody() as String);
					break;
				}
				
				case LocalConst.SUSBMA_POLIICY_RAW_DELETE:
				{
					proxy.deleteSusbmaPolicyRaw(notification.getBody() as SusbmaPolicyRawVO);
					break;
				}
				
				default:
					break;
			}
		}
	}
}
