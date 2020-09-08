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
	import com.saferzone.defcon4.common.components.Widget.Connect.Applicationfacade;
	import com.saferzone.defcon4.common.consts.CustomerId;
	import com.saferzone.defcon4.common.consts.GlobalConst;
	import com.saferzone.defcon4.common.events.DeptSearchPopupEvent;
	import com.saferzone.defcon4.common.events.MNSearchPopupEvent;
	import com.saferzone.defcon4.common.events.UserSearchPopupEvent;
	import com.saferzone.defcon4.common.utils.SZUtil;
	import com.saferzone.defcon4.services.SusbmaUseHistoryRemote;
	import com.saferzone.defcon4.services.vo.SYSBaseOrgVO;
	import com.saferzone.defcon4.services.vo.SearchSusbMasterVO;
	import com.saferzone.defcon4.services.vo.SusbUsbMasterVO;
	import com.saferzone.defcon4.services.vo.SusbmaMediaVO;
	import com.saferzone.defcon4.services.vo.SusbmaUsbVO;
	import com.saferzone.defcon4.susbma.usbmanage.ApplicationFacade;
	import com.saferzone.defcon4.susbma.usbmanage.consts.LocalConst;
	import com.saferzone.defcon4.susbma.usbmanage.event.SnoSearchPopupEvent;
	import com.saferzone.defcon4.susbma.usbmanage.view.comp.SnoSearchPopup;
	import com.saferzone.defcon4.susbma.usbmanage.view.comp.SusbmaUsbManageAddPopup;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	import mx.validators.Validator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	import spark.components.DropDownList;
	import spark.events.IndexChangeEvent;
	
	public class SusbmaUsbManageAddPopupMediator extends SZPopupMediator
	{
		
		//------------------------------------------------------------------------------
		//
		// Constants 
		//
		//------------------------------------------------------------------------------
		
		public static const NAME:String = 'SusbmaUsbManageAddPopupMediator';
		
		//------------------------------------------------------------------------------
		//
		// Constructor 
		//
		//------------------------------------------------------------------------------
		
		public function SusbmaUsbManageAddPopupMediator(viewComponent:Object)
		{
			super(NAME, viewComponent);
		}
		
		
		//------------------------------------------------------------------------------
		//
		// Properties #public 
		//
		//------------------------------------------------------------------------------
		
		public function get myWindow():SusbmaUsbManageAddPopup
		{
			return viewComponent as SusbmaUsbManageAddPopup;
		}
		
		//------------------------------------------------------------------------------
		//
		// Properties #private 
		//
		//------------------------------------------------------------------------------
		
		//관리번호 팝업처리
		private var managerNumberPop:MNSearchPopup;
		
		//관리 책임자 팝업처리
		private var userPop:UserSearchPopup;
		private var deptPop:DeptSearchPopup;
		private var snoPop:SnoSearchPopup;
		
		public  var isNonActiveX:Boolean= DmosFramework.getInstance().CONFIG("NON_ACTIVEX")=="1"?true:false;
		/**
		 * usb 추가 시 사용자를 관리책임자로 사용할지 판단. 기본적으로 false로 관리책임자와 사용자는 입력창이 다르게 세팅 
		 * */
		private var bUserIdEqaulMngId:Boolean = false;
		
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
			// Validator 대신  alert 창을 띄움
//			if(DmosFramework.getInstance().CUSTOMERID != 406){
//				if(myWindow.serialNo.text == "" || myWindow.serialNo.text == null)
//				{
//					if(myWindow.media.selectedIndex != 3){
//						Alert.show(DmosFramework.getInstance().SNL("SC_PROMPT_SELECT"), 
//							DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_USBMANAGE"));
//						return;
//					}
//				}
//			}
			
			
			if(myWindow.managerName.text == "" || myWindow.managerName.text == "" || myWindow.userId.text == "")
			{
				Alert.show(DmosFramework.getInstance().SNL("SC_PROMPT_INVALID_INSERTUSB_INFO"), 
					DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_USBMANAGE"));
				return;
			}
			
			if(isNonActiveX){
				if(myWindow.snoName.text == "" || myWindow.snoName.text == null)
				{
					Alert.show(DmosFramework.getInstance().SNL("SC_USB_SELECT"), 
						DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_USBMANAGE"));
					return;
				}
			}
			
			var masterVo:SusbUsbMasterVO = new SusbUsbMasterVO();
			if(isNonActiveX){
				masterVo.sno = myWindow.snoName.text;
			}else{
				masterVo.sno = myWindow.serialNo.text;
			}
			//	vo.sno = String(int(Math.random()* 100000000));
			masterVo.classId = myWindow.grade.selectedItem.classId;
			masterVo.managementId = myWindow.manageNo.text;
			if(bUserIdEqaulMngId){
				masterVo.mngEmpId = ApplicationFacade(facade).userId;
			}else{
				masterVo.mngEmpId = myWindow.managerId.text;
			}
			masterVo.userEmpId = myWindow.userId.text;
			
			if(myWindow.mediaType.text != '1' ){
				if(myWindow.volume.text == "0" || myWindow.volume.text.length == 0)
				{
					Alert.show(DmosFramework.getInstance().SNL('SC_PLEASE_ENTER_THE_USAGE_D4'), DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_USBMANAGE"));
					return;
				}
			}
			masterVo.capacity = myWindow.volume.text;
//			if(!isNonActiveX){
//				masterVo.mediaId = 1;
//			}else{
//				masterVo.mediaId = int(myWindow.mediaType.text);
//			}
			masterVo.mediaId = int(myWindow.media.selectedItem.mediaId);

			masterVo.isDeptType = int(myWindow.isDeptType.selectedIndex);
			masterVo.reason = myWindow.reason.text;
			var isTimeCheckBool:Boolean = DmosFramework.getInstance().CONFIG("USB_USE_PERIOD")=="1"?true:false;
			masterVo.mediaType = myWindow.media.selectedItem.mediaId;
			masterVo.orgNameList = getOrgNameList();
				
			if(isTimeCheckBool)
			{
				if(myWindow.isTimeCheck.selected)
				{
					masterVo.isTimeCheck = 0;
					masterVo.permStartDate = '0000-00-00 00:00:00';
					masterVo.permEndDate =  '0000-00-00 00:00:00';
				}else
				{
					if(Number(SZUtil.replaceAll(myWindow.permStartDate.text,'-','')) > Number(SZUtil.replaceAll(myWindow.permEndDate.text,'-','')))
					{
						Alert.show(DmosFramework.getInstance().SNL('DEFCON4-ERR-5013'), DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_USBMANAGE"));
						myWindow.permStartDate.selectedDate = SZUtil.dateAdd("YYYY");
						myWindow.permEndDate.selectedDate = SZUtil.dateAdd("YYYY", +1);
						return;
					}
					
					if(myWindow.permStartDate.text == "" || myWindow.permEndDate.text == "") 
					{
						Alert.show(DmosFramework.getInstance().SNL('SC_PLEASE_ENTER_THE_DATE_D4'), DmosFramework.getInstance().SNL("SC_SEARCH"));
						return;
					}
					/**
					 * isTimecheck
					 * 0:무제한
					 * 1:기간만료
					 * 2:기간내
					 * */
					masterVo.isTimeCheck = 2;
					masterVo.permStartDate = myWindow.permStartDate.text;
					masterVo.permEndDate = myWindow.permEndDate.text.substring(0,10)+ " 23:59:59";
				}
			}else
			{
				masterVo.isTimeCheck = 0;
				masterVo.permStartDate = '0000-00-00 00:00:00'
				masterVo.permEndDate =  '0000-00-00 00:00:00'
			}
			
			if(!validation())
			{
				return;
			}
			else
			{
				callPopupOnOk(masterVo);
				closeMyWindow();
			}
			
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
		
		protected function getOrgNameList():String 
		{
			var orgList:String = "";
			for (var i:int = 0; i < myWindow.deptArr.length; i++) 
			{
				orgList += myWindow.deptArr[i].orgId + "&";
				orgList += myWindow.deptArr[i].includeSubDept;
				orgList += "|";
			}
			return orgList;
		}
		
		//시리얼번호 읽어오는 루틴
		protected function getSerialNo(event:MouseEvent):void
		{	
			/*
			var snoList:String = "E:\\(SecureUSB),111111111111,1,1111|F:\\(NormalUSB),222222222222,0,2222|H:\\(Unknown),333333333333,10,3333"
			var usbVO:SusbmaUsbVO
			var useArray:Array = snoList.split("|");
			if(useArray.length > 1)
			{
				usbVO = new SusbmaUsbVO();
				//::SELECT::
				usbVO.drive = DmosFramework.getInstance().SNL('SC_PROMPT_SELECT');
				
				myWindow.usbArr.addItem(usbVO);
			}
			for(var i:int = 0; i < useArray.length; i++)
			{
				var useArray_:Array = String(useArray[i]).split(",");
				usbVO = new SusbmaUsbVO();
				usbVO.drive = String(useArray_[0]);
				usbVO.serialNo = String(useArray_[1]);
				usbVO.type = int(useArray_[2]);
				usbVO.instanceId = String(useArray_[3]);
				
				myWindow.usbArr.addItem(usbVO);
			}
			myWindow.drive.selectedIndex = 0;
			myWindow.drive.dispatchEvent(new IndexChangeEvent(IndexChangeEvent.CHANGE));
			
			myWindow.getSnoForm.visible = true;
			myWindow.getSnoForm.includeInLayout = true;
			*/
			
			myWindow.usbArr.removeAll();
			if(ExternalInterface.available)
			{
//				var snoList:String = ExternalInterface.call("GetSNO", DmosFramework.getInstance().CONFIG("SURECOGCODE","SMI:000000"), 1, DmosFramework.getInstance().CONFIG("NON_ACTIVEX"));
				var snoList:String = ExternalInterface.call("GetSNO", DmosFramework.getInstance().CONFIG("SURECOGCODE","SMI:000000"), 1, DmosFramework.getInstance().CONFIG("SAFERZONE_DAO_VERSION"));
				//var snoList:String = ExternalInterface.call("GetSNO", "SM:000000|SMI:000072", 1);
				//snoList = "Y:\\,SZSUEB000030000012,3";
				
				if(snoList == null || snoList == "")
					return;
				
				//____________________________________________________________________________________CC_v5.0 start 등록된 보안usb코드만 인식하도록 수정
				if(DmosFramework.getInstance().CUSTOMERID == CustomerId.CC_V5)
				{	
					var secureChkArr:Array = snoList.split(",");
					if(secureChkArr[1].toString().substr(0,6) != "SZSUEB")	return;
				}
				//____________________________________________________________________________________CC_v5.0 end
				
				//snoList 에는 장착된 USB개수 만큼의 USB정보가 들어옴
				//각 USB별 정보는 | 로 구분되어 있음
				//단일USB정보는   "드라이브,시리얼번호,type" 형식임
				
				//처리루틴 : 
				//결과로 수신한 목록을 | 로 split하여 자른후 각각을  , 로 split 하여 자른다
				//수신한 USB목록이 한개이면 
				//		ComboBox에 드라이브 정보를 넣는다.
				//		SerialNo : 에   시리얼번호를 넣는다.
				//		type은 서버로 전송시 코드값으로 사용한다.
				//수신한 목록이 여러개이면
				//		ComboBox에 "::SELECT:: + 드라이브목록을 넣는다.
				//		ComboBOx에서 선택을 하면 해당드라이브의 시리얼번호를 SerialNo에 넣는다.
				//		type은 서버전송시에 사용한다.
				
				var usbVO:SusbmaUsbVO
				var useArray:Array = snoList.split("|");
				if(useArray.length > 1)
				{
					usbVO = new SusbmaUsbVO();
					//::SELECT::
					usbVO.drive = DmosFramework.getInstance().SNL('SC_PROMPT_SELECT');
					
					myWindow.usbArr.addItem(usbVO);
				}
				for(var i:int = 0; i < useArray.length; i++)
				{
					var useArray_:Array = String(useArray[i]).split(",");
					usbVO = new SusbmaUsbVO();
					usbVO.drive = String(useArray_[0]);
					usbVO.serialNo = String(useArray_[1]);
					usbVO.type = int(useArray_[2]);
					usbVO.instanceId = String(useArray_[3]);
					
					myWindow.usbArr.addItem(usbVO);
				}
				myWindow.drive.selectedIndex = 0;
				myWindow.drive.dispatchEvent(new IndexChangeEvent(IndexChangeEvent.CHANGE));
				
				myWindow.getSnoForm.visible = true;
				myWindow.getSnoForm.includeInLayout = true;
			}
			else
			{
				Alert.show("!disable externalInterface");
			}
			
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
		
		private function callSnoSearchPopup(event:MouseEvent):void
		{
			snoPop = PopUpManager.createPopUp(ApplicationFacade(facade).application,
				SnoSearchPopup, true) as SnoSearchPopup;
			PopUpManager.centerPopUp(snoPop);
			
			
			snoPop.addEventListener(SnoSearchPopupEvent.CONFIRM, selectSnoHandler);
			snoPop.addEventListener(CloseEvent.CLOSE, closeSnoSearchPopupHandler);
		}
		
		private function selectSnoHandler(event:SnoSearchPopupEvent):void
		{
			myWindow.snoName.text = event.selectedItem.sno;
		}
		
		private function closeSnoSearchPopupHandler(event:CloseEvent):void
		{
			snoPop.removeEventListener(SnoSearchPopupEvent.CONFIRM, selectManagerHandler);
			snoPop.removeEventListener(CloseEvent.CLOSE, closeSnoSearchPopupHandler);
			
			PopUpManager.removePopUp(snoPop);
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
		
		private function closeDeptSearchPopupHandler(event:CloseEvent):void
		{
			deptPop.removeEventListener(DeptSearchPopupEvent.CONFIRM, deptSearchPopup_confirmHandler);
			deptPop.removeEventListener(CloseEvent.CLOSE, closeDeptSearchPopupHandler);
			PopUpManager.removePopUp(deptPop);
		}
		
		private function selectUserHandler(event:UserSearchPopupEvent):void
		{
			myWindow.userId.text = event.selectedEmp.empId;
			myWindow.userName.text = event.selectedEmp.empName;
		}
		
		
		private function closeUserSearchPopupHandler(event:CloseEvent):void
		{
			userPop.removeEventListener(UserSearchPopupEvent.CONFIRM, selectUserHandler);
			userPop.removeEventListener(CloseEvent.CLOSE, closeUserSearchPopupHandler);
			
			PopUpManager.removePopUp(userPop);
		}
		
//		private function indexChangeHandler(event:IndexChangeEvent):void
//		{
//			myWindow.serialNo.text = (event.currentTarget as DropDownList).selectedItem.serialNo;
//		}
		
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
					
					if(notification.getBody().hasOwnProperty(GlobalConst.CLASS_LIST))
					{
						myWindow.grade.dataProvider = notification.getBody()[GlobalConst.CLASS_LIST] as ArrayCollection;
						myWindow.grade.selectedIndex = 0;
						if(bUserIdEqaulMngId) myWindow.managerName.text = ApplicationFacade(facade).userId;
					}
					
					if(notification.getBody().hasOwnProperty(GlobalConst.MEDIA_TYPE_LIST))
					{
						myWindow.media.dataProvider = notification.getBody()[GlobalConst.MEDIA_TYPE_LIST] as IList;
						// myWindow.media.dataProvider.removeItemAt(1);
						myWindow.media.selectedIndex = 1;
					}
					
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
			myWindow.okBtn.addEventListener(MouseEvent.MOUSE_DOWN, okClickEventHandler);
			myWindow.cancelBtn.addEventListener(MouseEvent.MOUSE_DOWN, cancelClickEventHandler);
			myWindow.addEventListener(Event.CLOSE, closeHandler);
			
			myWindow.driveSearchBtn.addEventListener(MouseEvent.MOUSE_DOWN, getSerialNo);
			myWindow.manageNoSearchBtn.addEventListener(MouseEvent.MOUSE_DOWN, callManagerNumberSearchPopup);
			myWindow.managerSearchBtn.addEventListener(MouseEvent.MOUSE_DOWN, callManagerSearchPopup);
			myWindow.userSearchBtn.addEventListener(MouseEvent.MOUSE_DOWN, callUserSearchPopup);	
//			myWindow.addBtn.addEventListener(MouseEvent.MOUSE_DOWN, callDeptSearchPopup);
			myWindow.snoSearchBtn.addEventListener(MouseEvent.MOUSE_DOWN, callSnoSearchPopup);
		}
		
		override public function onRemove():void
		{
			myWindow.okBtn.removeEventListener(MouseEvent.MOUSE_DOWN, okClickEventHandler);
			myWindow.cancelBtn.removeEventListener(MouseEvent.MOUSE_DOWN, cancelClickEventHandler);
			myWindow.removeEventListener(Event.CLOSE, closeHandler);
			
			
			myWindow.driveSearchBtn.removeEventListener(MouseEvent.MOUSE_DOWN, getSerialNo);
			myWindow.manageNoSearchBtn.removeEventListener(MouseEvent.MOUSE_DOWN, callManagerNumberSearchPopup);
			myWindow.managerSearchBtn.removeEventListener(MouseEvent.MOUSE_DOWN, callManagerSearchPopup);
			myWindow.userSearchBtn.removeEventListener(MouseEvent.MOUSE_DOWN, callUserSearchPopup);
		}
		
		
		//--------------------------------------
		// protected 
		//--------------------------------------
		
		protected function validation():Boolean
		{
			var bool:Boolean;
			
			if(!isNonActiveX){
				if((myWindow.serialNo.text == null || myWindow.serialNo.text == ""))
				{
					Alert.show(DmosFramework.getInstance().SNL('SUSBMA_USBMANAGE_MESSAGE_NO_FOUND_DEVICE'),
						DmosFramework.getInstance().SNL("PROGRAMTITLE_D4_SUSBMA_USBMANAGE"));
					bool = false;
				}
				else
				{
					bool = true;
				}
			}else{
				bool = true;
			}
			return bool;
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
