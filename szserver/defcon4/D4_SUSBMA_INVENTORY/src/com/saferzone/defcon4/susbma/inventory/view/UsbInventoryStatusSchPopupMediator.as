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
	import com.saferzone.defcon4.susbma.inventory.view.comp.UsbInventoryStatusSchPopup;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.managers.PopUpManager;
	import mx.validators.Validator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	/**
	 * USB재고현황 - 재고검색 팝업 미디에이터
	 * 재고검색 관련 중재자 역할
	 * @author lmj
	 */	
	public class UsbInventoryStatusSchPopupMediator extends SZPopupMediator
	{
		//------------------------------------------------------------------------------
		//
		// Constants 
		//
		//------------------------------------------------------------------------------
		
		public static const NAME:String = 'UsbInventoryStatusSchPopupMediator';
		
		//------------------------------------------------------------------------------
		//
		// Constructor 
		//
		//------------------------------------------------------------------------------
		
		public function UsbInventoryStatusSchPopupMediator(viewComponent:Object)
		{
			super(NAME, viewComponent);
		}
		
		
		//------------------------------------------------------------------------------
		//
		// Properties #public 
		//
		//------------------------------------------------------------------------------
		
		public function get myWindow():UsbInventoryStatusSchPopup
		{
			return viewComponent as UsbInventoryStatusSchPopup;
		}
		
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
			if(Number(SZUtil.replaceAll(myWindow.startStockDate.text,'-','')) 
				> Number(SZUtil.replaceAll(myWindow.endStockDate.text,'-',''))) {					//시작일자가 종료일자보다 클 경우 return처리
				Alert.show(DmosFramework.getInstance().SNL("SC_PROMPT_INVALID_PERIOD"), DmosFramework.getInstance().SNL('SC_CHECK_THE_STOC_D4'));
				return;
			}
			
			ApplicationFacade(facade).statusVo..secureUsbType = myWindow.secureUsbType.selectedItem.value;
			
			if(DmosFramework.getInstance().CUSTOMERID == CustomerId.HUNDAIKIA){
				ApplicationFacade(facade).statusVo..startCharacter = myWindow.startCharacter.text;
			}
			
			if(!myWindow.isRange.selected){	
				ApplicationFacade(facade).statusVo.startInventorySno = myWindow.startInventorySno.text;
				ApplicationFacade(facade).statusVo.endInventorySno = null;
			}else{
				if(int(myWindow.startInventorySno.text) > int(myWindow.endInventorySno.text)) {			//시작USB번호가 종료USB번호보다 클 경우 오류메세지 
					ApplicationFacade(facade).statusVo.startInventorySno = myWindow.endInventorySno.text;
					ApplicationFacade(facade).statusVo.endInventorySno =  myWindow.startInventorySno.text;
				}else{
					ApplicationFacade(facade).statusVo.startInventorySno = myWindow.startInventorySno.text;
					ApplicationFacade(facade).statusVo.endInventorySno = myWindow.endInventorySno.text;
				}	
			}
			ApplicationFacade(facade).statusVo.startStockDate = SZUtil.replaceAll(myWindow.startStockDate.text,'-','');
			ApplicationFacade(facade).statusVo.endStockDate = SZUtil.replaceAll(myWindow.endStockDate.text,'-','');
		
			if(myWindow.capacity.text == "" || myWindow.capacity.text == null) {					//용량 null일 경우
				ApplicationFacade(facade).statusVo.capacity = -1;
			} else {
				ApplicationFacade(facade).statusVo.capacity = int(myWindow.capacity.text);
			}
			
			ApplicationFacade(facade).statusVo.creator = myWindow.creator.text;
			ApplicationFacade(facade).statusVo.isUsed = myWindow.isUsed.selectedItem.value;
			ApplicationFacade(facade).statusVo.receive = myWindow.receive.selectedItem.value;
			
			ApplicationFacade(facade).statusVo.sfa_mngCode = myWindow.sfa_mngCode.text;
			ApplicationFacade(facade).statusVo.sfa_office = myWindow.sfa_office.selectedItem.value;
			ApplicationFacade(facade).statusVo.sfa_state = myWindow.sfa_state.selectedItem.value;
			
			ApplicationFacade(facade).statusVo.isoVersion = myWindow.isoVersion.text;
			
			callPopupOnOk(ApplicationFacade(facade).statusVo);
			closeMyWindow();
		}
		
		public function setSearchCondition(vo:SusbmaInventoryStatusVO):void
		{
			myWindow.secureUsbType.selectedIndex = SZUtil.getIndexItem(String(vo.secureUsbType),
				ArrayCollection(myWindow.secureUsbType.dataProvider),"value");
			
			if(vo.startStockDate == null || vo.startStockDate == "")
			{
				myWindow.startStockDate.selectedDate = SZUtil.dateAdd("YYYY", -5);
			}
			else
			{
				myWindow.startStockDate.selectedDate = new Date(vo.startStockDate.substr(0,
					4),
					int(vo.startStockDate.substr(4,
						2)) - 1,
					vo.startStockDate.substr(6,
						2));
			}
			
			if(vo.endStockDate == null || vo.endStockDate == "")
			{
				myWindow.endStockDate.selectedDate = SZUtil.dateAdd("YYYY");
			}
			else
			{
				myWindow.endStockDate.selectedDate = new Date(vo.endStockDate.substr(0, 4),
					int(vo.endStockDate.substr(4,
						2)) - 1,
					vo.endStockDate.substr(6, 2));
				;
			}
			if(DmosFramework.getInstance().CUSTOMERID == CustomerId.HUNDAIKIA){
				myWindow.startCharacter.text = vo.startCharacter;
			}
			myWindow.startInventorySno.text = vo.startInventorySno;
			myWindow.endInventorySno.text = vo.endInventorySno;
			if(vo.capacity == -1){
				myWindow.capacity.text = "";	
			}else{
				myWindow.capacity.text = String(vo.capacity);
			}
			
			myWindow.creator.text = vo.creator;
			myWindow.isUsed.selectedIndex = SZUtil.getIndexItem(String(vo.isUsed),
				ArrayCollection(myWindow.isUsed.dataProvider),"value");
			myWindow.receive.selectedIndex = SZUtil.getIndexItem(String(vo.receive),
				ArrayCollection(myWindow.receive.dataProvider),"value");
			
			myWindow.sfa_mngCode.text = vo.sfa_mngCode;
			myWindow.sfa_office.selectedIndex = SZUtil.getIndexItem(String(vo.sfa_office),
				ArrayCollection(myWindow.sfa_office.dataProvider),"value");
			myWindow.sfa_state.selectedIndex = SZUtil.getIndexItem(String(vo.sfa_state),
				ArrayCollection(myWindow.sfa_state.dataProvider),"value");
			
			myWindow.isoVersion.text = vo.isoVersion;
			
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
		// private 
		//--------------------------------------
		
		private function closeMyWindow():void
		{
			PopUpManager.removePopUp(myWindow);
			facade.removeMediator(NAME);
		}
	}
}