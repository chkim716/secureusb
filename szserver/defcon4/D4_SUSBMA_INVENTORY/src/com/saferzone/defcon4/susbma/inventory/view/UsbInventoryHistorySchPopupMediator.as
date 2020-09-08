package com.saferzone.defcon4.susbma.inventory.view
{
	import com.saferzone.defcon4.common.DmosFramework;
	import com.saferzone.defcon4.common.SZPopupMediator;
	import com.saferzone.defcon4.common.consts.CustomerId;
	import com.saferzone.defcon4.common.consts.GlobalConst;
	import com.saferzone.defcon4.common.utils.SZUtil;
	import com.saferzone.defcon4.services.vo.SusbmaInventoryHistoryVO;
	import com.saferzone.defcon4.susbma.inventory.ApplicationFacade;
	import com.saferzone.defcon4.susbma.inventory.view.comp.UsbInventoryHistorySchPopup;
	import com.saferzone.defcon4.susbma.inventory.view.comp.UsbInventoryStatusAddPopup;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.managers.PopUpManager;
	import mx.validators.Validator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	/**
	 * USB재고이력 - 이력검색 팝업 미디에이터 
	 * 이력검색 관련 중재자 역할
	 * @author lmj
	 */	
	public class UsbInventoryHistorySchPopupMediator extends SZPopupMediator
	{
		//------------------------------------------------------------------------------
		//
		// Constants 
		//
		//------------------------------------------------------------------------------
		
		public static const NAME:String = 'UsbInventoryHistorySchPopupMediator';
		
		//------------------------------------------------------------------------------
		//
		// Constructor 
		//
		//------------------------------------------------------------------------------
		
		public function UsbInventoryHistorySchPopupMediator(viewComponent:Object)
		{
			super(NAME, viewComponent);
		}
		
		
		//------------------------------------------------------------------------------
		//
		// Properties #public 
		//
		//------------------------------------------------------------------------------
		
		public function get myWindow():UsbInventoryHistorySchPopup
		{
			return viewComponent as UsbInventoryHistorySchPopup;
		}
		
		/**
		 *  SusbmaInventoryHistoryVO
		 */		
		private var historyVo:SusbmaInventoryHistoryVO;
		
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
			if(Number(SZUtil.replaceAll(myWindow.startRegDate.text,'-','')) 
				> Number(SZUtil.replaceAll(myWindow.endRegDate.text,'-',''))) {						//시작일자가 종료일자보다 클 경우 return 처리 
				Alert.show(DmosFramework.getInstance().SNL("SC_PROMPT_INVALID_PERIOD"), DmosFramework.getInstance().SNL('SC_SEARCH'));
				return;
			}
			
			if(DmosFramework.getInstance().CUSTOMERID == CustomerId.HUNDAIKIA){
				ApplicationFacade(facade).historyVo.startCharacter = myWindow.startCharacter.text;
			}
			
			if(!myWindow.isRange.selected){	
				ApplicationFacade(facade).historyVo.startInventorySno = myWindow.startInventorySno.text;
				ApplicationFacade(facade).historyVo.endInventorySno = null;
			}else{
				if(int(myWindow.startInventorySno.text) > int(myWindow.endInventorySno.text)) {			//시작USB번호가 종료USB번호보다 클 경우 오류메세지 
					ApplicationFacade(facade).historyVo.startInventorySno = myWindow.endInventorySno.text;
					ApplicationFacade(facade).historyVo.endInventorySno =  myWindow.startInventorySno.text;
				}else{
					ApplicationFacade(facade).historyVo.startInventorySno = myWindow.startInventorySno.text;
					ApplicationFacade(facade).historyVo.endInventorySno = myWindow.endInventorySno.text;
				}	
			}
			
			//historyVo = new SusbmaInventoryHistoryVO();
			ApplicationFacade(facade).historyVo.startRegDate = SZUtil.replaceAll(myWindow.startRegDate.text,'-',''); 
			ApplicationFacade(facade).historyVo.endRegDate = SZUtil.replaceAll(myWindow.endRegDate.text,'-',''); 
			ApplicationFacade(facade).historyVo.userEmpId = myWindow.userEmpId.text;
			ApplicationFacade(facade).historyVo.userEmpName = myWindow.userEmpName.text;

			callPopupOnOk(ApplicationFacade(facade).historyVo);
			closeMyWindow();
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
		
		public function setSearchCondition(vo:SusbmaInventoryHistoryVO):void
		{
			
			if(vo.startRegDate == null || vo.startRegDate == "") {
				myWindow.startRegDate.selectedDate = SZUtil.dateAdd("YYYY", -5);
			} else {
				myWindow.startRegDate.selectedDate =
					new Date(vo.startRegDate.substr(0, 4),
						int(vo.startRegDate.substr(4, 2)) - 1,
						vo.startRegDate.substr(6, 2));
			}
			
			if(vo.endRegDate == null || vo.endRegDate == "") {
				myWindow.endRegDate.selectedDate = SZUtil.dateAdd("YYYY");
			} else {
				myWindow.endRegDate.selectedDate =
					new Date(vo.endRegDate.substr(0, 4),
						int(vo.endRegDate.substr(4, 2)) - 1,
						vo.endRegDate.substr(6, 2));
			}
			
			if(DmosFramework.getInstance().CUSTOMERID == CustomerId.HUNDAIKIA){
				myWindow.startCharacter.text = vo.startCharacter;
			}
			
			myWindow.startInventorySno.text = vo.startInventorySno;
			myWindow.endInventorySno.text = vo.endInventorySno;
			myWindow.userEmpId.text = vo.userEmpId;
			myWindow.userEmpName.text = vo.userEmpName;
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