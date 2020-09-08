package com.saferzone.defcon4.susbma.inventory.model
{
	import com.saferzone.defcon4.common.DmosFramework;
	import com.saferzone.defcon4.susbma.inventory.consts.LocalConst;
	import com.saferzone.defcon4.services.vo.SusbmaInventoryHistoryVO;
	import com.saferzone.defcon4.services.vo.SusbmaInventoryStatusVO;
	
	import mx.controls.Alert;
	import mx.messaging.messages.RemotingMessage;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
	/**
	 * RemoteProxy
	 * Proxy를 상속,
	 * IProxy, IResponder를 구현
	 * @author lmj
	 */	
	public class SusbmaInventoryRemoteProxy extends Proxy implements IProxy, IResponder
	{
		public static const NAME:String = "SusbmaInventoryRemoteProxy";
		
		private var remote:RemoteObject;		
		
		public function SusbmaInventoryRemoteProxy(data:Object = null)
		{
			super(NAME, data);
			remote = new RemoteObject("SusbmaInventoryRemote");
		}
		
		private var notificationOnResult:String;
		
		private var notificationOnFault:String;
		
		/**
		 * 재고 리스트
		 */		
		public function selectUsbInventoryStatusList(vo:SusbmaInventoryStatusVO):void
		{
			notificationOnResult = LocalConst.USB_INVENTORY_STATUS_LIST_RESULT;
			notificationOnFault = LocalConst.USB_INVENTORY_STATUS_LIST_FAULT;
			
			var token:AsyncToken = remote.getOperation("selectInventoryStatusList").send(vo);
			token.addResponder(this);
		}
		
		/**
		 * 재고 등록
		 */	
		public function addUsbInventoryStatus(vo:SusbmaInventoryStatusVO):void
		{
			notificationOnResult = LocalConst.USB_INVENTORY_STATUS_ADD_RESULT;
			notificationOnFault = LocalConst.USB_INVENTORY_STATUS_ADD_FAULT;
			
			var token:AsyncToken = remote.getOperation("addInventoryStatus").send(vo);
			token.addResponder(this);
		}
		
		/**
		 * 재고 수정
		 */	
		public function modifyUsbInventoryStatus(vo:SusbmaInventoryStatusVO):void
		{
			notificationOnResult = LocalConst.USB_INVENTORY_STATUS_MODIFY_RESULT;
			notificationOnFault = LocalConst.USB_INVENTORY_STATUS_MODIFY_FAULT;
			
			var token:AsyncToken = remote.getOperation("modifyInventoryStatus").send(vo);
			token.addResponder(this);
		}
		
		/**
		 * 재고 삭제
		 */	
		public function deleteUsbInventoryStatus(vo:SusbmaInventoryStatusVO):void
		{
			notificationOnResult = LocalConst.USB_INVENTORY_STATUS_DELETE_RESULT;
			notificationOnFault = LocalConst.USB_INVENTORY_STATUS_DELETE_FAULT;
			
			var token:AsyncToken = remote.getOperation("deleteInventoryStatus").send(vo);
			token.addResponder(this);
		}
		
		/**
		 * 이력 리스트
		 */	
		public function selectUsbInventoryHistoryList(vo:SusbmaInventoryHistoryVO):void
		{
			notificationOnResult = LocalConst.USB_INVENTORY_HISTORY_LIST_RESULT;
			notificationOnFault = LocalConst.USB_INVENTORY_HISTORY_LIST_FAULT;
			
			var token:AsyncToken = remote.getOperation("selectInventoryHistoryList").send(vo);
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
//					sendNotification(notificationMap[operation], resultEvent.result);
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
					Alert.show(text, DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_INVENTORY"));
					
					sendNotification(notificationOnFault, faultEvent.fault);
				}
			}
		}		
	}
}