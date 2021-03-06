package com.saferzone.defcon4.susbma.inventory.view
{
	import com.saferzone.defcon4.common.DmosFramework;
	import com.saferzone.defcon4.common.SZPopupMediator;
	import com.saferzone.defcon4.common.components.DeptSearchPopup;
	import com.saferzone.defcon4.common.components.MNSearchPopup;
	import com.saferzone.defcon4.common.consts.CustomerId;
	import com.saferzone.defcon4.common.consts.GlobalConst;
	import com.saferzone.defcon4.common.events.DeptSearchPopupEvent;
	import com.saferzone.defcon4.common.events.MNSearchPopupEvent;
	import com.saferzone.defcon4.common.events.UserSearchPopupEvent;
	import com.saferzone.defcon4.common.utils.SZUtil;
	import com.saferzone.defcon4.services.vo.SYSBaseOrgVO;
	import com.saferzone.defcon4.services.vo.SusbmaInventoryStatusVO;
	import com.saferzone.defcon4.susbma.inventory.ApplicationFacade;
	import com.saferzone.defcon4.susbma.inventory.view.comp.UsbInventoryStatusAddPopup;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	import mx.messaging.SubscriptionInfo;
	import mx.validators.Validator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;

	/**
	 * USB재고현황 - 재고등록 팝업 미디에이터 
	 * 재고등록 관련 중재자 역할
	 * @author lmj
	 */	
	public class UsbInventoryStatusAddPopupMediator extends SZPopupMediator
	{
		/**
		 * Constants
		 */		
		public static const NAME:String = 'UsbInventoryStatusAddPopupMediator';
		
		/**
		 * Constructor
		 * @param viewComponent
		 */		
		public function UsbInventoryStatusAddPopupMediator(viewComponent:Object)
		{
			super(NAME, viewComponent);
		}
		
		/**
		 * 컴포넌트 get 함수
		 * @return viewComponent
		 */		
		public function get myWindow():UsbInventoryStatusAddPopup
		{
			return viewComponent as UsbInventoryStatusAddPopup;
		}
		
		/**
		 * USB시리얼번호 Array 
		 */		
		private var statusArr:Array = [];
		
		/**
		 *  SusbmaInventoryStatusVO
		 */		
		private var statusVO:SusbmaInventoryStatusVO;
		
		/**
		 * 부서검색 팝업 
		 */
		private var deptPop:DeptSearchPopup; 
		
		//관리번호 팝업처리
		private var managerNumberPop:MNSearchPopup;
		
		
		/**
		 * 등록 버튼 클릭 Event Listener
		 */
		protected function okClickEventHandler(event:MouseEvent):void
		{
			statusVO = new SusbmaInventoryStatusVO();
			
			statusVO.secureUsbType = myWindow.secureUsbType.selectedItem.value;
			if(DmosFramework.getInstance().CUSTOMERID == CustomerId.HUNDAIKIA){
				if(myWindow.startCharacter.text == "")
				{
					Alert.show(DmosFramework.getInstance().SNL('SC_PLEASE_ENTER_THE_SNO_D4'), DmosFramework.getInstance().SNL('SC_REGISTRATION_STOC_D4'));
					myWindow.startCharacter.setFocus();
					return;
				}	
				
				statusVO.startCharacter = myWindow.startCharacter.text;
			}
			
			if(!myWindow.isRange.selected){
				if(myWindow.startInventorySno.text == "")
				{
					Alert.show(DmosFramework.getInstance().SNL('SC_PLEASE_ENTER_THE_SNO_D4'), DmosFramework.getInstance().SNL('SC_REGISTRATION_STOC_D4'));
					myWindow.startInventorySno.setFocus();
					return;
				}	

				statusVO.startInventorySno = myWindow.startInventorySno.text;
				statusVO.endInventorySno = null;
				
			}else{
				if(myWindow.startInventorySno.text == "")
				{
					Alert.show(DmosFramework.getInstance().SNL('SC_PLEASE_ENTER_THE_SNO_D4'), DmosFramework.getInstance().SNL('SC_REGISTRATION_STOC_D4'));
					myWindow.startInventorySno.setFocus();
					return;
				}	
				
				if(myWindow.endInventorySno.text == "")
				{
					Alert.show(DmosFramework.getInstance().SNL('SC_PLEASE_ENTER_THE_SNO_D4'), DmosFramework.getInstance().SNL('SC_REGISTRATION_STOC_D4'));
					myWindow.endInventorySno.setFocus();
					return;
				}	
				
				if(int(myWindow.startInventorySno.text) > int(myWindow.endInventorySno.text)) {			//시작USB번호가 종료USB번호보다 클 경우 오류메세지 
					statusVO.startInventorySno = myWindow.endInventorySno.text;
					statusVO.endInventorySno =  myWindow.startInventorySno.text;
				}else{
					statusVO.startInventorySno = myWindow.startInventorySno.text;
					statusVO.endInventorySno = myWindow.endInventorySno.text;
				}
			}
			
			if(myWindow.capacity.text == "" || myWindow.capacity.text == null || myWindow.capacity.text == '0') {						//용량 null일 경우
				Alert.show(DmosFramework.getInstance().SNL('SC_PLEASE_ENTER_THE_USAGE_D4'),DmosFramework.getInstance().SNL('SC_REGISTRATION_STOC_D4'));
				myWindow.capacity.setFocus();
				return;
			} 
			else {
				statusVO.capacity = int(myWindow.capacity.text);
			}
			
			
			statusVO.dataCapacity = myWindow.dataCapacity.text==""?0:int(myWindow.dataCapacity.text);
			
			if(myWindow.isoVersion.text == "" || myWindow.isoVersion.text == null || myWindow.isoVersion.text == '0') {
				Alert.show(DmosFramework.getInstance().SNL('SC_PLEASE_ENTER_THE_ISO_D4'), DmosFramework.getInstance().SNL('SC_REGISTRATION_STOC_D4'));
				myWindow.isoVersion.setFocus();
				return;
			}else{
				statusVO.isoVersion = myWindow.isoVersion.text;
			}
			
			
			if(DmosFramework.getInstance().CUSTOMERID != CustomerId.SFA)
			{
				if(myWindow.deptName.text == "" || myWindow.deptName.text == null) {						//부서 null일 경우
					Alert.show(DmosFramework.getInstance().SNL('SC_PLEASE_SELECT_THE_DEPT_D4'), DmosFramework.getInstance().SNL('SC_REGISTRATION_STOC_D4'));
					return;
				} 
				else {
					statusVO.targetCode = myWindow.deptId.text;
				}
			
				if(myWindow.inventoryReason.text == "" || myWindow.inventoryReason.text == null) {			//입고사유 null일 경우
					Alert.show(DmosFramework.getInstance().SNL('SC_PLEASE_ENTER_THE_REASON_D4'), DmosFramework.getInstance().SNL('SC_REGISTRATION_STOC_D4'));
					return;
				} 
				else {
					statusVO.inventoryReason = myWindow.inventoryReason.text;
				}
			}
			else
			{
				if(myWindow.sfa_mngCode.text == "" || myWindow.sfa_mngCode.text == null) {			//입고사유 null일 경우
					Alert.show(DmosFramework.getInstance().SNL('SC_PLEASE_ENTER_THE_MNGCODE'), DmosFramework.getInstance().SNL('SC_REGISTRATION_STOC_D4'));
					return;
				} 
				else {
					statusVO.sfa_mngCode = myWindow.sfa_mngCode.text;
				}
				
				statusVO.sfa_office = int(myWindow.sfa_office.selectedItem.officeId);
			}
			
			
			
			
			ApplicationFacade(facade).statusVo = statusVO;
			callPopupOnOk(ApplicationFacade(facade).statusVo);
			closeMyWindow();
		}
		
		//부서검색 버튼 클릭 시
		private function callSearchPopup(event:MouseEvent):void
		{
			deptPop = PopUpManager.createPopUp(ApplicationFacade(facade).application, DeptSearchPopup, true) as DeptSearchPopup;
			deptPop.useIncludeSubDeptOption = false;
			PopUpManager.centerPopUp(deptPop);
			deptPop.addEventListener(UserSearchPopupEvent.CONFIRM, deptSearchPopup_confirmHandler);
			deptPop.addEventListener(CloseEvent.CLOSE, closeDeptSearchPopupHandler);
		}
		
		//부서검색 저장 핸들러
		protected function deptSearchPopup_confirmHandler(event:DeptSearchPopupEvent):void
		{
			var selectedDept:SYSBaseOrgVO = event.selectedDept as SYSBaseOrgVO;
			myWindow.deptName.text = selectedDept.orgName;
			myWindow.deptId.text   = event.selectedDept.orgId;
		}
		
		//부서검색팝업 닫기 핸들러
		private function closeDeptSearchPopupHandler(event:CloseEvent):void
		{
			deptPop.removeEventListener(DeptSearchPopupEvent.CONFIRM, deptSearchPopup_confirmHandler);
			deptPop.removeEventListener(CloseEvent.CLOSE, closeDeptSearchPopupHandler);
			PopUpManager.removePopUp(deptPop);
		}
		
		/**
		 * 취소 버튼 클릭 Event Listener
		 */
		protected function cancelClickEventHandler(event:MouseEvent):void
		{
			closeMyWindow();
		}
		
		/**
		 * 닫기 버튼 클릭 Event Listener
		 */		
		private function closeHandler(event:Event):void
		{
			closeMyWindow();
		}
		
		/**
		 * 관심있는 notification
		 */
		override public function listNotificationInterests():Array
		{
			return [
			];
		}
		
		/**
		 * 처리할 notification
		 */
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				default:
					break;
			}
		}
		
		private function callManagerNumberSearchPopup(event:MouseEvent):void
		{
			managerNumberPop = PopUpManager.createPopUp(ApplicationFacade(facade).application, MNSearchPopup, true) as MNSearchPopup;
			PopUpManager.centerPopUp(managerNumberPop);
			
			managerNumberPop.addEventListener(MNSearchPopupEvent.CONFIRM, selectManagerNumberHandler);
			managerNumberPop.addEventListener(CloseEvent.CLOSE, closeManagerNumberSearchPopupHandler);
		}
		
		private function selectManagerNumberHandler(event:MNSearchPopupEvent):void
		{
			myWindow.sfa_mngCode.text = event.selectedItem.managementId;
		}
		
		private function closeManagerNumberSearchPopupHandler(event:CloseEvent):void
		{
			managerNumberPop.removeEventListener(MNSearchPopupEvent.CONFIRM, selectManagerNumberHandler);
			managerNumberPop.removeEventListener(CloseEvent.CLOSE, closeManagerNumberSearchPopupHandler);
			
			PopUpManager.removePopUp(managerNumberPop);
		}
		
		override public function onRegister():void
		{
			myWindow.okBtn.addEventListener(MouseEvent.MOUSE_DOWN, okClickEventHandler);
			myWindow.cancelBtn.addEventListener(MouseEvent.MOUSE_DOWN, cancelClickEventHandler);
			myWindow.addEventListener(Event.CLOSE, closeHandler);
			myWindow.searchBtn.addEventListener(MouseEvent.MOUSE_DOWN, callSearchPopup);
			myWindow.manageNoSearchBtn.addEventListener(MouseEvent.MOUSE_DOWN, callManagerNumberSearchPopup);
		}
		
		override public function onRemove():void
		{
			myWindow.okBtn.removeEventListener(MouseEvent.MOUSE_DOWN, okClickEventHandler);
			myWindow.cancelBtn.removeEventListener(MouseEvent.MOUSE_DOWN, cancelClickEventHandler);
			myWindow.removeEventListener(Event.CLOSE, closeHandler);
			myWindow.searchBtn.removeEventListener(MouseEvent.MOUSE_DOWN, callSearchPopup);
			myWindow.manageNoSearchBtn.removeEventListener(MouseEvent.MOUSE_DOWN, callManagerNumberSearchPopup);
		}
		
		private function closeMyWindow():void
		{
			PopUpManager.removePopUp(myWindow);
			facade.removeMediator(NAME);
		}
	}
}