package com.saferzone.defcon4.susbma.inventory.view
{
	import com.saferzone.defcon4.common.DmosFramework;
	import com.saferzone.defcon4.common.SZPopupMediator;
	import com.saferzone.defcon4.common.consts.CustomerId;
	import com.saferzone.defcon4.common.consts.GlobalConst;
	import com.saferzone.defcon4.common.utils.SZUtil;
	import com.saferzone.defcon4.services.vo.SusbmaInventoryStatusVO;
	import com.saferzone.defcon4.susbma.inventory.ApplicationFacade;
	import com.saferzone.defcon4.susbma.inventory.view.comp.UsbInventoryStatusAddPopup;
	import com.saferzone.defcon4.susbma.inventory.view.comp.UsbInventoryStatusDelPopup;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.managers.PopUpManager;
	import mx.validators.Validator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	/**
	 * USB재고현황 - 재고삭제 팝업 미디에이터
	 * 재고삭제 관련 중재자 역할
	 * @author lmj
	 */	
	public class UsbInventoryStatusDelPopupMediator extends SZPopupMediator
	{
		//------------------------------------------------------------------------------
		//
		// Constants 
		//
		//------------------------------------------------------------------------------
		
		public static const NAME:String = 'UsbInventoryStatusDelPopupMediator';
		
		//------------------------------------------------------------------------------
		//
		// Constructor 
		//
		//------------------------------------------------------------------------------
		
		public function UsbInventoryStatusDelPopupMediator(viewComponent:Object)
		{
			super(NAME, viewComponent);
		}
		
		
		//------------------------------------------------------------------------------
		//
		// Properties #public 
		//
		//------------------------------------------------------------------------------
		
		public function get myWindow():UsbInventoryStatusDelPopup
		{
			return viewComponent as UsbInventoryStatusDelPopup;
		}
		
		/**
		 * USB시리얼번호 Array 
		 */		
		private var statusArr:Array = [];
		
		/**
		 *  SusbmaInventoryStatusVO
		 */		
		private var statusVO:SusbmaInventoryStatusVO = new SusbmaInventoryStatusVO();
		
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
			statusVO = new SusbmaInventoryStatusVO();
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
			
			if(myWindow.inventoryReason.text == "" || myWindow.inventoryReason.text == null) {			//입고사유 null일 경우
				Alert.show(DmosFramework.getInstance().SNL('SC_PLEASE_ENTER_THE_REASON_D4'), DmosFramework.getInstance().SNL('SC_REGISTRATION_STOC_D4'));
				return;
			} 
			else {
				statusVO.inventoryReason = myWindow.inventoryReason.text;
			}
			
			ApplicationFacade(facade).statusVo = statusVO;
			callPopupOnOk(ApplicationFacade(facade).statusVo);
			closeMyWindow();
		}
		
		/**
		 * USB번호 일련번호 추출
		 * @param sno
		 * @return 
		 * 
		 */		
		private function changeSno(sno:String, len:int):String
		{
			var str:String = sno.substr(sno.length-len, len); 		
			return str;
			
		}
		
		protected function cancelClickEventHandler(event:MouseEvent):void
		{
			closeMyWindow();
		}
		
		private function closeHandler(event:Event):void
		{
			closeMyWindow();
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
			];
		}
		
		/**
		 * 처리할 notification
		 */
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				default : break;
			}
		}
		
		/**
		 * mediator 등록 시
		 */
		override public function onRegister():void
		{
			myWindow.okBtn.addEventListener(MouseEvent.MOUSE_DOWN, okClickEventHandler);
			myWindow.cancelBtn.addEventListener(MouseEvent.MOUSE_DOWN, cancelClickEventHandler);
			myWindow.addEventListener(Event.CLOSE, closeHandler);
		}
		
		/**
		 * mediator 제거 시
		 */
		override public function onRemove():void
		{
			myWindow.okBtn.removeEventListener(MouseEvent.MOUSE_DOWN, okClickEventHandler);
			myWindow.cancelBtn.removeEventListener(MouseEvent.MOUSE_DOWN, cancelClickEventHandler);
			myWindow.removeEventListener(Event.CLOSE, closeHandler);
		}
		
		//--------------------------------------
		// public 
		//--------------------------------------
		
		public function setSearchCondition(vo:SusbmaInventoryStatusVO):void
		{
			if(DmosFramework.getInstance().CUSTOMERID == CustomerId.HUNDAIKIA){
				myWindow.startCharacter.text =  changeSno(vo.inventorySno, 6).substr(0, 2);	
				myWindow.startInventorySno.text = changeSno(vo.inventorySno, 4);
			}else{
				myWindow.startInventorySno.text = changeSno(vo.inventorySno, 6);	
			}
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