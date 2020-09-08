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
	
	import com.saferzone.defcon4.services.vo.SusbmaPolicyGroupUsbVO;
	import com.saferzone.defcon4.services.vo.SusbmaClassVO;
	import com.saferzone.defcon4.services.vo.SusbmaPolicyMasterVO;
	import com.saferzone.defcon4.services.vo.SusbmaCommonPolicyMasterVO;
	import com.saferzone.defcon4.services.vo.SusbmaPolicyRawVO;
	import com.saferzone.defcon4.susbma.policy.consts.LocalConst;
	import com.saferzone.defcon4.susbma.policy.model.SusbmaPolicyRemoteProxy;
	
	public class SusbmaPolicyModifyCommand extends SimpleCommand
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
				case LocalConst.SUSBMA_POLIICY_CLASS_MODIFY:
				{
					proxy.updateSusbmaPolicyClass(notification.getBody() as SusbmaClassVO);
					break;
				}
				
				case LocalConst.SUSBMA_POLIICY_CLASSCHECK_MODIFY:
				{
					proxy.updateSusbmaPolicyClass(notification.getBody() as SusbmaClassVO);
					break;
				}
				
				case LocalConst.SUSBMA_POLIICY_DEPT_MODIFY:
				{
					proxy.updateSusbmaPolicyOrg(notification.getBody() as SusbmaPolicyMasterVO);
					break;
				}
				
				case LocalConst.SUSBMA_POLIICY_POLICY_GROUP_MODIFY:
				{
					proxy.updateSusbmaPolicyGrp(notification.getBody() as SusbmaPolicyMasterVO);
					break;
				}
				
				case LocalConst.SUSBMA_POLIICY_RAW_MODIFY:
				{
					proxy.updateSusbmaPolicyRaw(notification.getBody() as SusbmaPolicyRawVO);
					break;
				}
					
				case LocalConst.SUSBMA_POLIICY_POLICY_USB_MODIFY:
				{
					proxy.updateSusbmaPolicyGrpUsb(notification.getBody() as SusbmaPolicyGroupUsbVO);
					break;
				}
					
				case LocalConst.SUSBMA_COMMON_POLICY_SAVE:
				{
					proxy.updateSusbmaCommonPolicy(notification.getBody() as SusbmaCommonPolicyMasterVO);
					break;
				}
				
				case LocalConst.D4LC_CMD_PASSWORD_INITIALIZE:
				{
					proxy.updateSusbmaInitPassword(notification.getBody() as String);
					break;
				}
					
				case LocalConst.D4LC_CMD_POPUP_LIST_SAVE:
				{
					proxy.updatePopupList(notification.getBody() as Object);
					break;
				}
					
				case LocalConst.D4LC_CMD_SECURE_ADMIN_INFO_SAVE:
				{
					proxy.updateSecureAdminInfo(notification.getBody() as SusbmaCommonPolicyMasterVO);
					break;
				}
					
				default:
					break;
			}
		}
	}
}
