//------------------------------------------------------------------------------
//
//   Copyright 2011 
//   Saferzone All rights reserved. 
//
//------------------------------------------------------------------------------

package com.saferzone.defcon4.susbma.policy.model
{
	
	import mx.collections.IList;
	import mx.controls.Alert;
	import mx.messaging.messages.RemotingMessage;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
	import com.saferzone.defcon4.common.DmosFramework;
	import com.saferzone.defcon4.services.SusbmaPolicyRemote;
	import com.saferzone.defcon4.services.vo.SusbmaClassVO;
	import com.saferzone.defcon4.services.vo.SusbmaPolicyMasterVO;
	import com.saferzone.defcon4.services.vo.SusbmaCommonPolicyMasterVO;
	import com.saferzone.defcon4.services.vo.SusbmaPolicyGroupUsbVO;
	import com.saferzone.defcon4.services.vo.SusbmaPolicyRawVO;
	import com.saferzone.defcon4.susbma.policy.consts.LocalConst;
	
	public class SusbmaPolicyRemoteProxy extends Proxy implements IProxy, IResponder
	{
		
		//------------------------------------------------------------------------------
		//
		// Constants 
		//
		//------------------------------------------------------------------------------
		
		/**
		 * Proxy의 이름입니다.
		 */
		public static const NAME:String = "SusbmaPolicyRemoteProxy";
		
		//------------------------------------------------------------------------------
		//
		// Constructor 
		//
		//------------------------------------------------------------------------------
		
		public function SusbmaPolicyRemoteProxy(data:Object = null)
		{
			super(NAME, data);
			service = new SusbmaPolicyRemote();
		}
		
		
		//------------------------------------------------------------------------------
		//
		// Properties #private 
		//
		//------------------------------------------------------------------------------
		
		private var service:SusbmaPolicyRemote;
		
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
		
		public function selectSusbmaPolicyClassList(rangeType:int):void
		{
			notificationOnResult = LocalConst.SUSBMA_POLIICY_CLASS_LIST_LOADSUCCESS;
			notificationOnFault = LocalConst.SUSBMA_POLIICY_CLASS_LIST_LOADFAIL;
			var token:AsyncToken = service.selectSusbmaPolicyMasterList(rangeType);
			token.addResponder(this);
		}
		
		public function updateSusbmaPolicyClass(vo:SusbmaClassVO):void
		{
			notificationOnResult = LocalConst.SUSBMA_POLIICY_CLASS_MODIFYSUCCESS;
			notificationOnFault = LocalConst.SUSBMA_POLIICY_CLASS_MODIFYFAIL;
			var token:AsyncToken = service.updateSusbmaPolicyClass(vo);
			token.addResponder(this);
		}
		
		public function selectSusbmaPolicyDeptList(rangeType:int):void
		{
			notificationOnResult = LocalConst.SUSBMA_POLIICY_DEPT_LIST_LOADSUCCESS;
			notificationOnFault = LocalConst.SUSBMA_POLIICY_DEPT_LIST_LOADFAIL;
			var token:AsyncToken = service.selectSusbmaPolicyMasterList(rangeType);
			token.addResponder(this);
		}
		
		public function insertSusbmaPolicyOrg(vo:SusbmaPolicyMasterVO):void
		{
			notificationOnResult = LocalConst.SUSBMA_POLIICY_DEPT_ADDSUCCESS;
			notificationOnFault = LocalConst.SUSBMA_POLIICY_DEPT_ADDFAIL;
			var token:AsyncToken = service.insertSusbmaPolicyOrg(vo);
			token.addResponder(this);
		}
		
		public function updateSusbmaPolicyOrg(vo:SusbmaPolicyMasterVO):void
		{
			notificationOnResult = LocalConst.SUSBMA_POLIICY_DEPT_MODIFYSUCCESS;
			notificationOnFault = LocalConst.SUSBMA_POLIICY_DEPT_MODIFYFAIL;
			var token:AsyncToken = service.updateSusbmaPolicyOrg(vo);
			token.addResponder(this);
		}
		
		public function deleteSusbmaPolicyOrg(usbPolicyId:int):void
		{
			notificationOnResult = LocalConst.SUSBMA_POLIICY_DEPT_DELETESUCCESS;
			notificationOnFault = LocalConst.SUSBMA_POLIICY_DEPT_DELETEFAIL;
			var token:AsyncToken = service.deleteSusbmaPolicyOrg(usbPolicyId);
			token.addResponder(this);
		}
		
		public function selectSusbmaPolicyGroupList(rangeType:int):void
		{
			notificationOnResult = LocalConst.SUSBMA_POLIICY_POLICY_GROUP_LIST_LOADSUCCESS;
			notificationOnFault = LocalConst.SUSBMA_POLIICY_POLICY_GROUP_LIST_LOADFAIL;
			var token:AsyncToken = service.selectSusbmaPolicyMasterList(rangeType);
			token.addResponder(this);
		}
		
		public function selectSusbmaPolicyGrpRaw(vo:SusbmaPolicyMasterVO):void
		{
			notificationOnResult = LocalConst.SUSBMA_POLIICY_POLICY_GROUP_RAW_LIST_LOADSUCCESS;
			notificationOnFault = LocalConst.SUSBMA_POLIICY_POLICY_GROUP_RAW_LIST_LOADFAIL;
			var token:AsyncToken = service.selectSusbmaPolicyGrpRaw(vo);
			token.addResponder(this);
		}
		
		public function insertSusbmaPolicyGrp(vo:SusbmaPolicyMasterVO):void
		{
			notificationOnResult = LocalConst.SUSBMA_POLIICY_POLICY_GROUP_ADDSUCCESS;
			notificationOnFault = LocalConst.SUSBMA_POLIICY_POLICY_GROUP_ADDFAIL;
			var token:AsyncToken = service.insertSusbmaPolicyGrp(vo);
			token.addResponder(this);
		}
		
		public function updateSusbmaPolicyGrp(vo:SusbmaPolicyMasterVO):void
		{
			notificationOnResult = LocalConst.SUSBMA_POLIICY_POLICY_GROUP_MODIFYSUCCESS;
			notificationOnFault = LocalConst.SUSBMA_POLIICY_POLICY_GROUP_MODIFYFAIL;
			var token:AsyncToken = service.updateSusbmaPolicyGrp(vo);
			token.addResponder(this);
		}
		
		public function deleteSusbmaPolicyGrp(grpId:int):void
		{
			notificationOnResult = LocalConst.SUSBMA_POLIICY_POLICY_GROUP_DELETESUCCESS;
			notificationOnFault = LocalConst.SUSBMA_POLIICY_POLICY_GROUP_DELETEFAIL;
			var token:AsyncToken = service.deleteSusbmaPolicyGrp(grpId);
			token.addResponder(this);
		}
		
		public function insertSusbmaPolicyGrpUsb(list:IList):void
		{
			notificationOnResult = LocalConst.SUSBMA_POLIICY_POLICY_USB_ADDSUCCESS;
			notificationOnFault = LocalConst.SUSBMA_POLIICY_POLICY_USB_ADDFAIL;
			var token:AsyncToken = service.insertSusbmaPolicyGrpUsb(list);
			token.addResponder(this);
		}
		
		public function updateSusbmaPolicyGrpUsb(vo:SusbmaPolicyGroupUsbVO):void
		{
			notificationOnResult = LocalConst.SUSBMA_POLIICY_POLICY_USB_MODIFYSUCCESS;
			notificationOnFault = LocalConst.SUSBMA_POLIICY_POLICY_USB_MODIFYFAIL;
			var token:AsyncToken = service.updateSusbmaPolicyGrpUsb(vo);
			token.addResponder(this);
		}
		
		public function deleteSusbmaPolicyGrpUsb(sno:String):void
		{
			notificationOnResult = LocalConst.SUSBMA_POLIICY_POLICY_USB_DELETESUCCESS;
			notificationOnFault = LocalConst.SUSBMA_POLIICY_POLICY_USB_DELETEFAIL;
			var token:AsyncToken = service.deleteSusbmaPolicyGrpUsb(sno);
			token.addResponder(this);
		}
		
		public function selectSusbmaPolicyRaw(policyId:int):void
		{
			notificationOnResult = LocalConst.SUSBMA_POLIICY_RAW_LIST_LOADSUCCESS;
			notificationOnFault = LocalConst.SUSBMA_POLIICY_RAW_LIST_LOADFAIL;
			var token:AsyncToken = service.selectSusbmaPolicyRaw(policyId);
			token.addResponder(this);
		}
		
		public function updateSusbmaPolicyRaw(vo:SusbmaPolicyRawVO):void
		{
			notificationOnResult = LocalConst.SUSBMA_POLIICY_RAW_MODIFYSUCCESS;
			notificationOnFault = LocalConst.SUSBMA_POLIICY_RAW_MODIFYFAIL;
			var token:AsyncToken = service.updateSusbmaPolicyRaw(vo);
			token.addResponder(this);
		}
		
		public function insertSusbmaPolicyRaw(usbPolicyId:int):void
		{
			notificationOnResult = LocalConst.SUSBMA_POLIICY_RAW_ADDSUCCESS;
			notificationOnFault = LocalConst.SUSBMA_POLIICY_RAW_ADDFAIL;
			var token:AsyncToken = service.insertSusbmaPolicyRaw(usbPolicyId);
			token.addResponder(this);
		}
		
		public function deleteSusbmaPolicyRaw(vo:SusbmaPolicyRawVO):void
		{
			notificationOnResult = LocalConst.SUSBMA_POLIICY_RAW_DELETESUCCESS;
			notificationOnFault = LocalConst.SUSBMA_POLIICY_RAW_DELETEFAIL;
			var token:AsyncToken = service.deleteSusbmaPolicyRaw(vo);
			token.addResponder(this);
		}
		
		public function selectSusbmaCommonPolicy():void
		{
			notificationOnResult = LocalConst.SUSBMA_COMMON_POLICY_LOADSUCCESS;
			notificationOnFault = LocalConst.SUSBMA_COMMON_POLICY_LOADFAIL;
			var token:AsyncToken = service.selectSusbmaCommonPolicy();
			token.addResponder(this);
		}

		public function updateSusbmaCommonPolicy(vo:SusbmaCommonPolicyMasterVO):void
		{
			notificationOnResult = LocalConst.SUSBMA_COMMON_POLICY_SAVESUCCESS;
			notificationOnFault = LocalConst.SUSBMA_COMMON_POLICY_SAVEFAIL;
			var token:AsyncToken = service.updateSusbmaCommonPolicy(vo);
			token.addResponder(this);
		}
		
		public function updateSusbmaInitPassword(initPassword:String):void
		{
			notificationOnResult = LocalConst.D4LC_NOTIFY_PASSWORD_INITIALIZE_RESULT;
			notificationOnFault = LocalConst.D4LC_NOTIFY_PASSWORD_INITIALIZE_FAULT;
			var token:AsyncToken = service.updateSusbmaInitPassword(initPassword);
			token.addResponder(this);
		}
		
		public function selectPopupList():void
		{
			notificationOnResult = LocalConst.D4LC_NOTIFY_POPUP_LIST_LOADSUCCESS;
			notificationOnFault = LocalConst.D4LC_NOTIFY_POPUP_LIST_LOADFAIL;
			var token:AsyncToken = service.selectPopupList();
			token.addResponder(this);
		}
		
		public function updatePopupList(popupObj:Object):void
		{
			notificationOnResult = LocalConst.D4LC_NOTIFY_POPUP_LIST_SAVESUCCESS;
			notificationOnFault = LocalConst.SUSBMA_COMMON_POLICY_SAVEFAIL;
			var token:AsyncToken = service.updatePopupList(popupObj);
			token.addResponder(this);
		}
		
		public function selectSecureAdminInfo():void
		{
			notificationOnResult = LocalConst.D4LC_NOTIFY_SECURE_ADMIN_INFO_LOADSUCCESS;
			notificationOnFault = LocalConst.D4LC_NOTIFY_SECURE_ADMIN_INFO_LOADFAIL;
			var token:AsyncToken = service.selectSecureAdminInfo();
			token.addResponder(this);
		}
		
		public function updateSecureAdminInfo(vo:SusbmaCommonPolicyMasterVO):void
		{
			notificationOnResult = LocalConst.D4LC_NOTIFY_SECURE_ADMIN_INFO_SAVESUCCESS;
			notificationOnFault = LocalConst.D4LC_NOTIFY_SECURE_ADMIN_INFO_SAVEFAIL;
			var token:AsyncToken = service.updateSecureAdminInfo(vo);
			token.addResponder(this);
		}
		
		public function selectGroupType():void
		{
			notificationOnResult = LocalConst.D4LC_NOTIFY_GROUPTYPE_SELECTSUCCESS;
			notificationOnFault = LocalConst.D4LC_NOTIFY_GROUPTYPE_SELECTFAIL;
			var token:AsyncToken = service.selectGroupType();
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
					Alert.show(text, DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_POLICY"));
				}
			}
		}
	}
}
