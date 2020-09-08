package com.saferzone.defcon4.susbma.policycommon.model
{
	import com.saferzone.defcon4.susbma.policycommon.consts.LocalConst;
	import com.saferzone.defcon4.susbma.policycommon.remote.SusbmaPolicyCommonRemote;
	import com.saferzone.defcon4.susbma.policycommon.vo.SusbmaPolicyCommonMasterVO;
	import com.saferzone.defcon4.common.DmosFramework;
	
	import mx.collections.IList;
	import mx.controls.Alert;
	import mx.messaging.messages.RemotingMessage;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
	public class SusbmaPolicyCommonRemoteProxy extends Proxy implements IProxy, IResponder
	{
		public static const NAME:String = "SusbmaPolicyCommonRemoteProxy";
		
		public function SusbmaPolicyCommonRemoteProxy(data:Object = null)
		{
			super(NAME, data);
			service = new SusbmaPolicyCommonRemote();
		}
		
		private var service:SusbmaPolicyCommonRemote;
		
		private var notificationOnResult:String;
		
		private var notificationOnFault:String;
		
		public function selectSusbmaPolicyCommon():void
		{
			notificationOnResult = LocalConst.SUSBMA_COMMON_POLICY_LOADSUCCESS;
			notificationOnFault = LocalConst.SUSBMA_COMMON_POLICY_LOADFAIL;
			var token:AsyncToken = service.selectSusbmaPolicyCommon();
			token.addResponder(this);
		}
		
		public function updateSusbmaPolicyCommon(obj:Object):void
		{
			notificationOnResult = LocalConst.SUSBMA_COMMON_POLICY_SAVESUCCESS;
			notificationOnFault = LocalConst.SUSBMA_COMMON_POLICY_SAVEFAIL;
			var token:AsyncToken = service.updateSusbmaPolicyCommon(obj);
			token.addResponder(this);
		}

		public function result(data:Object):void
		{
			var resultEvent:ResultEvent = data as ResultEvent;
			if(resultEvent)
			{
				var message:RemotingMessage = resultEvent.token.message as RemotingMessage;
				if(message)
				{
					var operation:String = message.operation;
					sendNotification(notificationOnResult, resultEvent.result);
				}
			}
		}
		
		public function fault(info:Object):void
		{
			var faultEvent:FaultEvent = info as FaultEvent;
			if( DmosFramework.getInstance().sessionCheck(faultEvent))return;
			
			if(faultEvent)
			{
				var message:RemotingMessage = faultEvent.token.message as RemotingMessage;
				if(message)
				{
					var operation:String = message.operation;
					var rootCause:Object = faultEvent.fault.rootCause;
					var text:String = rootCause ? rootCause.message : faultEvent.message.toString();
					Alert.show(text, DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_POLICY_COMMON"));
				}
			}
		}
	}
}