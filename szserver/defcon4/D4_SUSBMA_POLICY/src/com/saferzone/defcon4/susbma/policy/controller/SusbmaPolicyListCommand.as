//------------------------------------------------------------------------------
//
//   Copyright 2011 
//   Saferzone All rights reserved. 
//
//------------------------------------------------------------------------------

package com.saferzone.defcon4.susbma.policy.controller
{
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	import com.saferzone.defcon4.services.vo.SusbmaPolicyMasterVO;
	import com.saferzone.defcon4.susbma.policy.consts.LocalConst;
	import com.saferzone.defcon4.susbma.policy.model.SusbmaPolicyRemoteProxy;
	
	public class SusbmaPolicyListCommand extends SimpleCommand
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
				case LocalConst.SUSBMA_POLIICY_CLASS_LIST:
				{
					proxy.selectSusbmaPolicyClassList(notification.getBody() as int);
					break;
				}
				
				case LocalConst.SUSBMA_POLIICY_DEPT_LIST:
				{
					proxy.selectSusbmaPolicyDeptList(notification.getBody() as int);
					break;
				}
				
				case LocalConst.SUSBMA_POLIICY_POLICY_GROUP_LIST:
				{
					proxy.selectSusbmaPolicyGroupList(notification.getBody() as int);
					break;
				}
				
				case LocalConst.SUSBMA_POLIICY_POLICY_GROUP_RAW_LIST:
				{
					proxy.selectSusbmaPolicyGrpRaw(notification.getBody() as SusbmaPolicyMasterVO);
					break;
				}
				
				case LocalConst.SUSBMA_POLIICY_RAW_LIST:
				{
					proxy.selectSusbmaPolicyRaw(notification.getBody() as int);
					break;
				}
					
				case LocalConst.SUSBMA_COMMON_POLICY_LOAD:
				{
					proxy.selectSusbmaCommonPolicy();
					break;
				}
					
				case LocalConst.D4LC_CMD_POPUP_LIST_LOAD:
				{
					proxy.selectPopupList();
					break;
				}
					
				case LocalConst.D4LC_CMD_SECURE_ADMIN_INFO_LOAD:
				{
					proxy.selectSecureAdminInfo();
					break;
				}
					
				case LocalConst.D4LC_CMD_GROUPTYPE_SELECT:
				{
					proxy.selectGroupType();
					break;
				}
				
				default:
					break;
			}
		}
	}
}

