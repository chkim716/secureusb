package com.saferzone.defcon4.susbma.policycommon.controller
{
	import com.saferzone.defcon4.susbma.policycommon.consts.LocalConst;
	import com.saferzone.defcon4.susbma.policycommon.model.SusbmaPolicyCommonRemoteProxy;
	import com.saferzone.defcon4.susbma.policycommon.vo.SusbmaPolicyCommonMasterVO;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class SusbmaPolicyCommonCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			var proxy:SusbmaPolicyCommonRemoteProxy = facade.retrieveProxy(SusbmaPolicyCommonRemoteProxy.NAME) as SusbmaPolicyCommonRemoteProxy;
			
			switch(notification.getName())
			{
				case LocalConst.SUSBMA_COMMON_POLICY_LOAD:
				{
					proxy.selectSusbmaPolicyCommon();
					break;
				}
					
				case LocalConst.SUSBMA_COMMON_POLICY_SAVE:
				{
					proxy.updateSusbmaPolicyCommon(notification.getBody() as Object);
					break;
				}
					
				default:
					break;
			}
		}
	}
}