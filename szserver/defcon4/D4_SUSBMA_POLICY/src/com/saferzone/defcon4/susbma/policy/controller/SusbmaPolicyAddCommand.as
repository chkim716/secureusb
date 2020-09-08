//------------------------------------------------------------------------------
//
//   Copyright 2011 
//   Saferzone All rights reserved. 
//
//------------------------------------------------------------------------------

package com.saferzone.defcon4.susbma.policy.controller
{
	import mx.collections.IList;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	import com.saferzone.defcon4.services.vo.SusbmaPolicyMasterVO;
	import com.saferzone.defcon4.susbma.policy.consts.LocalConst;
	import com.saferzone.defcon4.susbma.policy.model.SusbmaPolicyRemoteProxy;
	
	public class SusbmaPolicyAddCommand extends SimpleCommand
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
				case LocalConst.SUSBMA_POLIICY_DEPT_ADD:
				{
					proxy.insertSusbmaPolicyOrg(notification.getBody() as SusbmaPolicyMasterVO);
					break;
				}
				
				case LocalConst.SUSBMA_POLIICY_POLICY_GROUP_ADD:
				{
					proxy.insertSusbmaPolicyGrp(notification.getBody() as SusbmaPolicyMasterVO);
					break;
				}
				
				case LocalConst.SUSBMA_POLIICY_POLICY_USB_ADD:
				{
					proxy.insertSusbmaPolicyGrpUsb(notification.getBody() as IList);
					break;
				}
				
				case LocalConst.SUSBMA_POLIICY_RAW_ADD:
				{
					proxy.insertSusbmaPolicyRaw(notification.getBody() as int);
					break;
				}
				
				default:
					break;
			}
		}
	}
}
