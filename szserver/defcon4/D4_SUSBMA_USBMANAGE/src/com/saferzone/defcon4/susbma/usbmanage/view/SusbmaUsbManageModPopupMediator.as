//------------------------------------------------------------------------------
//
//   Copyright 2011 
//   Saferzone All rights reserved. 
//
//------------------------------------------------------------------------------

package com.saferzone.defcon4.susbma.usbmanage.view
{
	import com.saferzone.defcon4.common.DmosFramework;
	import com.saferzone.defcon4.common.SZPopupMediator;
	import com.saferzone.defcon4.common.components.DeptSearchPopup;
	import com.saferzone.defcon4.common.components.MNSearchPopup;
	import com.saferzone.defcon4.common.components.UserSearchPopup;
	import com.saferzone.defcon4.common.events.DeptSearchPopupEvent;
	import com.saferzone.defcon4.common.events.MNSearchPopupEvent;
	import com.saferzone.defcon4.common.events.UserSearchPopupEvent;
	import com.saferzone.defcon4.common.utils.SZUtil;
	import com.saferzone.defcon4.services.vo.SYSBaseOrgVO;
	import com.saferzone.defcon4.services.vo.SusbChangeHistoryVO;
	import com.saferzone.defcon4.services.vo.SusbUsbMasterVO;
	import com.saferzone.defcon4.susbma.usbmanage.ApplicationFacade;
	import com.saferzone.defcon4.susbma.usbmanage.consts.LocalConst;
	import com.saferzone.defcon4.susbma.usbmanage.view.comp.SusbmaUsbManageModPopup;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	public class SusbmaUsbManageModPopupMediator extends SZPopupMediator
	{
		
		//------------------------------------------------------------------------------
		//
		// Constants 
		//
		//------------------------------------------------------------------------------
		
		public static const NAME:String = 'SusbmaUsbManageModPopupMediator';
		
		//------------------------------------------------------------------------------
		//
		// Constructor 
		//
		//------------------------------------------------------------------------------
		
		public function SusbmaUsbManageModPopupMediator(viewComponent:Object)
		{
			super(NAME, viewComponent);
		}
		
		
		//------------------------------------------------------------------------------
		//
		// Properties #public 
		//
		//------------------------------------------------------------------------------
		
		public var opener:D4_SUSBMA_USBMANAGE;
		
		public var usbMasterVo:SusbUsbMasterVO;
		
		public function get myWindow():SusbmaUsbManageModPopup
		{
			return viewComponent as SusbmaUsbManageModPopup;
		}
		
		public function set usbData(vo:SusbUsbMasterVO):void
		{
			usbVO = vo;
			
			if(vo.mediaId == 1){
				myWindow.mediaForm.visible = myWindow.mediaForm.includeInLayout = false;
			}else{
				myWindow.mediaForm.visible = myWindow.mediaForm.includeInLayout = true;
				myWindow.media.selectedIndex = SZUtil.getIndexItem(vo.mediaName, myWindow.media.dataProvider as ArrayCollection,
					"mediaName");
			}
			
			myWindow.grade.selectedIndex = SZUtil.getIndexItem(vo.className, myWindow.grade.dataProvider as ArrayCollection,
				"className");
			myWindow.stateStr.text = vo.stateName;
			myWindow.manageNo.text = vo.managementId;
			myWindow.managerName.text = vo.mngEmpName;
			myWindow.managerId.text = vo.mngEmpId;
			myWindow.userName.text = vo.userEmpName;
			myWindow.userId.text = vo.userEmpId;
			
	
			myWindow.volume.text = vo.capacity;
			myWindow.state.selectedIndex = vo.stateId - 1;
//			if(vo.isDeptType == 1) myWindow.isDeptType.selected = true;
			myWindow.isDeptType.selectedIndex = vo.isDeptType;
			var isTimeCheckBool:Boolean = DmosFramework.getInstance().CONFIG("USB_USE_PERIOD")=="1"?true:false;
			if(isTimeCheckBool)
			{
				if(vo.isTimeCheck != 0)
				{ 
					myWindow.isTimeCheck.selected = false;
				}
				else 
				{
					myWindow.isTimeCheck.selected = true;
				}
				
				
				if(vo.permStartDate == null || vo.permStartDate == "")
				{
					myWindow.permStartDate.selectedDate = SZUtil.dateAdd("YYYY");
				} else {
					myWindow.permStartDate.text = vo.permStartDate;
				}
				
				if(vo.permEndDate == null || vo.permEndDate == "")
				{
					myWindow.permEndDate.selectedDate = SZUtil.dateAdd("m", +1);
				} else {

					myWindow.permEndDate.text = vo.permEndDate;
				}
			}
			if(ApplicationFacade(facade).selectedUsbCount > 1) 
			{
				myWindow.userName.enabled     = // myWindow.userName.enabled	 =
					myWindow.volume.enabled 	  = // myWindow.volume.enabled		 =
					myWindow.grade.enabled 	      = // myWindow.grade.enabled       =
//					myWindow.isDeptType.enabled   = // myWindow.isDeptType.enabled  =
					myWindow.manageNo.enabled     = // myWindow.manageNo.enabled    =
					myWindow.managerId.enabled    = false; // myWindow.managerId.enabled   = 		false;
			}
			
			if(vo.doCheckUseTerm == 1)
			{
				myWindow.usePeriod.selected = true;
				myWindow.useTermBegin.enabled = true;
				myWindow.useTermEnd.enabled = true;
				
				myWindow.useTermBegin.text = vo.useTermBegin;
				myWindow.useTermEnd.text = vo.useTermEnd;
			}
			else
			{
				myWindow.usePeriod.selected = false;
				myWindow.useTermBegin.enabled = false;
				myWindow.useTermEnd.enabled = false;
			}
			
		}
		
		//------------------------------------------------------------------------------
		//
		// Properties #private 
		//
		//------------------------------------------------------------------------------
		
		private var usbVO:SusbUsbMasterVO;
		
		
		//관리번호 팝업처리
		private var managerNumberPop:MNSearchPopup;
		
		//관리 책임자 팝업처리
		private var userPop:UserSearchPopup;
		private var deptPop:DeptSearchPopup;
		//------------------------------------------------------------------------------
		//
		// Methods 
		//
		//------------------------------------------------------------------------------
		
		//--------------------------------------
		// Event Handlers 
		//--------------------------------------
		protected function okClickEventHandler(event:MouseEvent):void
		{
			var historyVo:SusbChangeHistoryVO = new SusbChangeHistoryVO();
			var usbDgProvider:IList = opener.usbDG.dataProvider;
			var usbDgLength:int		= usbDgProvider.length;
			/*
			if((myWindow.reason.selectedIndex + 1) == myWindow.reason.dataProvider.length){
				
				if(myWindow.reasonInput.text.length >= 10) 
				{
					Alert.show("변경사유 입력 범위가 잘못되었습니다.(10자)", DmosFramework.getInstance().SNL("SC_MODIFY_PROPERTY"));
					return;
				}
				historyVo.reasonId = myWindow.reason.selectedItem.reasonId;
				historyVo.reasonName = myWindow.reasonInput.text;
			}
			else if(myWindow.reason.selectedIndex > 0)
			{
				historyVo.reasonId = myWindow.reason.selectedItem.reasonId;
			
			}else{
				historyVo.reasonId = 4; // '기존정보변경' 값이 들어감
				//				Alert.show(DmosFramework.getInstance().SNL("SUSBMA_USBMANAGE_MESSAGE_REASON_REQUIRED"),
				//						   DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_USBMANAGE"));
				//				return;   myWindow.usePeriod.selected
				
			}
			*/
			if(myWindow.reason.selectedIndex > 0)
			{
				historyVo.reasonId = myWindow.reason.selectedItem.reasonId;
			}
			else
			{
				historyVo.reasonId = 4; // '기존정보변경' 값이 들어감
				//				Alert.show(DmosFramework.getInstance().SNL("SUSBMA_USBMANAGE_MESSAGE_REASON_REQUIRED"),
				//						   DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_USBMANAGE"));
				//				return;   myWindow.usePeriod.selected
				
			}
			historyVo.reasonChange = myWindow.reasonChange.text;
			
			if(myWindow.grade.selectedIndex > -1)
				historyVo.classId = myWindow.grade.selectedItem.classId;
			if(myWindow.state.selectedIndex > -1)
				historyVo.stateId = myWindow.state.selectedItem.stateId;
			if(myWindow.media.selectedIndex > -1){
				if(opener.usbDG.selectedItem.mediaId == 1){
					historyVo.mediaId = 1;
				}else{
					historyVo.mediaId = myWindow.media.selectedItem.mediaId;
				}
			}
				
			historyVo.managementId = myWindow.manageNo.text;
			historyVo.mngEmpName = myWindow.managerName.text;
			historyVo.mngEmpId = myWindow.managerId.text;
			historyVo.userEmpName = myWindow.userName.text;
			historyVo.userEmpId = myWindow.userId.text;
			historyVo.capacity = int(myWindow.volume.text);
			historyVo.sno = usbVO.sno;
			historyVo.updateType = 0;	// 등록정보변경 :0, 불용처리:1;
			historyVo.orgNameList = getOrgNameList();
			historyVo.isDeptType = int(myWindow.isDeptType.selectedIndex);
//			historyVo.isDeptType = int(myWindow.isDeptType.selected)||int(myWindow.isNhicDeptType.selected);
			//Alert.show("usbMasterVO.assetId = " + usbMasterVo.assetId + ", usbMasterVO.pcOrgId = " + usbMasterVo.pcOrgId);
			historyVo.assetId = usbMasterVo.assetId;
			historyVo.pcOrgId = usbMasterVo.pcOrgId;
			var isTimeCheckBool:Boolean = DmosFramework.getInstance().CONFIG("USB_USE_PERIOD")=="1"?true:false;
			if(isTimeCheckBool)
			{
				if(myWindow.isTimeCheck.selected)
				{
					historyVo.isTimeCheck = 0;
					historyVo.permStartDate = '0000-00-00 00:00:00';
					historyVo.permEndDate = '0000-00-00 00:00:00';
				}else{
					/**
					 * isTimecheck
					 * 0:무제한
					 * 1:기간만료
					 * 2:기간내
					 * */
					if(Number(SZUtil.replaceAll(myWindow.permStartDate.text.substr(0,10),'-','')) > Number(SZUtil.replaceAll(myWindow.permEndDate.text.substr(0,10),'-','')))
					{
						Alert.show(DmosFramework.getInstance().SNL("DEFCON4-ERR-5013"), DmosFramework.getInstance().SNL("SC_MODIFY_PROPERTY"));
						myWindow.permStartDate.selectedDate = SZUtil.dateAdd("YYYY");
						myWindow.permEndDate.selectedDate = SZUtil.dateAdd("YYYY", +1);
						return;
					}
					
					historyVo.isTimeCheck = 2;
					historyVo.permStartDate = myWindow.permStartDate.text.substring(0,10)+ " 00:00:00";
					historyVo.permEndDate = myWindow.permEndDate.text.substring(0,10)+ " 23:59:59";
				}
				
			}
			if(myWindow.usePeriod.selected)
			{
				historyVo.useTermBegin = myWindow.useTermBegin.text;
				historyVo.useTermEnd = myWindow.useTermEnd.text;
			}
			
			callPopupOnOk(historyVo);
			closeMyWindow();
		}
		
		protected function getOrgNameList():String 
		{
			var orgList:String = "";
			for (var i:int = 0; i < myWindow.deptDG.dataProvider.length; i++) 
			{
				orgList += myWindow.deptDG.dataProvider[i].orgId + "&";
				orgList += myWindow.deptDG.dataProvider[i].includeSubDept;
				orgList += "|";
			}
			return orgList;
		}
		
		protected function cancelClickEventHandler(event:MouseEvent):void
		{
			callPopupOnCancel("test-cancel");
			closeMyWindow();
		}
		
		private function closeHandler(event:Event):void
		{
			callPopupOnCancel("test-cancel");
			closeMyWindow();
		}
		
		private function callManagerNumberSearchPopup(event:MouseEvent):void
		{
			managerNumberPop = PopUpManager.createPopUp(ApplicationFacade(facade).application,
				MNSearchPopup,
				true) as MNSearchPopup;
			PopUpManager.centerPopUp(managerNumberPop);
			
			managerNumberPop.addEventListener(MNSearchPopupEvent.CONFIRM, selectManagerNumberHandler);
			managerNumberPop.addEventListener(CloseEvent.CLOSE, closeManagerNumberSearchPopupHandler);
			
		}
		
		private function selectManagerNumberHandler(event:MNSearchPopupEvent):void
		{
			myWindow.manageNo.text = event.selectedItem.managementId;
		}
		
		private function closeManagerNumberSearchPopupHandler(event:CloseEvent):void
		{
			managerNumberPop.removeEventListener(MNSearchPopupEvent.CONFIRM, selectManagerNumberHandler);
			managerNumberPop.removeEventListener(CloseEvent.CLOSE, closeManagerNumberSearchPopupHandler);
			
			PopUpManager.removePopUp(managerNumberPop);
		}
		
		private function callManagerSearchPopup(event:MouseEvent):void
		{
			userPop = PopUpManager.createPopUp(ApplicationFacade(facade).application,
				UserSearchPopup, true) as UserSearchPopup;
			PopUpManager.centerPopUp(userPop);
			userPop.resetSearchInfo();
			
			userPop.addEventListener(UserSearchPopupEvent.CONFIRM, selectManagerHandler);
			userPop.addEventListener(CloseEvent.CLOSE, closeManagerSearchPopupHandler);
		}
		
		private function selectManagerHandler(event:UserSearchPopupEvent):void
		{
			myWindow.managerId.text = event.selectedEmp.empId;
			myWindow.managerName.text = event.selectedEmp.empName;
		}
		
		
		private function closeManagerSearchPopupHandler(event:CloseEvent):void
		{
			userPop.removeEventListener(UserSearchPopupEvent.CONFIRM, selectManagerHandler);
			userPop.removeEventListener(CloseEvent.CLOSE, closeManagerSearchPopupHandler);
			
			PopUpManager.removePopUp(userPop);
		}
		
		//사용자 팝업처리
		private function callUserSearchPopup(event:MouseEvent):void
		{
			if(!myWindow.isNhicDeptType.selected){
				userPop = PopUpManager.createPopUp(ApplicationFacade(facade).application, UserSearchPopup, true) as UserSearchPopup;	
				PopUpManager.centerPopUp(userPop);
				userPop.resetSearchInfo();
				userPop.addEventListener(UserSearchPopupEvent.CONFIRM, selectUserHandler);
				userPop.addEventListener(CloseEvent.CLOSE, closeUserSearchPopupHandler);
			}else{
				deptPop = PopUpManager.createPopUp(ApplicationFacade(facade).application, DeptSearchPopup, true) as DeptSearchPopup;
				PopUpManager.centerPopUp(deptPop);
				deptPop.addEventListener(UserSearchPopupEvent.CONFIRM, deptSearchPopup_confirmHandler);
				deptPop.addEventListener(CloseEvent.CLOSE, closeDeptSearchPopupHandler);
			}
		}
		
		protected function deptSearchPopup_confirmHandler(event:DeptSearchPopupEvent):void
		{
			var selectedDept:SYSBaseOrgVO = event.selectedDept as SYSBaseOrgVO;
			myWindow.userName.text = selectedDept.orgName;
			myWindow.userId.text   = event.selectedDept.orgName;
		}
		
		private function selectUserHandler(event:UserSearchPopupEvent):void
		{
			myWindow.userId.text = event.selectedEmp.empId;
			myWindow.userName.text = event.selectedEmp.empName;
		}
		
		private function closeDeptSearchPopupHandler(event:CloseEvent):void
		{
			deptPop.removeEventListener(DeptSearchPopupEvent.CONFIRM, deptSearchPopup_confirmHandler);
			deptPop.removeEventListener(CloseEvent.CLOSE, closeDeptSearchPopupHandler);
			PopUpManager.removePopUp(deptPop);
		}
		
		private function closeUserSearchPopupHandler(event:CloseEvent):void
		{
			userPop.removeEventListener(UserSearchPopupEvent.CONFIRM, selectUserHandler);
			userPop.removeEventListener(CloseEvent.CLOSE, closeUserSearchPopupHandler);
			
			PopUpManager.removePopUp(userPop);
		}
		
		//--------------------------------------
		// Overriden Methods 
		//--------------------------------------
		
		/**
		 * 관심있는 notification
		 */
		override public function listNotificationInterests():Array
		{
			return [
				LocalConst.SUSBMA_USBMANAGE_COMMON_LIST_LOADSUCCESS,
				
				LocalConst.SUSBMA_USBMANAGE_COMMON_LIST_LOADFAIL
				
			];
		}
		
		/**
		 * 처리할 notification
		 */
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case LocalConst.SUSBMA_USBMANAGE_COMMON_LIST_LOADSUCCESS:
				{
					if(notification.getBody() == null)
						return;
					
					if(notification.getBody().REASONLIST)
					{
						var reasonVO:Object = {};
						reasonVO.reasonId = "-1";
						reasonVO.reasonName = DmosFramework.getInstance().SNL('SC_PROMPT_SELECT');
						myWindow.reason.dataProvider = notification.getBody().REASONLIST as ArrayCollection;
						myWindow.reason.dataProvider.addItemAt(reasonVO, 0);
						myWindow.reason.selectedIndex = 0;
//						myWindow.isDeptType.selected;
					}
					if(notification.getBody().CLASSLIST)
					{
						myWindow.grade.dataProvider = notification.getBody().CLASSLIST as ArrayCollection;
						myWindow.grade.selectedIndex = 0;
					}
					if(notification.getBody().STATELIST)
					{
						myWindow.state.dataProvider = notification.getBody().STATELIST as ArrayCollection;
						myWindow.state.selectedIndex = usbVO == null ? 0 : usbVO.stateId - 1;
					}
					if(notification.getBody().MEDIATYPELIST)
					{
						myWindow.media.dataProvider = notification.getBody().MEDIATYPELIST as ArrayCollection;
						myWindow.media.dataProvider.removeItemAt(1);
						myWindow.media.selectedIndex = 0;
					}
					if(notification.getBody().DEPT_TYPE)
					{
						myWindow.isDeptType.selectedIndex = notification.getBody().DEPT_TYPE as int;
					}
					if(notification.getBody().ORG_LIST)
					{
						if((notification.getBody().ORG_LIST).length == 0)
							myWindow.deptDG.enabled = false;
						else myWindow.deptDG.enabled = true;
						myWindow.deptDG.dataProvider = notification.getBody().ORG_LIST as ArrayCollection;
					}
					usbData = opener.usbDG.selectedItem as SusbUsbMasterVO;
					break;
				}
					
				case LocalConst.SUSBMA_USBMANAGE_COMMON_LIST_LOADFAIL:
				{
					break;
				}
					
				default:
					break;
			}
		}
		
		override public function onRegister():void
		{
			//컨트롤 초기화 루틴은 여기서
			myWindow.deptArr = new ArrayCollection();
			myWindow.okBtn.addEventListener(MouseEvent.MOUSE_DOWN, okClickEventHandler);
			myWindow.cancelBtn.addEventListener(MouseEvent.MOUSE_DOWN, cancelClickEventHandler);
			myWindow.addEventListener(Event.CLOSE, closeHandler);
			
			myWindow.manageNoSearchBtn.addEventListener(MouseEvent.MOUSE_DOWN, callManagerNumberSearchPopup);
			myWindow.managerSearchBtn.addEventListener(MouseEvent.MOUSE_DOWN, callManagerSearchPopup);
			myWindow.userSearchBtn.addEventListener(MouseEvent.MOUSE_DOWN, callUserSearchPopup);
		}
		
		override public function onRemove():void
		{
			myWindow.okBtn.removeEventListener(MouseEvent.MOUSE_DOWN, okClickEventHandler);
			myWindow.cancelBtn.removeEventListener(MouseEvent.MOUSE_DOWN, cancelClickEventHandler);
			myWindow.removeEventListener(Event.CLOSE, closeHandler);
			
			myWindow.manageNoSearchBtn.removeEventListener(MouseEvent.MOUSE_DOWN, callManagerNumberSearchPopup);
			myWindow.managerSearchBtn.removeEventListener(MouseEvent.MOUSE_DOWN, callManagerSearchPopup);
			myWindow.userSearchBtn.removeEventListener(MouseEvent.MOUSE_DOWN, callUserSearchPopup);
		}
		
		
		//--------------------------------------
		// private 
		//--------------------------------------
		
		private function closeMyWindow():void
		{
			PopUpManager.removePopUp(myWindow);
			facade.removeMediator(NAME);
		}
	}
}
