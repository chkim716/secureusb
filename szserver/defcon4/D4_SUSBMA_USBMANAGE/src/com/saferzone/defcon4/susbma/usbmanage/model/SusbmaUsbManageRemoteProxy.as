//------------------------------------------------------------------------------
//
//   Copyright 2011 
//   Saferzone All rights reserved. 
//
//------------------------------------------------------------------------------

package com.saferzone.defcon4.susbma.usbmanage.model
{
	
	import com.saferzone.defcon4.common.DmosFramework;
	import com.saferzone.defcon4.services.SusbmaCommonRemote;
	import com.saferzone.defcon4.services.SusbmaUsbManageRemote;
	import com.saferzone.defcon4.services.vo.AgntmaEmergencyKeyLogVO;
	import com.saferzone.defcon4.services.vo.SearchSusbMasterVO;
	import com.saferzone.defcon4.services.vo.SusbChangeHistoryVO;
	import com.saferzone.defcon4.services.vo.SusbUsbMasterVO;
	import com.saferzone.defcon4.susbma.usbmanage.consts.LocalConst;
	
	import mx.collections.IList;
	import mx.controls.Alert;
	import mx.messaging.messages.RemotingMessage;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
	public class SusbmaUsbManageRemoteProxy extends Proxy implements IProxy, IResponder
	{
		
		//------------------------------------------------------------------------------
		//
		// Constants 
		//
		//------------------------------------------------------------------------------
		
		/**
		 * Proxy의 이름입니다.
		 */
		public static const NAME:String = "SusbmaUsbManageRemoteProxy";
		
		//------------------------------------------------------------------------------
		//
		// Constructor 
		//
		//------------------------------------------------------------------------------
		
		public function SusbmaUsbManageRemoteProxy(data:Object = null)
		{
			super(NAME, data);
			service = new SusbmaUsbManageRemote();
			commonService = new SusbmaCommonRemote();
		}
		
		
		//------------------------------------------------------------------------------
		//
		// Properties #private 
		//
		//------------------------------------------------------------------------------
		
		private var service:SusbmaUsbManageRemote;
		
		private var commonService:SusbmaCommonRemote;
		
		private var notificationOnResult:String;
		
		private var notificationOnFault:String;
		
		//------------------------------------------------------------------------------
		//
		// Methods 
		//
		//------------------------------------------------------------------------------
		
		//--------------------------------------
		// public 
		//--------------------------------------
		
		public function selectSusbMasterList(vo:SearchSusbMasterVO):void
		{
			notificationOnResult = LocalConst.SUSBMA_USBMANAGE_USB_LIST_LOADSUCCESS;
			notificationOnFault = LocalConst.SUSBMA_USBMANAGE_USB_LIST_LOADFAIL;
			var token:AsyncToken = service.selectSusbMasterList(vo);
			token.addResponder(this);
		}
		
		public function insertUsubmaMaster(vo:SusbUsbMasterVO):void
		{
			notificationOnResult = LocalConst.SUSBMA_USBMANAGE_USB_ADDSUCCESS;
			notificationOnFault = LocalConst.SUSBMA_USBMANAGE_USB_ADDFAIL;
			var token:AsyncToken = service.insertUsubmaMaster(vo);
			token.addResponder(this);
		}
		
		public function updateSusbMaster(vo:SusbChangeHistoryVO):void
		{
			notificationOnResult = LocalConst.SUSBMA_USBMANAGE_USB_MODIFYSUCCESS;
			notificationOnFault = LocalConst.SUSBMA_USBMANAGE_USB_MODIFYFAIL;
			var token:AsyncToken = service.updateSusbMaster(vo);
			token.addResponder(this);
		}
		
		public function updateMngEmpId(vo:SusbUsbMasterVO):void
		{
			notificationOnResult = LocalConst.SUSBMA_USBMANAGE_MNGEMPID_MODIFYSUCCESS;
			notificationOnFault = LocalConst.SUSBMA_USBMANAGE_MNGEMPID_MODIFYFAIL;
			var token:AsyncToken = service.updateMngEmpId(vo);
			token.addResponder(this);
		}
		
		
		public function deleteSusbmaMaster(list:IList):void
		{
			notificationOnResult = LocalConst.SUSBMA_USBMANAGE_USB_DELETESUCCESS;
			notificationOnFault = LocalConst.SUSBMA_USBMANAGE_USB_DELETEFAIL;
			var token:AsyncToken = service.deleteSusbmaMaster(list);
			token.addResponder(this);
		}
		
		public function selectSusbmaChangeList(sno:String):void
		{
			notificationOnResult = LocalConst.SUSBMA_USBMANAGE_CHANGE_LIST_LOADSUCCESS;
			notificationOnFault = LocalConst.SUSBMA_USBMANAGE_CHANGE_LIST_LOADFAIL;
			var token:AsyncToken = service.selectSusbmaChangeList(sno);
			token.addResponder(this);
		}
		
		
		public function selectSusbmaUseList(sno:String):void
		{
			notificationOnResult = LocalConst.SUSBMA_USBMANAGE_USE_LIST_LOADSUCCESS;
			notificationOnFault = LocalConst.SUSBMA_USBMANAGE_USE_LIST_LOADFAIL;
			var token:AsyncToken = service.selectSusbmaUseList(sno);
			token.addResponder(this);
		}
		
		
		public function selectCommonList(map:Object):void
		{
			notificationOnResult = LocalConst.SUSBMA_USBMANAGE_COMMON_LIST_LOADSUCCESS;
			notificationOnFault = LocalConst.SUSBMA_USBMANAGE_COMMON_LIST_LOADFAIL;
			var token:AsyncToken = commonService.selectCommonList(map);
			token.addResponder(this);
		}
		
		public function changeUsbPassword(targets:IList, sno:String, pwd:String, isDataDelete:int, isFirst:int):void
		{
			notificationOnResult = LocalConst.D4LC_NOTIFY_PASSWORD_INITIALIZE_RESULT;
			notificationOnFault = LocalConst.D4LC_NOTIFY_PASSWORD_INITIALIZE_FAULT;
			var token:AsyncToken = service.changeUsbPassword(targets, sno, pwd, isDataDelete, isFirst);
			token.addResponder(this);
		}
		
		public function returnSusbmaMaster(vo:SusbUsbMasterVO):void
		{
			notificationOnResult = LocalConst.D4LC_NOTIFY_USB_RETURN_SUCCESS;
			notificationOnFault = LocalConst.D4LC_NOTIFY_USB_RETURN_FAIL;
			var token:AsyncToken = service.returnSusbmaMaster(vo);
			token.addResponder(this);
		}
		
		public function makeEmergencyKey(vo:AgntmaEmergencyKeyLogVO):void
		{
			notificationOnResult = LocalConst.D4LC_NOTIFY_MAKE_EMERGENCY_KEY_RESULT;
			notificationOnFault = LocalConst.D4LC_NOTIFY_MAKE_EMERGENCY_KEY_FAIL;
			var token:AsyncToken = service.makeEmergencyKey(vo);
			token.addResponder(this);
		}

		public function getGroupType():void
		{
			notificationOnResult = LocalConst.D4LC_NOTIFY_SUSBMA_GROUPTYPE_SEL_SUCCESS;
			var token:AsyncToken = service.getGroupType();
			token.addResponder(this);
		}
		
		public function selectSusbmaDeleteList(sno:String):void
		{
			notificationOnResult = LocalConst.SUSBMA_USBMANAGE_DELETE_LIST_LOADSUCCESS;
			notificationOnFault = LocalConst.SUSBMA_USBMANAGE_DELETE_LIST_LOADFAIL;
			var token:AsyncToken = service.selectSusbmaDeleteList(sno);
			token.addResponder(this);
		}
		
		public function usbMassRegister(tempFileName:String):void
		{
			notificationOnResult = LocalConst.SUSBMA_USBMANAGE_MASS_REGISTER_SUCCESS;
			notificationOnFault = LocalConst.SUSBMA_USBMANAGE_MASS_REGISTER_FAIL;
			var token:AsyncToken = service.usbMassRegister(tempFileName);
			token.addResponder(this);
		}
		
		public function selectSusbmaStatusList(sno:String, startDate:String, endDate:String):void
		{
			notificationOnResult = LocalConst.SUSBMA_USBMANAGE_STATUS_LIST_LOADSUCCESS;
			notificationOnFault = LocalConst.SUSBMA_USBMANAGE_STATUS_LIST_LOADFAIL;
			var token:AsyncToken = service.selectSusbmaStatusList(sno, startDate, endDate);
			token.addResponder(this);
		}
		
		public function selectSusbmafileDeleteList(sno:String, startDate:String, endDate:String):void
		{
			notificationOnResult = LocalConst.SUSBMA_USBMANAGE_FILE_DELETE_LISTLOADSUCCESS;
			notificationOnFault = LocalConst.SUSBMA_USBMANAGE_FILE_DELETE_LISTLOADFAIL;
			var token:AsyncToken = service.selectSusbmafileDeleteList(sno, startDate, endDate);
			token.addResponder(this);
		}
		
		public function selectSusbmaUpdateList(sno:String):void
		{
			notificationOnResult = LocalConst.SUSBMA_USBMANAGE_UPDATE_LIST_LOADSUCCESS;
			notificationOnFault = LocalConst.SUSBMA_USBMANAGE_UPDATE_LIST_LOADFAIL;
			var token:AsyncToken = service.selectSusbmaUpdateList(sno);
			token.addResponder(this);
		}
		
		public function initPasswordResult(sno:String):void
		{
			notificationOnResult = LocalConst.D4LC_NOTIFY_PASSWORD_INITIALIZE_CHECK_SUCCESS;
			notificationOnFault = LocalConst.D4LC_NOTIFY_PASSWORD_INITIALIZE_CHECK_FAULT;
			var token:AsyncToken = service.initPasswordResult(sno);
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
					//Alert.show(text, DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_USBMANAGE"));
					//Alert.show("오류가 발생하였습니다. 관리자에게 문의해 주십시오.", DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_USBMANAGE"));
					if(DmosFramework.getInstance().CONFIG("USE_SHOW_ERROR_POPUP") == "1"){
						Alert.show(DmosFramework.getInstance().SNL("SYSTEM_ERROR_EXPLAIN"), DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_USBMANAGE"));
					}
					else{
						Alert.show(text, DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_USBMANAGE"));	
					}
				}
			}
		}
	}
}
